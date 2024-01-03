import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_app/const/app_decoration.dart';
import 'package:tasks_app/controller/database_con.dart';
import 'package:tasks_app/model/task_model.dart';

class Task extends GetView<DatabaseController> {
  const Task({super.key, required this.taskModel});
  final TaskModel taskModel;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(taskModel.id),
      onDismissed: (_) {
        controller.deleteTask(id: taskModel.id);
      },
      child: ListTile(
        onLongPress: () {
          controller.taskCon.text = taskModel.task.trim();
          controller.editTask(taskId: taskModel.id);
        },
        title: Text(
          taskModel.task,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppDecoration.indigo,
          ),
        ),
        trailing: Checkbox(
          value: taskModel.check,
          checkColor: AppDecoration.white,
          fillColor: const MaterialStatePropertyAll(
            AppDecoration.indigo,
          ),
          onChanged: (newVal) {
            controller.checkTask(
              checkVal: newVal!,
              id: taskModel.id,
            );
          },
        ),
      ),
    );
  }
}
