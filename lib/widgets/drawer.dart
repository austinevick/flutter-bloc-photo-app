import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Victor'),
            accountEmail: Text(
              'austine@gmail.com',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Library'),
          ),
          ListTile(
            title: Text('Photos'),
            leading: Icon(Icons.photo),
          ),
          ListTile(
            title: Text('Albums'),
            leading: Icon(Icons.photo_album),
          ),
          ListTile(
            title: Text('Folders'),
            leading: Icon(
              Icons.folder,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Collections'),
          ),
          ListTile(
            title: Text('Memories'),
            leading: Icon(Icons.access_time),
          ),
          ListTile(
            title: Text('People'),
            leading: Icon(Icons.people),
          ),
          ListTile(
            title: Text('Locations'),
            leading: Icon(
              Icons.location_history,
            ),
          ),
          SizedBox(
            height: 35,
          ),
          ListTile(
            title: Text('Settings'),
            leading: Icon(
              Icons.settings,
            ),
          ),
        ],
      ),
    );
  }
}
