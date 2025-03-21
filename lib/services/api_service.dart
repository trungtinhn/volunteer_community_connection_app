import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  // ignore: constant_identifier_names

  static const String API_URL = 'https://97a9-183-80-32-59.ngrok-free.app';

  // Hàm POST

  Future<Map<String, dynamic>> post(
      String endpoint, Map<String, dynamic>? data) async {
    final url = Uri.parse('$API_URL$endpoint');
    try {
      final response = data != null
          ? await http.post(
              url,
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode(data),
            )
          : await http.post(url);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Failed POST request: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      throw Exception('POST error: $e');
    }
  }

  Future<bool> postBool(String endpoint, Map<String, dynamic>? data) async {
    final url = Uri.parse('$API_URL$endpoint');
    try {
      final response = data != null
          ? await http.post(
              url,
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode(data),
            )
          : await http.post(url);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  // Hàm POST Form Data
  Future<Map<String, dynamic>> createFormDataWithImage(
      String endpoint, Map<String, String> data, File? image) async {
    final url = Uri.parse('$API_URL$endpoint');

    var request = http.MultipartRequest('POST', url)..fields.addAll(data);
    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        image.path,
      ));
    }

    try {
      final response = await request.send();
      final responseData = await http.Response.fromStream(response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(responseData.body);
      } else {
        throw Exception(
            'Failed POST request: ${response.statusCode}, ${responseData.body}');
      }
    } catch (e) {
      throw Exception('POST error: $e');
    }
  }

  Future<Map<String, dynamic>> changeAvatar(
      String endpoint, File? image) async {
    final url = Uri.parse('$API_URL$endpoint');

    var request = http.MultipartRequest('PUT', url);
    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'avatar',
        image.path,
      ));
    }

    try {
      final response = await request.send();
      final responseData = await http.Response.fromStream(response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(responseData.body);
      } else {
        throw Exception(
            'Failed POST request: ${response.statusCode}, ${responseData.body}');
      }
    } catch (e) {
      throw Exception('POST error: $e');
    }
  }

  // Hàm GET
  Future<Map<String, dynamic>> get(String endpoint) async {
    final url = Uri.parse('$API_URL$endpoint');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Failed GET request: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      throw Exception('GET error: $e');
    }
  }

  // Hàm GET tất cả
  Future<List<dynamic>> getAll(String endpoint) async {
    final url = Uri.parse('$API_URL$endpoint');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as List<dynamic>;
      } else {
        throw Exception(
            'Failed GET ALL request: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      throw Exception('GET ALL error: $e');
    }
  }

  // Hàm PUT
  Future<Map<String, dynamic>> put(
      String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('$API_URL$endpoint');
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Failed PUT request: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      throw Exception('PUT error: $e');
    }
  }

  // Hàm DELETE
  Future<Map<String, dynamic>> delete(String endpoint) async {
    final url = Uri.parse('$API_URL$endpoint');
    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Failed DELETE request: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      throw Exception('DELETE error: $e');
    }
  }
}
