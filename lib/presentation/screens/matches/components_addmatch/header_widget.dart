// import 'package:flutter/material.dart';
//
// import '../../../../core/constants/colors.dart';
//
// class HeaderWidget extends StatefulWidget {
//
//   final String? matchId;
//   const HeaderWidget({super.key, this.matchId});
//
//   @override
//   State<HeaderWidget> createState() => _HeaderWidgetState();
// }
//
// class _HeaderWidgetState extends State<HeaderWidget> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(5),
//       decoration: BoxDecoration(
//         color: AppColors.primary,
//         borderRadius: const BorderRadius.only(
//           bottomLeft: Radius.circular(30),
//           bottomRight: Radius.circular(30),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.2),
//             blurRadius: 15,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: IconButton(
//               icon: const Icon(Icons.arrow_back, color: Colors.white),
//               onPressed: () => Navigator.pop(context),
//             ),
//           ),
//           const SizedBox(width: 16),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 widget.matchId != null ? 'Modifier le Match' : 'Nouveau Match',
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 'Configuration tactique avancée',
//                 style: TextStyle(
//                   color: Colors.white.withOpacity(0.8),
//                   fontSize: 14,
//                 ),
//               ),
//             ],
//           ),
//           const Spacer(),
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: IconButton(
//               icon: const Icon(Icons.save, color: Colors.white),
//               onPressed: _saveMatch,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
