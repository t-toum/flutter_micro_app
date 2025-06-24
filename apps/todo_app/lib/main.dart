
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/app_module.dart';
import 'package:todo_app/app_widget.dart';

void main() {
  runApp(ModularApp(module: AppModule(), child: AppWidget()));
}
