import 'package:flutter/material.dart';

class MyDrawerTile extends StatelessWidget {
  final String text;
  final IconData? icon;
  final void Function()? onTap;

  const MyDrawerTile({
    super.key,
    required this.icon,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
      child: ListTile(
        title: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        leading: Icon(
          icon,
          color: Colors.black,
        ),
        onTap: onTap,
      ),
    );
  }
}
