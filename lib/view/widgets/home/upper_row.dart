import 'package:flutter/cupertino.dart';
import 'package:tasks_app/const/app_decoration.dart';

class UpperRow extends StatelessWidget {
  const UpperRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 25),
      child: Row(
        children: [
          const Icon(
            CupertinoIcons.list_bullet,
            color: AppDecoration.white,
          ),
          SizedBox(
            width: AppDecoration().screenWidth * 0.01,
          ),
          const Text(
            'ToDo',
            style: TextStyle(
              color: AppDecoration.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
