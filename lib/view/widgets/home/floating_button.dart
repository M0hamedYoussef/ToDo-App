import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_app/controller/database_con.dart';

Widget floatingActionButton() {
  DatabaseController controller = Get.find();

  return FloatingActionButton(
    onPressed: () {
      controller.taskCon.clear();
      controller.addTask();
    },
    backgroundColor: Colors.indigo,
    child: const Icon(
      Icons.add,
      size: 30,
    ),
  );
}
