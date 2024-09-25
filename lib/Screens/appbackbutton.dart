// import 'package:flutter/material.dart';
// import 'package:game/theme/color.dart';
//
// class AppBackButton extends StatefulWidget {
//   const AppBackButton({super.key});
//
//   @override
//   _AppBackButtonState createState() => _AppBackButtonState();
// }
//
// class _AppBackButtonState extends State<AppBackButton> with SingleTickerProviderStateMixin{
//   late AnimationController _animationController;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2)
//     )..repeat();
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('CustomPaint Example'),
//       ),
//       body: Center(
//         child: Container(
//           color: Colors.grey,
//           child: CustomPaint(
//             size: Size(300, 300),
//             painter: MyPainter(
//                 animationController: _animationController),
//           ),
//         ),
//       ),
//     );
//   }
// }
