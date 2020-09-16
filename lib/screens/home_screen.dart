import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_gallery_app/blocs/photos/photos_bloc.dart';
import 'package:flutter_bloc_gallery_app/screens/photo_full_screen.dart';
import 'package:flutter_bloc_gallery_app/widgets/app_bar.dart';
import 'package:flutter_bloc_gallery_app/widgets/drawer.dart';
import 'package:flutter_bloc_gallery_app/widgets/responsive.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool selectedIndex = true;
  AudioCache audioCache;
  final date = DateTime.now();
  @override
  void initState() {
    audioCache = AudioCache(
      prefix: 'assets/',
      fixedPlayer: AudioPlayer()
        ..setReleaseMode(
          ReleaseMode.STOP,
        ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotosBloc, PhotosState>(builder: (context, state) {
      return Scaffold(
        drawer: CustomDrawer(),
        appBar: PreferredSize(
            preferredSize: Size(100, 100),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Responsive.isDesktop(context)
                  ? CustomAppBarDesktop()
                  : CustomAppBarMobile(),
            )),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  bottom: 10,
                ),
                child: Row(
                  children: [
                    Text(
                      '${DateFormat('dd/MM/yyyy').format(date)} - ${getPhotoLength(state)} images',
                    ),
                    Spacer(),
                    IconButton(
                      icon: selectedIndex
                          ? Icon(Icons.grid_view)
                          : Icon(Icons.crop_square),
                      onPressed: () => setState(() {
                        selectedIndex = !selectedIndex;
                        audioCache.play('sound.mp3');
                      }),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 15,
                child: selectedIndex
                    ? buildPhoto(state, context, audioCache)
                    : buildPhotoPageView(state, context, audioCache)),
          ],
        ),
      );
    });
  }

  getPhotoLength(PhotosState state) {
    if (state is PhotosLoaded) {
      return state.photos.length;
    }
  }

  Widget buildPhotoPageView(
      PhotosState state, BuildContext context, AudioCache audioCache) {
    if (state is PhotosLoading) {
      return Center(
        child: Text('Please wait...'),
      );
    } else if (state is PhotosLoaded) {
      return RefreshIndicator(
        onRefresh: () async {
          context.bloc<PhotosBloc>().add(RefreshPage());
        },
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.photos.length,
            itemBuilder: (context, i) {
              final photo = state.photos[i];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Hero(
                  tag: photo.id,
                  child: BouncingWidget(
                    duration: Duration(milliseconds: 200),
                    scaleFactor: 1,
                    onPressed: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          reverseTransitionDuration: Duration(seconds: 1),
                          fullscreenDialog: true,
                          transitionDuration: Duration(seconds: 1),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) =>
                                  FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  ),
                          pageBuilder:
                              (context, animation, secondaryAnimatiom) {
                            return PhotoFullScreen(
                              photos: photo,
                              audioCache: audioCache,
                            );
                          }));
                      audioCache.play('sound.mp3');
                    },
                    child: Container(
                      height: 500,
                      width: 350,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              photo.original,
                            )),
                      ),
                    ),
                  ),
                ),
              );
            }),
      );
    } else if (state is PhotosError) {
      return Center(
        child: Column(
          children: [
            Text(
              'Error loading coins\n Please check your internet connection',
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            FlatButton(
                onPressed: () {
                  context.bloc<PhotosBloc>().add(RefreshPage());
                },
                child: Text('Try again'))
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}

Widget buildPhoto(
    PhotosState state, BuildContext context, AudioCache audioCache) {
  if (state is PhotosLoading) {
    return Center(
      child: Text('Please wait...'),
    );
  } else if (state is PhotosLoaded) {
    return RefreshIndicator(
      onRefresh: () async {
        context.bloc<PhotosBloc>().add(RefreshPage());
      },
      child: GridView.builder(
          itemCount: state.photos.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          itemBuilder: (context, i) {
            final photo = state.photos[i];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Hero(
                tag: photo.id,
                child: BouncingWidget(
                  duration: Duration(milliseconds: 200),
                  scaleFactor: 1,
                  onPressed: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        reverseTransitionDuration: Duration(seconds: 1),
                        fullscreenDialog: true,
                        transitionDuration: Duration(seconds: 1),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) =>
                                FadeTransition(
                                  opacity: animation,
                                  child: child,
                                ),
                        pageBuilder: (context, animation, secondaryAnimatiom) {
                          return PhotoFullScreen(
                            photos: photo,
                            audioCache: audioCache,
                          );
                        }));
                    audioCache.play('sound.mp3');
                  },
                  child: Container(
                    height: 500,
                    width: 500,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            photo.original,
                          )),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  } else if (state is PhotosError) {
    return Center(
      child: Column(
        children: [
          Text(
            'Error loading coins\n Please check your internet connection',
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          FlatButton(
              onPressed: () {
                context.bloc<PhotosBloc>().add(RefreshPage());
              },
              child: Text('Try again'))
        ],
      ),
    );
  } else {
    return Container();
  }
}
