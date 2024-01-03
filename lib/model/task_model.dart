class TaskModel {
  late int id;
  late String task;
  late bool check;

  TaskModel({
    required this.id,
    required this.task,
    required this.check,
  });

  TaskModel.fromMap(Map<String, dynamic> databaseQuery) {
    id = databaseQuery['id'];
    task = databaseQuery['task'];
    check = databaseQuery['checkVal'] == 1 ? true : false;
  }
}
