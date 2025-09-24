import 'package:workmanager/workmanager.dart';

import 'pdf_service.dart';

const String kOvernightTask = 'overnight_ppt_downloads';

class SchedulerService {
  bool _initialized = false;

  Future<void> initializeWorkmanager() async {
    if (_initialized) return;
    await Workmanager().initialize(
      _callbackDispatcher,
      isInDebugMode: false,
    );
    _initialized = true;
  }

  Future<void> scheduleOvernightDownloads() async {
    // Schedule to run between 2-6 AM; we use constraints to require unmetered if possible
    await Workmanager().registerPeriodicTask(
      'overnight-task',
      kOvernightTask,
      frequency: const Duration(hours: 24),
      initialDelay: _computeInitialDelayTo2AM(),
      constraints: Constraints(
        networkType: NetworkType.connected,
        requiresBatteryNotLow: true,
      ),
      backoffPolicy: BackoffPolicy.linear,
    );
  }

  Duration _computeInitialDelayTo2AM() {
    final now = DateTime.now();
    DateTime target = DateTime(now.year, now.month, now.day, 2);
    if (now.isAfter(target)) {
      target = target.add(const Duration(days: 1));
    }
    return target.difference(now);
  }
}

@pragma('vm:entry-point')
void _callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == kOvernightTask) {
      // In a real app, fetch teacher-published PDF URLs from server
      final List<Map<String, String>> mock = [
        {
          'url': 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
          'title': 'Tomorrow_Class_Slides'
        }
      ];
      final PdfService pdfService = PdfService();
      for (final item in mock) {
        try {
          await pdfService.downloadAndSavePdf(url: item['url']!, title: item['title']!);
        } catch (_) {}
      }
    }
    return Future.value(true);
  });
}


