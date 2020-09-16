import 'package:flutter_bloc_gallery_app/models/photos.dart';

abstract class PhotoBaseRepository {
  Future<List<Photos>> getPhotos();
  void dispose();
}
