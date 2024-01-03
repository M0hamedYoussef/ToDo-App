import 'package:get/get.dart';
import 'package:tasks_app/controller/database_con.dart';
import 'package:tasks_app/controller/lang_con.dart';

class MyBind implements Bindings {
  @override
  void dependencies() {
    Get.put(DatabaseController());
    Get.put(LangCon());
  }
}
