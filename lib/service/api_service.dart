import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:yt_download_app/api/url_const.dart';
import 'package:yt_download_app/model/info.dart';
import 'package:yt_download_app/model/photo.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class ApiService {
  final dio = Dio();

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

  static Future<List<Info>> fetchInfoW(dynamic object) async {
    print("Heloooooooooooooooooo");
    try {
      final dio = Dio(); // Create a Dio instance

      final jsonData = json.encode(object); // Encode data as JSON

      final response = await dio.post(
        downloadVideoUrl,
        data: jsonData,
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        log("Response : " + data.toString());
        final List<Info> info = data.map((e) => Info.fromJson(e)).toList();
        return info;
      } else {
        throw Exception(
            'Failed to load data from API (status code: ${response.statusCode})');
      }
    } on DioError catch (e) {
      if (DioErrorType.connectTimeout == e.type) {
        log('Connection timeout: ${e.message}');
        throw Exception(
            'Connection timeout'); // Provide a more specific error message to the user
      } else if (DioErrorType.other == e.type) {
        log('Other error: ${e.message}');
        throw Exception(
            'An error occurred'); // Provide a generic error message for other types
      } else {
        rethrow; // Re-throw other DioError types for further handling
      }
    } catch (e) {
      log('Error occurred: $e');
      throw Exception(
          'An unexpected error occurred'); // Catch other unexpected errors
    }
  }

  Future<void> downloadVideo(dynamic object, Function(int)? onProgress) async {
    final dio = Dio();
    final jsonData = json.encode(object);

    try {
      final response = await dio.post(
        downloadVideoUrl,
        data: jsonData,
        options: Options(
            responseType: ResponseType.stream), // Set response type to stream
      );

      if (response.statusCode == 200) {
        List<String>? contentDispositionHeader =
            response.headers['content-disposition'];

        String filename = contentDispositionHeader
            .toString()
            .split(';')
            .map((e) => e.trim())
            .firstWhere((part) => part.startsWith('filename='))
            .split('=')[1]
            .replaceAll('"', '')
            .replaceAll(RegExp(r'\s+'), ' ');

        log(filename);

        if (filename.contains('.mp3')) {
          filename = '${filename.split('.mp3')[0]}.mp3';
        }
        if (filename.contains('.mp4')) {
          filename = '${filename.split('.mp4')[0]}.mp4';
        }

        final localDir = await getLocalDirectory();
        var status = await Permission.storage.status;

        if (!status.isGranted) {
          await Permission.storage.request();
        }

        await localDir.create(
            recursive: true); // Create the directory if it doesn't exist

        log(localDir.absolute.toString());

        final filePath = '${localDir.path}/$filename';

        final sink = File(filePath).openWrite(mode: FileMode.writeOnly);

        int received = 0;
        int total = int.parse(response.headers['Content-Length']![0]);

        // // Access the byte data from the response
        // await response.data.stream.forEach(
        //   sink.add,
        // );
        // await sink.close();

        response.data.stream.listen(
          (data) {
            sink.add(data);
            received += (data.length as int);
            if (onProgress != null) {
              onProgress((received / total * 100).toInt());
            }
          },
          onDone: () async {
            await sink.close();
            print('Download complete! Saved to: $filePath');
          },
          onError: (error) {
            log('Error receiving data: $error');
            sink.close();
          },
          cancelOnError: true,
        );

        print('Download complete! Saved to: $filePath');
      } else {
        throw Exception(
            'Failed to download video (status code: ${response.statusCode})');
      }
    } on DioError catch (e) {
      log('Error downloading video: ${e.message}');
      throw Exception(
          'An error occurred while downloading'); // Provide a generic error message
    } catch (e) {
      log('Unexpected error: $e');
      throw Exception(
          'An unexpected error occurred'); // Catch other unexpected errors
    }
  }

  Future<Directory> getLocalDirectory() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final dcimDir = Directory('/storage/emulated/0');

    if (await isDirectoryWritable(dcimDir)) {
      return Directory('${dcimDir.path}/youtube_download');
    } else {
      return Directory('${appDocDir.path}/videos');
    }
  }

  Future<bool> isDirectoryWritable(Directory directory) async {
    try {
      await getTemporaryDirectory();
      return true;
    } catch (e) {
      return false;
    }
  }
}
