import 'package:flutter/material.dart';

import 'text_field.dart';

class CustomAppBarMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        IconButton(
          icon: Icon(Icons.add_a_photo),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.share),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
      ],
    );
  }
}

class CustomAppBarDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      elevation: 0,
      title: CustomSearchBar(),
      actions: [
        SizedBox(
          width: 20,
        ),
        FlatButton.icon(
            hoverColor: Colors.purpleAccent,
            onPressed: () {},
            icon: Icon(
              Icons.add_a_photo,
              size: 28,
            ),
            label: Text('New Photo')),
        FlatButton.icon(
            hoverColor: Colors.purpleAccent,
            onPressed: () {},
            icon: Icon(
              Icons.select_all_sharp,
              size: 28,
            ),
            label: Text('Select')),
        FlatButton.icon(
            hoverColor: Colors.purpleAccent,
            onPressed: () {},
            icon: Icon(
              Icons.share,
              size: 28,
            ),
            label: Text('share')),
        PopupMenuButton(
            itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text('more'),
                  ),
                ])
      ],
    );
  }
}
