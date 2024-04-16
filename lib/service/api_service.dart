import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:yt_download_app/api/url_const.dart';
import 'package:yt_download_app/model/info.dart';
import 'package:yt_download_app/model/photo.dart';

class ApiService {
  static Future<List<Photo>> fetchPhotsData() async {
    final response = await http.get(Uri.parse(getAllPhotos));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      final List<dynamic> data = json.decode(response.body);
      final List<Photo> users = data.map((e) => Photo.fromJson(e)).toList();
      return users;
    } else {
      // If the server returns an error response, throw an exception
      throw Exception('Failed to load data from API');
    }
  }

  static Future<List<Info>> fetchInfo(dynamic object) async {
    try {
      var payload = json.encode(object);
      var headers = {'Content-Type': 'application/json'};
      final response = await http.post(Uri.parse(fetchDetails),
          body: payload, headers: headers);

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        final List<dynamic> data = json.decode(response.body);
        final List<Info> users = data.map((e) => Info.fromJson(e)).toList();
        return users;
      } else {
        // If the server returns an error response, throw an exception
        throw Exception('Failed to load data from API');
      }
    } on SocketException catch (e) {
      // Handle socket exception (connection refused)
      log('Connection refused: ${e.message}');
      throw Exception(e.message);
    } catch (e) {
      // Handle other exceptions
      log('Error occurred: $e');
      throw Exception(e);
    }
  }
}
