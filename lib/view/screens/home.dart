import 'package:flutter/material.dart';
import 'package:tasks_app/const/app_decoration.dart';
import 'package:tasks_app/view/widgets/home/floating_button.dart';
import 'package:tasks_app/view/widgets/home/tasks_list.dart';
import 'package:tasks_app/view/widgets/home/upper_row.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppDecoration.indigo,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            UpperRow(),
            TasksList(),
          ],
        ),
      ),
      floatingActionButton: floatingActionButton(),
    );
  }
}
