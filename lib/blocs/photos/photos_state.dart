part of 'photos_bloc.dart';

abstract class PhotosState extends Equatable {
  const PhotosState();

  @override
  List<Object> get props => [];
}

class PhotosEmpty extends PhotosState {}

class PhotosLoading extends PhotosState {}

class PhotosLoaded extends PhotosState {
  final List<Photos> photos;
  PhotosLoaded({
    this.photos,
  });
  @override
  List<Object> get props => [photos];
  @override
  String toString() => 'PhotoLoaded { photos: $photos}';
}

class PhotosError extends PhotosState {}
