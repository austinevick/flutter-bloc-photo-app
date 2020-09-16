import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc_gallery_app/apikey.dart';
import 'package:flutter_bloc_gallery_app/models/photos.dart';
import 'package:flutter_bloc_gallery_app/repository/photo_base_repository.dart';
import 'package:http/http.dart' as http;

class PhotoRepository extends PhotoBaseRepository {
  static const String baseUrl = 'https://api.pexels.com';
  final http.Client _httpClient;
  PhotoRepository({http.Client httpClient})
      : _httpClient = httpClient ?? http.Client();
  @override
  Future<List<Photos>> getPhotos() async {
    List<Photos> photos = [];
    String url = '$baseUrl/v1/curated?per_page=100';
    try {
      final response =
          await _httpClient.get(url, headers: {"Authorization": "$apikey"});
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> photoList = data['photos'];
        photoList.forEach((map) => photos.add(Photos.fromMap(map)));
        print(data);
        return photos;
      }
      throw Exception('Unable to fetch data');
    } on SocketException catch (e) {
      print(e.message);
      throw (e.message.toString());
    }
  }

  @override
  void dispose() {
    _httpClient.close();
  }
}
