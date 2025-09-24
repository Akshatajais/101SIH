
import 'package:flutter/material.dart';

import '../services/pdf_service.dart';
import '../services/scheduler_service.dart';
import 'classroom_screen.dart';

class DashboardScreen extends StatefulWidget {
  static const String routeName = '/';
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final PdfService _pdfService;
  late final SchedulerService _schedulerService;

  @override
  void initState() {
    super.initState();
    _pdfService = PdfService();
    _schedulerService = SchedulerService();
    _schedulerService.initializeWorkmanager();
  }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateTime nextClassTime = DateTime(now.year, now.month, now.day, 9);
    final bool isTodayPast = now.isAfter(nextClassTime);
    final DateTime effectiveClassTime = isTodayPast
        ? nextClassTime.add(const Duration(days: 1))
        : nextClassTime;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Classroom'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Upcoming Class',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Starts at: ${_formatTime(effectiveClassTime)}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      ClassroomScreen.routeName,
                      arguments: const ClassroomArgs(
                        audioStreamUrl: 'https://stream.live.vc.bbcmedia.co.uk/bbc_world_service',
                      ),
                    );
                  },
                  child: const Text('Join Class'),
                ),
                OutlinedButton(
                  onPressed: () async {
                    await _schedulerService.scheduleOvernightDownloads();
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Overnight PPT downloads scheduled')),
                    );
                  },
                  child: const Text('Download PPT Overnight'),
                ),
                OutlinedButton(
                  onPressed: () async {
                    try {
                      await _pdfService.downloadAndSavePdf(
                        url: 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
                        title: 'Demo_Slides',
                      );
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Demo PDF installed')),
                      );
                      setState(() {});
                    } catch (e) {
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to install demo PDF: $e')),
                      );
                    }
                  },
                  child: const Text('Install Demo PDF'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Downloaded PPTs',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: FutureBuilder<List<LocalPdf>>(
                future: _pdfService.listDownloadedPdfs(),
                builder: (context, snapshot) {
                  final items = snapshot.data ?? [];
                  if (items.isEmpty) {
                    return const Center(child: Text('No PDFs downloaded'));
                  }
                  return ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return ListTile(
                        title: Text(item.title),
                        subtitle: Text('${(item.sizeBytes / (1024 * 1024)).toStringAsFixed(2)} MB'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () async {
                            await _pdfService.deletePdf(item.filePath);
                            setState(() {});
                          },
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            ClassroomScreen.routeName,
                            arguments: ClassroomArgs(
                              audioStreamUrl: 'https://stream.live.vc.bbcmedia.co.uk/bbc_world_service',
                              initialPdfPath: item.filePath,
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime dt) {
    String two(int v) => v.toString().padLeft(2, '0');
    final String hh = two(dt.hour % 12 == 0 ? 12 : dt.hour % 12);
    final String mm = two(dt.minute);
    final String ampm = dt.hour >= 12 ? 'PM' : 'AM';
    return '$hh:$mm $ampm';
  }
}


