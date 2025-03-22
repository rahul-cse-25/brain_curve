//
//
// import 'dart:async';
//
// import 'package:audioplayers/audioplayers.dart';
// import 'package:brain_curve/Extension/theme.dart';
// import 'package:brain_curve/Utils/customize_style.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import '../Model/answer.dart';
// import '../Model/quize.dart';
//
// class QuizScreen extends StatefulWidget {
//   final List<Quiz> quiz;
//
//   const QuizScreen({super.key, required this.quiz});
//
//   @override
//   State<QuizScreen> createState() => _QuizScreenState();
// }
//
// class _QuizScreenState extends State<QuizScreen> {
//   BrainCurveCustomizeStyle style = BrainCurveCustomizeStyle();
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   int currentQuestionIndex = 0;
//   late Timer _timer;
//   int _remainingTimeInSeconds = 0;
//
//   List<Answer> selectedAnswers = [];
//   Size inputSize = const Size(0, 0);
//   var progressKey = GlobalKey();
//   bool isMusicPlaying = true;
//
//   @override
//   void initState() {
//     super.initState();
//     // if (widget.quiz != null) {
//     //   _startCountdown(widget.quiz.duration!);
//     //   // _startCountdown(1);
//     // } else {
//     //   _startCountdown(20);
//     // }
//     playMusic();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(
//       SystemUiOverlayStyle(
//         statusBarColor: context.backgroundColor,
//         statusBarIconBrightness:
//             context.isDarkMode ? Brightness.light : Brightness.dark,
//       ),
//     );
//     Quiz question = widget.quiz[currentQuestionIndex];
//
//     // Retrieve the previously selected answer for the current question
//     // final existingAnswer = selectedAnswers.firstWhere(
//     //     (element) => element.questionId == question.id,
//     //     orElse: () => Answer(null, null, null, -1, false));
//
//     updateProgressBar();
//     var progressPercent =
//         (currentQuestionIndex) / widget.quiz.length * 100;
//     var barWidth = (progressPercent / 100) * inputSize.width;
//
//     return Scaffold(
//       backgroundColor: context.backgroundColor,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         surfaceTintColor: Colors.transparent,
//         centerTitle: true,
//         title: Text(
//           'Question ${currentQuestionIndex + 1}',
//           style: TextStyle(
//             fontSize: style.sizes.textMultiplier * 2.5,
//             color: context.textColor,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         leading: IconButton(
//             onPressed: () => _showAlertDialog(
//                 title: "End the quiz?",
//                 message: "Are you sure you want to end the quiz?",
//                 onConfirmText: "Yes! End the quiz",
//                 onConfirm: () {
//                   Navigator.of(context).pop();
//                   Navigator.of(context).pop();
//                 }),
//             icon: Icon(
//               Icons.arrow_back_ios_new,
//               color: context.textColor,
//               size: style.sizes.textMultiplier * 3,
//             )),
//         actions: [
//           Container(
//             margin:
//                 EdgeInsets.only(right: style.sizes.horizontalBlockSize * 4),
//             decoration: BoxDecoration(
//                 color: Colors.deepPurpleAccent,
//                 shape: BoxShape.circle,
//                 boxShadow: [
//                   BoxShadow(
//                       color: Colors.white,
//                       spreadRadius: 1,
//                       blurStyle: BlurStyle.inner),
//                 ]),
//             child: Center(
//               child: IconButton(
//                 padding: EdgeInsets.zero,
//                 icon: Icon(
//                   isMusicPlaying ? Icons.pause : Icons.play_arrow,
//                   size: style.sizes.textMultiplier * 3,
//                   color: Colors.white,
//                 ),
//                 onPressed: toggleMusic,
//               ),
//             ),
//           )
//         ],
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: style.brainCurveAllScreenPadding(),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       margin: EdgeInsets.only(
//                           right: style.sizes.horizontalBlockSize * 4),
//                       padding: EdgeInsets.all(
//                           style.sizes.horizontalBlockSize * 2),
//                       decoration: BoxDecoration(
//                           color: Colors.deepPurpleAccent,
//                           shape: BoxShape.circle,
//                           boxShadow: [
//                             BoxShadow(
//                                 color: Colors.white,
//                                 spreadRadius: 1,
//                                 blurStyle: BlurStyle.inner),
//                           ]),
//                       child: Center(
//                         child: InkWell(
//                           onTap: context.toggleTheme,
//                           child: Icon(
//                             context.isDarkMode
//                                 ? Icons.light_mode_outlined
//                                 : Icons.dark_mode_outlined,
//                             size: style.sizes.textMultiplier * 2,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Text(
//                         'Time Remaining: ${_formatTime(_remainingTimeInSeconds)}',
//                         style: TextStyle(
//                           fontSize: style.sizes.textMultiplier * 2,
//                           fontWeight: FontWeight.bold,
//                           color: context.textColor,
//                         )),
//                   ],
//                 ),
//               ),
//
//               // Progress bar
//               _buildProgressBar(barWidth),
//               style.brainCurveVerticalGap(verticalGapSizeInPercent: 2),
//               // Question
//               Padding(
//                 padding: style.brainCurveAllScreenPadding(ver: 0),
//                 child: Text(
//                   question.question,
//                   style: TextStyle(
//                     fontSize: style.sizes.textMultiplier * 2,
//                     fontWeight: FontWeight.bold,
//                     color: context.textColor,
//                   ),
//                 ),
//               ),
//               // Animation
//               Transform.scale(
//                   scale: 1.4,
//                   child: style.brainCurveLottieImage(
//                     'assets/json/calm_boy.json',
//                     widthInPercent: 100,
//                   )),
//               // Options
//               ...question.options.map((option) {
//                 int index = question.options.indexOf(option);
//                 return Container(
//                   margin: style.brainCurveAllScreenPadding(ver: 1),
//                   decoration: BoxDecoration(
//                     color: existingAnswer.selectedIndex == index
//                         ? Colors.deepPurpleAccent
//                         : context.isDarkMode
//                             ? Colors.grey.shade800
//                             : Colors.grey.shade400,
//                     boxShadow: [
//                       BoxShadow(
//                           color: Colors.grey.shade800,
//                           blurRadius: 2,
//                           offset: Offset(0, 1),
//                           spreadRadius: 1,
//                           blurStyle: BlurStyle.inner),
//                     ],
//                     borderRadius: BorderRadius.circular(
//                         style.sizes.horizontalBlockSize * 5.5),
//                   ),
//                   child: ListTile(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(
//                           style.sizes.horizontalBlockSize * 5.5),
//                     ),
//                     leading: Container(
//                       padding: EdgeInsets.all(
//                           style.sizes.horizontalBlockSize * 2),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         shape: BoxShape.circle,
//                       ),
//                       child: Text(
//                         '${index + 1}',
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: style.sizes.textMultiplier * 2,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     title: Text(
//                       question.options ?? 'Option Not Found',
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: style.sizes.textMultiplier * 2),
//                     ),
//                     trailing: Icon(
//                       existingAnswer.selectedIndex == index
//                           ? Icons.check_circle_outline
//                           : Icons.circle_outlined,
//                       color: Colors.white,
//                     ),
//                     onTap: () => _selectAnswer(index, question, option),
//                   ),
//                 );
//               }),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: _buildBottomBar(),
//     );
//   }
//
//   Widget _buildProgressBar(double barWidth) {
//     return Row(
//       children: [
//         style.brainCurveHorizontalGap(horizontalGapSizeInPercent: 4),
//         Text('${currentQuestionIndex + 1}/${widget.quiz.questions.length}',
//             style: TextStyle(
//               fontSize: style.sizes.textMultiplier * 2,
//               fontWeight: FontWeight.bold,
//             )),
//         style.brainCurveHorizontalGap(horizontalGapSizeInPercent: 0.5),
//         Expanded(
//           child: Stack(
//             children: [
//               IgnorePointer(
//                 child: Container(
//                   key: progressKey,
//                   margin: EdgeInsets.only(
//                       left: style.sizes.horizontalBlockSize * 4),
//                   width: double.infinity,
//                   height: style.sizes.horizontalBlockSize * 4,
//                   decoration: BoxDecoration(
//                       color: Colors.grey,
//                       borderRadius: BorderRadius.circular(
//                           style.sizes.horizontalBlockSize * 4),
//                       boxShadow: [
//                         BoxShadow(
//                             color: context.isDarkMode
//                                 ? Colors.white
//                                 : Colors.grey.shade600,
//                             spreadRadius: 1,
//                             blurStyle: BlurStyle.inner),
//                       ]),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(
//                     left: style.sizes.horizontalBlockSize * 4),
//                 width: barWidth,
//                 height: inputSize.height,
//                 decoration: BoxDecoration(
//                   color: Colors.deepPurpleAccent,
//                   borderRadius: BorderRadius.circular(
//                       style.sizes.horizontalBlockSize * 4),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         style.brainCurveHorizontalGap(horizontalGapSizeInPercent: 4),
//       ],
//     );
//   }
//
//   void _showAlertDialog(
//       {required String title,
//       required String message,
//       required String onConfirmText,
//       required VoidCallback onConfirm}) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           // backgroundColor: Colors.deepPurpleAccent.shade700,
//           backgroundColor: Colors.deepPurple.shade700,
//           shape: ContinuousRectangleBorder(
//               borderRadius: BorderRadius.all(
//                   Radius.circular(style.sizes.horizontalBlockSize * 28.5))),
//           title: Center(
//             child: Text(
//               title,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           content: Text(
//             message,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//                 color: Colors.white,
//                 fontSize: style.sizes.textMultiplier * 2),
//           ),
//           actions: [
//             TextButton(
//               onPressed: onConfirm,
//               child: Text(
//                 onConfirmText,
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//             TextButton(
//               child: const Text(
//                 "Cancel",
//                 style: TextStyle(color: Colors.white),
//               ),
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Widget _buildBottomBar() {
//     return Padding(
//       padding: style.brainCurveAllScreenPadding(),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           currentQuestionIndex == 0
//               ? SizedBox.shrink()
//               : Expanded(
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       padding: style.brainCurveAllScreenPadding(ver: 4),
//                       backgroundColor: Colors.deepPurpleAccent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(
//                             style.sizes.horizontalBlockSize * 5.5),
//                       ),
//                     ),
//                     onPressed: _previousQuestion,
//                     child: Text(
//                       'Back',
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: style.sizes.textMultiplier * 2),
//                     ),
//                   ),
//                 ),
//           currentQuestionIndex == 0
//               ? SizedBox.shrink()
//               : style.brainCurveHorizontalGap(),
//           Expanded(
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 padding: style.brainCurveAllScreenPadding(ver: 4),
//                 backgroundColor: Colors.deepPurpleAccent,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(
//                       style.sizes.horizontalBlockSize * 5.5),
//                 ),
//               ),
//               onPressed: _nextOrSubmit,
//               child: Text(
//                 currentQuestionIndex == widget.quiz.questions.length - 1
//                     ? 'Submit'
//                     : 'Next',
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: style.sizes.textMultiplier * 2),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _selectAnswer(int index, Question question, Option option) {
//     final answerObject = Answer(
//       option.id,
//       question.id,
//       option.description,
//       index,
//       option.isCorrect,
//     );
//
//     setState(() {
//       final answerIndex = selectedAnswers
//           .indexWhere((element) => element.questionId == question.id);
//
//       if (answerIndex >= 0) {
//         selectedAnswers[answerIndex] = answerObject;
//       } else {
//         selectedAnswers.add(answerObject);
//       }
//     });
//   }
//
//   void _nextOrSubmit() {
//     if (currentQuestionIndex == widget.quiz.questions.length - 1) {
//       if (selectedAnswers.length != widget.quiz.questions.length) {
//         _showAlertDialog(
//             title: "Remaining questions",
//             message: "Please answer all the questions",
//             onConfirmText: "OK !",
//             onConfirm: () => Navigator.pop(context));
//       } else {
//         _showAlertDialog(
//             title: "Submit",
//             message: "Are you sure, you want to submit the quiz?",
//             onConfirmText: "Yes! sure",
//             onConfirm: _submitQuiz);
//       }
//     } else {
//       setState(() {
//         currentQuestionIndex++;
//       });
//     }
//   }
//
//   void _previousQuestion() {
//     if (currentQuestionIndex != 0) {
//       setState(() {
//         currentQuestionIndex--;
//       });
//     }
//   }
//
//   Future<void> playMusic() async {
//     await _audioPlayer.setSource(AssetSource('music/birds.mp3'));
//     _audioPlayer.setVolume(0.5);
//     _audioPlayer.resume();
//     _audioPlayer.onPlayerStateChanged.listen((event) {
//       if (event == PlayerState.stopped) {
//         _audioPlayer.resume();
//       }
//     });
//   }
//
//   void toggleMusic() {
//     if (isMusicPlaying) {
//       _audioPlayer.pause();
//     } else {
//       _audioPlayer.resume();
//     }
//     setState(() {
//       isMusicPlaying = !isMusicPlaying;
//     });
//   }
//
//   updateProgressBar() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final RenderBox renderBox =
//           progressKey.currentContext?.findRenderObject() as RenderBox;
//       inputSize = renderBox.size;
//     });
//   }
//
//   // Start the countdown timer
//   void _startCountdown(int minutes) {
//     _remainingTimeInSeconds = minutes * 60; // Convert minutes to seconds
//     _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
//       setState(() {
//         if (_remainingTimeInSeconds > 0) {
//           _remainingTimeInSeconds--; // Decrease the remaining time
//         } else {
//           _submitQuiz(); // Submit the quiz automatically
//         }
//       });
//     });
//   }
//
//   // Function to handle quiz submission when time runs out
//   void _submitQuiz() {
//     _audioPlayer.stop();
//     _timer.cancel();
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) =>
//             ResultScreen(selectedAnswers: selectedAnswers, quiz: widget.quiz),
//       ),
//     );
//   }
//
//   // Format the remaining time into MM:SS format
//   String _formatTime(int seconds) {
//     int minutes = seconds ~/ 60;
//     int remainingSeconds = seconds % 60;
//     return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
//   }
//
//   @override
//   void dispose() {
//     _audioPlayer.stop();
//     super.dispose();
//   }
// }
