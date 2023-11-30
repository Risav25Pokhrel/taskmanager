import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:taskmanager/core/configs/meta.dart';
import 'package:taskmanager/core/services/http/baseservice.dart';

class HttpService extends BaseService {
  HttpService(super.ref);

  @override
  Future<Response> deleteRequest(id) async {
    try {
      final url = Uri.parse("${BaseService.baseUrl}/$id");
      final response = await delete(url);
      return response;
    } on SocketException {
      Meta().messanger(message: "No Internet Connection");
      throw Exception("No Internet");
    } catch (e) {
      Meta().messanger(message: e.toString());
      throw Exception(e.toString());
    }
  }

  @override
  Future<Response> getRequest() async {
    try {
      final url = Uri.parse(BaseService.baseUrl);
      final response = await get(url);
      return response;
    } on SocketException {
      Meta().messanger(message: "No Internet Connection");
      throw Exception("No Internet");
    } catch (e) {
      Meta().messanger(message: e.toString());
      throw Exception(e.toString());
    }
  }

  @override
  Future<Response> postRequest(body) async {
    try {
      final url = Uri.parse(BaseService.baseUrl);
      final response = await post(
        url,
        body: jsonEncode(body),
        headers: {"Content-Type": "application/json"},
      );
      return response;
    } on SocketException {
      Meta().messanger(message: "No Internet Connection");
      throw Exception("No Internet");
    } catch (e) {
      Meta().messanger(message: e.toString());
      throw Exception(e.toString());
    }
  }

  @override
  Future<Response> putRequest(id, body) async {
    try {
      final url = Uri.parse("${BaseService.baseUrl}/$id");
      final response = await put(
        url,
        body: jsonEncode(body),
        headers: {"Content-Type": "application/json"},
      );
      return response;
    } on SocketException {
      Meta().messanger(message: "No Internet Connection");
      throw Exception("No Internet");
    } catch (e) {
      Meta().messanger(message: e.toString());
      throw Exception(e.toString());
    }
  }
}
