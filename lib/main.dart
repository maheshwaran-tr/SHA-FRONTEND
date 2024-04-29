import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sha/allotment_pages/alotting_details_page.dart';
import 'package:sha/hall_pages/add_hall_page.dart';
import 'package:sha/allotment.dart';
import 'package:sha/home_page.dart';
import 'package:sha/profile_pages/profile_page.dart';
import 'package:sha/register_page.dart';
import 'package:sha/exam_pages/schedule_exam_page.dart';
import 'package:sha/student_list_page.dart';
import 'package:http/http.dart' as http;


import 'exam_pages/exam_list.dart';
import 'hall_pages/hall_list.dart';
import 'login_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();



  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SeatMaster',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
      routes: {
        '/register': (context) => RegisterPage(),
        '/login': (context) => LoginPage(),
        '/main': (context) => MainScreen(),
        '/addHall': (context) => AddHallScreen(),
        '/scheduleExam': (context) => ScheduleExamScreen(),
        '/studentList': (context) => StudentListScreen(),
        '/allotment': (context) => SelectHallPage(),
        // '/allotment': (context) => HallVisualizationScreen(hallList: hall,),
        '/hallList':(context) => HallList(),
        '/examList':(context) => ExamList(),
        '/profile':(context) => AdminProfilePage(),
      },
    );
  }
}

