import 'dart:math';

import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const UserTile({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(

      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(5),
        ),
        margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            // User Profile pic
            CircleAvatar(
              backgroundColor: Colors.lightBlue,
              radius: 20,
              child: Text(text[0].toUpperCase()),
            ),

            const SizedBox(width: 20),
            // User name --> (first letter is capital AND @___.com is removed)
            Text(text.split("@")[0][0].toUpperCase()+text.split("@")[0].substring(1), style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
