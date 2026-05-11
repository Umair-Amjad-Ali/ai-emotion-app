import 'package:ai_emotion_app/screen/signup/assessment_result_screen.dart';
import 'package:flutter/material.dart';
import '../../widgets/primary_button.dart';

class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({super.key});

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  int _currentIndex = 0;
  int? _selectedOptionIndex;

  final List<Map<String, dynamic>> _quizData = [
    {
      "question": "I often find myself overthinking even small issues.",
      "options": ["Almost Never", "Rarely", "Sometimes", "Often", "Almost Always"]
    },
    {
      "question": "My thoughts keep me awake at night",
      "options": ["Never", "Occasionally", "Sometimes", "Usually", "Always"]
    },
    {
      "question": "I feel my thoughts control my emotions",
      "options": ["Not at all", "Slightly", "Moderately", "Very much", "Extremely"]
    },
    {
      "question": "I can’t stop replaying past events in my head",
      "options": ["Strongly Disagree", "Disagree", "Neutral", "Agree", "Strongly Agree"]
    },
    {
      "question": "I worry excessively about the future",
      "options": ["Never", "Rarely", "Sometimes", "Often", "Always"]
    },
    {
      "question": "I feel disconnected from the present moment",
      "options": ["Almost Never", "Rarely", "Sometimes", "Often", "Almost Always"]
    },
    {
      "question": "My mind feel clutter most of the time",
      "options": ["Never", "Rarely", "Sometimes", "Often", "Always"]
    },
    {
      "question": "It difficult for me to focus because of my intrusive thoughts",
      "options": ["Never", "Rarely", "Sometimes", "Often", "Always"]
    },
    {
      "question": "I react emotionally before thinking things through",
      "options": ["Strongly Disagree", "Disagree", "Neutral", "Agree", "Strongly Agree"]
    },
    {
      "question": "I struggle to observe my thoughts without judging them",
      "options": ["Almost Never", "Rarely", "Sometimes", "Often", "Almost Always"]
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final currentQuestion = _quizData[_currentIndex];
    final List<String> options = currentQuestion["options"];

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // 1. BASE LINEAR GRADIENT (Top to Bottom)
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff101A2C), // Lighter top
              Color(0xff101A2C), // Darker bottom
            ],
          ),
        ),
        child: Stack(
          children: [
            // 2. TOP SKY BLUE FLARE (Large & Intense)
            Positioned(
              top: -250,
              right: -280,
              child: Container(
                width: 800,
                height: 800,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    radius: 0.7,
                    colors: [
                      const Color(0xFF3299FF).withOpacity(0.3), // Brighter Sky Blue center
                      const Color(0xFF4196D7).withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // 3. BOTTOM NAVY BLUE FLARE (Large & Intense)
            Positioned(
              bottom: -200,
              left: -350,
              child: Container(
                width: 900,
                height: 900,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    radius: 0.8,
                    colors: [
                      const Color(0xff1C28B1).withOpacity(0.35), // Intense Navy center
                      const Color(0xff191D47).withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // 4. MAIN CONTENT
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                child: Column(
                  children: [
                    // Header with Back Button
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () {
                          if (_currentIndex > 0) {
                            setState(() {
                              _currentIndex--;
                              _selectedOptionIndex = null;
                            });
                          } else {
                            Navigator.pop(context);
                          }
                        },
                        icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Question Counter
                    Text(
                      'QUESTION ${_currentIndex + 1} OF ${_quizData.length}'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.4),
                        fontSize: 12,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Progress Bar
                    _buildProgressBar(),
                    const SizedBox(height: 40),

                    // Question Text
                    Text(
                      currentQuestion["question"],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Options List
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: options.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 15),
                        itemBuilder: (context, index) {
                          return _buildOptionCard(options[index], index);
                        },
                      ),
                    ),

                    // Next Button
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20, top: 10),
                      child: PrimaryButton(
                        onPressed: _selectedOptionIndex == null
                            ? () {
                          print("Finish");
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>AssessmentResultScreen()));

                        } // Passing empty callback to satisfy required parameter
                            : () {
                          if (_currentIndex < _quizData.length - 1) {
                            setState(() {
                              _currentIndex++;
                              _selectedOptionIndex = null;
                            });
                          }
                        },
                        text: _currentIndex == _quizData.length - 1 ? 'FINISH' : 'NEXT',
                        icon: Icons.arrow_forward,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Stack(
      children: [
        Container(
          height: 4,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        FractionallySizedBox(
          widthFactor: (_currentIndex + 1) / _quizData.length,
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOptionCard(String optionText, int index) {
    bool isSelected = _selectedOptionIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedOptionIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF232D4E).withOpacity(0.35)
              : Colors.white.withOpacity(0.04),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: isSelected
                ? Colors.white.withOpacity(0.4)
                : Colors.white.withOpacity(0.1),
            width: 1.2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                optionText,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white.withOpacity(0.7),
                  fontSize: 17,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ),
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.white : Colors.white.withOpacity(0.15),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                child: Container(
                  height: 12,
                  width: 12,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}