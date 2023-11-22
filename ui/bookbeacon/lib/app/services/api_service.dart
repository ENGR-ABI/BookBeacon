import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../config/values.dart';
import 'cache_store.dart';

class ApiService extends GetxService {
  final String apiUrl = URL_BASE_API;
  static ApiService get inst => Get.find();

  Future<http.Response?> get(String endpointOrURL) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${CacheStore.inst.token}',
    };
    final url = endpointOrURL.contains('http')
        ? endpointOrURL
        : '$apiUrl/$endpointOrURL';
    try {
    final response = await http.get(Uri.parse(url), headers: headers);
    return response;
      
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> data) async {
    final headers = {
      'Authorization': 'Bearer ${CacheStore.inst.token}',
      'Content-Type': 'application/json'
    };
    final response = await http.post(Uri.parse('$apiUrl/$endpoint'),
        headers: headers, body: jsonEncode(data));

    return response;
  }

  Future<http.Response> put(String endpoint, Map<String, dynamic> data) async {
    final headers = {
      'Authorization': 'Bearer ${CacheStore.inst.token}',
      'Content-Type': 'application/json'
    };
    final response = await http.put(Uri.parse('$apiUrl/$endpoint'),
        headers: headers, body: jsonEncode(data));
    return response;
  }

  Future<http.Response> delete(
      String endpoint, Map<String, dynamic> data) async {
    final headers = {
      'Authorization': 'Bearer ${CacheStore.inst.token}',
      'Content-Type': 'appliwcation/json'
    };
    final response = await http.delete(Uri.parse('$apiUrl/$endpoint'),
        headers: headers, body: jsonEncode(data));

    return response;
  }
}
