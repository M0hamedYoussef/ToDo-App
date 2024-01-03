import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_app/const/app_decoration.dart';
import 'package:tasks_app/controller/database_con.dart';
import 'package:tasks_app/model/task_model.dart';
import 'package:tasks_app/view/widgets/home/task.dart';

class TasksList extends StatelessWidget {
  const TasksList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
          color: AppDecoration.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GetBuilder<DatabaseController>(
            builder: (controller) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                itemCount: controller.databaseList.length,
                itemBuilder: (context, index) {
                  TaskModel taskModel =
                      TaskModel.fromMap(controller.databaseList[index]);
                  return Task(taskModel: taskModel);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
