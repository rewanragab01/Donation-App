import 'package:donation/core/apptext_button.dart';
import 'package:flutter/material.dart';

class DonorListView extends StatelessWidget {
  const DonorListView({
    super.key,
    required this.donors,
  });

  final Map<String, dynamic> donors;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, // Adjust the ListView height to its children
      physics: NeverScrollableScrollPhysics(), // Disable internal scrolling
      itemCount: donors.length,
      itemBuilder: (context, index) {
        final donor =
            donors.entries.toList()[index].value; // Get the donor data
        if (donor == null) {
          return Center(child: Text('No donor data available'));
        }

        // Safely access values
        final bloodType = donor['bloodType'] ?? 'Unknown';
        final name = donor['name'][0] ?? 'No name';
        final phone = donor['phone'] ?? 'No phone';

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      AppTextButton(
                        buttonText: 'Chat Now',
                        icon: Icons.chat_bubble_rounded,
                        iconColor: Colors.blue,
                        textStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
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
