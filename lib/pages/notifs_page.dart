import 'package:flutter/material.dart';

class NotifsPage extends StatelessWidget {
  const NotifsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: GestureDetector(
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 20,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: null,
    );
  }
}
