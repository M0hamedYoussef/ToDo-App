import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_app/const/app_decoration.dart';
import 'package:tasks_app/controller/lang_con.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseController extends GetxController {
  late Database database;
  late String databasesPath;
  late String path;
  TextEditingController taskCon = TextEditingController();
  List databaseList = [];

  @override
  void onInit() {
    openDB();
    super.onInit();
  }

  openDB() async {
    databasesPath = await getDatabasesPath();
    path = join(databasesPath, 'tasks_db/db');

    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE Tasks (id INTEGER PRIMARY KEY AUTOINCREMENT,task TEXT,checkVal INTEGER)');
      },
    );
    showDatabase();
  }

  insertTask({required String task}) async {
    await database.rawInsert(
      'INSERT INTO Tasks(task,checkVal) VALUES(? , ?) ',
      [task.trim(), 0],
    );
    showDatabase();
  }

  checkTask({required bool checkVal, required int id}) async {
    await database.rawUpdate(
      'UPDATE Tasks SET checkVal = ? WHERE id = ?',
      [
        checkVal == true ? 1 : 0,
        id,
      ],
    );
    showDatabase();
  }

  updateTask({required String task, required int id}) async {
    await database.rawUpdate(
      'UPDATE Tasks SET task = ? WHERE id = ?',
      [
        task.trim(),
        id,
      ],
    );
    showDatabase();
  }

  deleteTask({required int id}) async {
    await database.rawDelete(
      'DELETE FROM Tasks WHERE id = ?',
      [id],
    );
    showDatabase();
  }

  showDatabase() async {
    databaseList = await database.rawQuery('SELECT * FROM Tasks');
    update();
  }

  closeDB() async {
    await database.close();
  }

  addTask() {
    Get.bottomSheet(
      IntrinsicHeight(
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            color: AppDecoration.white,
          ),
          child: Column(
            children: [
              const Text(
                'Add Task',
                style: TextStyle(
                  color: AppDecoration.indigo,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GetBuilder<LangCon>(
                builder: (langCon) {
                  return TextFormField(
                    controller: taskCon,
                    onChanged: (value) {
                      langCon.checkTextLang(value.trim());
                    },
                    textDirection: langCon.langTextField == 'ar'
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 15),
                child: SizedBox(
                  width: AppDecoration().screenWidth,
                  child: ElevatedButton(
                    onPressed: () {
                      if (taskCon.text.isEmpty) {
                        Get.defaultDialog(
                          title: 'Alert',
                          content: const Text('You Can\'t Set Empty Task !'),
                        );
                      } else {
                        insertTask(task: taskCon.text);
                        taskCon.clear();
                        Get.back();
                      }
                    },
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        AppDecoration.indigo,
                      ),
                    ),
                    child: const Text(
                      'Add',
                      style: TextStyle(
                        color: AppDecoration.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  editTask({required int taskId}) {
    Get.bottomSheet(
      IntrinsicHeight(
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            color: AppDecoration.white,
          ),
          child: Column(
            children: [
              const Text(
                'Edit Task',
                style: TextStyle(
                  color: AppDecoration.indigo,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GetBuilder<LangCon>(
                builder: (langCon) {
                  return TextFormField(
                    controller: taskCon,
                    onChanged: (value) {
                      langCon.checkTextLang(value.trim());
                    },
                    textDirection: langCon.langTextField == 'ar'
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 15),
                child: SizedBox(
                  width: AppDecoration().screenWidth,
                  child: ElevatedButton(
                    onPressed: () {
                      if (taskCon.text.isEmpty) {
                        Get.defaultDialog(
                          title: 'Alert',
                          content: const Text('You Can\'t Set Empty Task !'),
                        );
                      } else {
                        updateTask(task: taskCon.text, id: taskId);
                        taskCon.clear();
                        Get.back();
                      }
                    },
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        AppDecoration.indigo,
                      ),
                    ),
                    child: const Text(
                      'Confirm',
                      style: TextStyle(
                        color: AppDecoration.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
