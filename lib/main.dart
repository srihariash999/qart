import 'package:flutter/material.dart';
import 'package:qart_assignment/service_locator.dart';
import 'package:qart_assignment/views/homepage.dart';

void main() {
  setupLocator();
  runApp(
    MaterialApp(
      home: HomePage(),
    ),
  );
}
