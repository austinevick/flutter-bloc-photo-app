part of 'photos_bloc.dart';

abstract class PhotosEvent extends Equatable {
  const PhotosEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends PhotosEvent {}

class RefreshPage extends PhotosEvent {}

class LoadMorePhotos extends PhotosEvent {
  final List<Photos> photos;
  LoadMorePhotos({
    this.photos,
  });
  @override
  List<Object> get props => [photos];
  @override
  String toString() => 'LoadMorePhotos { photos: $photos}';
}
