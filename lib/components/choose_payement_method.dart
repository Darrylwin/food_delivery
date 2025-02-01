import 'package:flutter/material.dart';

class ChoosePayementMethod extends StatelessWidget {
  ChoosePayementMethod({
    super.key,
    required this.icon,
    required this.onChanged,
    required this.text,
    required this.subTitle,
  });

  final String icon;
  final String text;
  final String? subTitle;
  void Function()? onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChanged,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: .7,
              blurRadius: 5,
              offset:
                  const Offset(2, 2), // changé pour ombre à droite et en bas
            ),
          ],
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                icon,
                height: 35,
                width: 35,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: subTitle != null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          text,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          subTitle!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      text,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
