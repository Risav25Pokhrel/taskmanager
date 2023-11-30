import 'dart:convert';
import 'package:taskmanager/core/configs/appcolor.dart';
import 'package:taskmanager/core/configs/meta.dart';
import 'package:taskmanager/core/services/http/httpservice.dart';

import '../../models/taskmodel.dart';

typedef Tasklist = List<Task>;

class TaskOption extends HttpService {
  TaskOption(super.ref);

  Future<Tasklist> getTasks() async {
    try {
      Tasklist tasklist = [];
      final response = await getRequest();
      final body = jsonDecode(response.body);
      for (var i in body) {
        tasklist.add(Task.fromJson(i));
      }
      return tasklist;
    } catch (e) {
      throw Exception();
    }
  }

  Future<bool> updateTask(Task task) async {
    try {
      final body = task.toJson();
      final response = await putRequest(task.id, body);
      return response.statusCode == 200;
    } catch (e) {
      Meta().messanger(message: e.toString());
      return false;
    }
  }

  Future<bool> addTasks(body) async {
    try {
      final response = await postRequest(body);
      return response.statusCode == 201;
    } catch (e) {
      Meta().messanger(message: e.toString());
      return false;
    }
  }

  Future<bool> deleteTasks(id) async {
    try {
      final response = await deleteRequest(id);
      if (response.statusCode == 200) {
        Meta().messanger(message: "Deleted", color: AppColors.teal);
        return true;
      }
      return false;
    } catch (e) {
      Meta().messanger(message: e.toString());
      return false;
    }
  }
}
