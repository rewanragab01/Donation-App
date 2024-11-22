import 'package:flutter/material.dart';
import 'package:donation/core/apptext_button.dart';

class DonorListView extends StatelessWidget {
  final Map<String, dynamic> donors;

  const DonorListView({super.key, required this.donors});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: donors.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(), // Allow scrolling if needed
      itemBuilder: (context, index) {
        final donor = donors.entries.toList()[index].value;
        final bloodType = donor['bloodType'] ?? 'Unknown';
        final name = (donor['name'][0] ?? 'No name');
        final phone = donor['phone'] ?? 'No phone';

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 5.5,
                  spreadRadius: 1,
                )
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 80,
                      width: 75,
                      color: Colors.black,
                    ),
                    Positioned(
                      top: 15,
                      child: Container(
                        height: 75,
                        width: 75,
                        color: Colors.red,
                        child: Center(
                          child: Text(
                            bloodType,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AppTextButton(
                        buttonText: 'Chat Now',
                        icon: Icons.chat_bubble_rounded,
                        iconColor: Colors.blue,
                        textStyle: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        onPressed: () {
                          // Implement the chat functionality
                        },
                        backgroundColor: Colors.transparent,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


// class DonorListView extends StatelessWidget {
//   const DonorListView({
//     super.key,
//     required this.donors,
//   });

//   final Map<String, dynamic> donors;

//   @override
//   Widget build(BuildContext context) {
//     // Check if there are any donors to display
//     if (donors.isEmpty) {
//       return Center(
//         child: Text(
//           'No donors available',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//       );
//     }

//     return ListView.builder(
//       shrinkWrap: true, // Allow ListView to adjust to its children

//       itemCount: donors.length,
//       itemBuilder: (context, index) {
//         print("lists:$donors");
//         // Extract donor details
//         final donor = donors.entries.toList()[index].value;
//         print("item:$donor");
//         if (donor == null) {
//           return Center(
//             child: Text(
//               'Invalid donor data',
//               style: TextStyle(color: Colors.red),
//             ),
//           );
//         }

//         final bloodType = donor['bloodType'] ?? 'Unknown';
//         final name = (donor['name'] ?? 'No name').toString();
//         final phone = donor['phone'] ?? 'No phone';

//         return Padding(
//           padding: const EdgeInsets.symmetric(vertical: 5),
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black54,
//                   blurRadius: 5.5,
//                   spreadRadius: 1,
//                 )
//               ],
//             ),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Stack(
//                   children: [
//                     Container(
//                       height: 80,
//                       width: 75,
//                       color: Colors.black,
//                     ),
//                     Positioned(
//                       top: 15,
//                       child: Container(
//                         height: 75,
//                         width: 75,
//                         color: Colors.red,
//                         child: Center(
//                           child: Text(
//                             bloodType,
//                             style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(width: 15),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         name,
//                         style: const TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       AppTextButton(
//                         buttonText: 'Chat Now',
//                         icon: Icons.chat_bubble_rounded,
//                         iconColor: Colors.blue,
//                         textStyle: const TextStyle(
//                           fontSize: 18,
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         onPressed: () {
//                           // Implement the chat functionality
//                           print('Chat with $name ($phone)');
//                         },
//                         backgroundColor: Colors.transparent,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }




