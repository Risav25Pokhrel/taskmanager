import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

abstract class BaseService {
  BaseService(this.ref);
  final Ref ref;

  static String get baseUrl =>
      'https://6564594bceac41c0761df84a.mockapi.io/api/taskmanager/task';

  Future<Response> getRequest();
  Future<Response> postRequest(dynamic body);
  Future<Response> deleteRequest(id);
  Future<Response> putRequest(id,body);
}
