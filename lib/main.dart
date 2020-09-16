import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_gallery_app/screens/home_screen.dart';

import 'blocs/photos/photos_bloc.dart';
import 'repository/photo_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PhotosBloc>(
      create: (context) => PhotosBloc(
        photoRepository: PhotoRepository(),
      )..add(AppStarted()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        home: HomeScreen(),
      ),
    );
  }
}
