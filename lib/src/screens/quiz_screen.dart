import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  bool quizCompleted = false;
  List<int> selectedAnswers = [];

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'What is the capital of India?',
      'options': ['Mumbai', 'Delhi', 'Kolkata', 'Chennai'],
      'correct': 1,
    },
    {
      'question': 'Which programming language is used for Flutter development?',
      'options': ['Java', 'Dart', 'Python', 'JavaScript'],
      'correct': 1,
    },
    {
      'question': 'What does API stand for?',
      'options': [
        'Application Programming Interface',
        'Advanced Programming Interface',
        'Automated Programming Interface',
        'Application Process Interface'
      ],
      'correct': 0,
    },
    {
      'question': 'Which of the following is a NoSQL database?',
      'options': ['MySQL', 'PostgreSQL', 'MongoDB', 'SQLite'],
      'correct': 2,
    },
    {
      'question': 'What is the primary purpose of version control?',
      'options': [
        'To store files',
        'To track changes in code',
        'To compile programs',
        'To debug applications'
      ],
      'correct': 1,
    },
  ];

  @override
  void initState() {
    super.initState();
    selectedAnswers = List.filled(questions.length, -1);
  }

  void selectAnswer(int answerIndex) {
    setState(() {
      selectedAnswers[currentQuestionIndex] = answerIndex;
    });
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      _calculateScore();
      setState(() {
        quizCompleted = true;
      });
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  void _calculateScore() {
    score = 0;
    for (int i = 0; i < questions.length; i++) {
      if (selectedAnswers[i] == questions[i]['correct']) {
        score++;
      }
    }
  }

  void resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      score = 0;
      quizCompleted = false;
      selectedAnswers = List.filled(questions.length, -1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          'Quiz Challenge',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF2196F3),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: quizCompleted ? _buildResultScreen() : _buildQuizScreen(),
    );
  }

  Widget _buildQuizScreen() {
    final question = questions[currentQuestionIndex];
    final progress = (currentQuestionIndex + 1) / questions.length;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Progress indicator
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Question ${currentQuestionIndex + 1} of ${questions.length}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF333333),
                      ),
                    ),
                    Text(
                      '${(progress * 100).toInt()}%',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2196F3),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: const Color(0xFFE3F2FD),
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2196F3)),
                  minHeight: 8,
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // Question card
          Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.quiz,
                  color: Color(0xFF2196F3),
                  size: 30,
                ),
                const SizedBox(height: 15),
                Text(
                  question['question'],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // Options
          Expanded(
            child: ListView.builder(
              itemCount: question['options'].length,
              itemBuilder: (context, index) {
                final isSelected = selectedAnswers[currentQuestionIndex] == index;
                final option = question['options'][index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  child: InkWell(
                    onTap: () => selectAnswer(index),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF2196F3) : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? const Color(0xFF2196F3) : const Color(0xFFE0E0E0),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.white : const Color(0xFFF5F5F5),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected ? Colors.white : const Color(0xFFE0E0E0),
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                String.fromCharCode(65 + index), // A, B, C, D
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? const Color(0xFF2196F3) : const Color(0xFF666666),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Text(
                              option,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: isSelected ? Colors.white : const Color(0xFF333333),
                              ),
                            ),
                          ),
                          if (isSelected)
                            const Icon(
                              Icons.check_circle,
                              color: Colors.white,
                              size: 24,
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Navigation buttons
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                if (currentQuestionIndex > 0)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: previousQuestion,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF2196F3),
                        side: const BorderSide(color: Color(0xFF2196F3), width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text(
                        'Previous',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                if (currentQuestionIndex > 0) const SizedBox(width: 15),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: selectedAnswers[currentQuestionIndex] != -1 ? nextQuestion : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2196F3),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text(
                      currentQuestionIndex == questions.length - 1 ? 'Finish Quiz' : 'Next',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultScreen() {
    final percentage = (score / questions.length * 100).round();
    String message;
    Color messageColor;
    IconData messageIcon;

    if (percentage >= 80) {
      message = 'Excellent! You did great!';
      messageColor = const Color(0xFF4CAF50);
      messageIcon = Icons.celebration;
    } else if (percentage >= 60) {
      message = 'Good job! Keep learning!';
      messageColor = const Color(0xFF2196F3);
      messageIcon = Icons.thumb_up;
    } else {
      message = 'Keep practicing! You can do better!';
      messageColor = const Color(0xFFFF9800);
      messageIcon = Icons.school;
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Result card
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(
                  messageIcon,
                  size: 80,
                  color: messageColor,
                ),
                const SizedBox(height: 20),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: messageColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  'Your Score',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF666666),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '$score / ${questions.length}',
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2196F3),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '$percentage%',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: messageColor,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Action buttons
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: resetQuiz,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2196F3),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    'Take Quiz Again',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate back to dashboard (index 0)
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF2196F3),
                    side: const BorderSide(color: Color(0xFF2196F3), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    'Back to Home',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
