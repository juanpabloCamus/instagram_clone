import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/add_post_screen.dart';
import 'package:instagram_clone/screens/feed_sceen.dart';

const int webScreenSize = 600;

const List<Widget> homeScreenItems = <Widget>[
  FeedScreen(),
  Text('search'),
  AddPostScreen(),
  Text('fav'),
  Text('prof'),
];
