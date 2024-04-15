import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yt_download_app/api/url_const.dart';
import 'package:yt_download_app/model/photo.dart';

class ApiService {
// Example method to fetch data from an API endpoint
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

  static Future<List<Photo>> singleVideo() async {
    final response = await http.get(Uri.parse(getSinglePhotos));

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

  static Future<List<Photo>> playlist() async {
    final response = await http.get(Uri.parse(getPlaylist));

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
}
