import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc_gallery_app/models/photos.dart';
import 'package:flutter_bloc_gallery_app/repository/photo_repository.dart';

part 'photos_event.dart';
part 'photos_state.dart';

class PhotosBloc extends Bloc<PhotosEvent, PhotosState> {
  final PhotoRepository _photoRepository;
  PhotosBloc({@required PhotoRepository photoRepository})
      : assert(photoRepository != null),
        _photoRepository = photoRepository,
        super(null);
  @override
  Stream<PhotosState> mapEventToState(PhotosEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is RefreshPage) {
      yield* _mapRefreshPageToState(photos: []);
    } else if (event is LoadMorePhotos) {
      yield* _mapLoadMorePhotosToState(event);
    }
  }

  Stream<PhotosState> _mapRefreshPageToState({List<Photos> photos}) async* {
    try {
      List<Photos> newPhotoList = photos + await _photoRepository.getPhotos();
      yield PhotosLoaded(photos: newPhotoList);
    } catch (e) {
      yield PhotosError();
    }
  }

  Stream<PhotosState> _mapAppStartedToState() async* {
    yield PhotosLoading();
    yield* _mapRefreshPageToState(photos: []);
  }

  Stream<PhotosState> _mapLoadMorePhotosToState(LoadMorePhotos event) async* {}
}
