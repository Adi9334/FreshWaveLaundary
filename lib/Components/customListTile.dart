import 'package:flutter/material.dart';
import 'package:freshwavelaundry/ui_helper/util.dart';

class customListTile extends StatelessWidget {
  final leading;
  final title;
  final subtitle;
  final Widget trailing;

  const customListTile({
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                CircleAvatar(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(leading)),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title.toString()),
                    Text(
                      subtitle,
                      style: TextStyle(color: basic1()),
                    ),
                  ],
                ),
                Spacer(),
                trailing,
              ],
            ),
          ),
          Divider()
        ],
      ),
    );
  }
}
