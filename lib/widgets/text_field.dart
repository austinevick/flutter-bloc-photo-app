import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: TextField(
          decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              fillColor: Colors.white,
              disabledBorder: InputBorder.none,
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              hintText: 'Search photos'),
        ),
      ),
    );
  }
}
