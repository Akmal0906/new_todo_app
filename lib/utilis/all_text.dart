import 'dart:ui';

import 'package:flutter/material.dart';

abstract class AllText{
  static const String splashText1='Reminders made simple';
  static const String splashText2='Get Started';
  static const String noTask='No tasks';
  static const String addTaskTitle='Add new task';
  static const String addTask='Add task';

}
TextStyle customStyle=const TextStyle(color: Colors.white,fontSize: 14,fontFamily: 'Regular');

List<String> groupList=['Personal','Work','Meeting','Study','Shopping','Party','other'];