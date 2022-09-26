import 'package:best_flutter_ui_templates/HomePage/Contacts.dart';
import 'package:best_flutter_ui_templates/HomePage/Gym.dart';
import 'package:best_flutter_ui_templates/HomePage/Office.dart';
import 'package:best_flutter_ui_templates/fitness_app/training/training_screen.dart';
import '../design_course/home_design_course.dart';
import '../fitness_app/fitness_app_home_screen.dart';
import '../fitness_app/fitness_app_lunch_screen.dart';
import '../hotel_booking/hotel_home_screen.dart';
import '../introduction_animation/introduction_animation_screen.dart';
import '../HomePage/chat_with_doctor.dart';
import '../HomePage/underbelly.dart';
import 'package:flutter/widgets.dart';

class HomeList {
  HomeList({
    this.navigateScreen,
    this.imagePath = '',
  });

  Widget? navigateScreen;
  String imagePath;

  static List<HomeList> homeList = [
    HomeList(
      imagePath: 'assets/images/Profile.png',
      navigateScreen: FitnessAppLunchScreen(),
    ),
    HomeList(
      imagePath: 'assets/Contacts/Contacts.png',
      navigateScreen: ContactsScreen(),
    ),
    HomeList(
      imagePath: 'assets/Office/Office.png',
      navigateScreen: OfficeScreen(),
    ),
    HomeList(
      imagePath: 'assets/Cleaning/Cleaning.png',
      navigateScreen: FitnessAppHomeScreen(),
    ),
    HomeList(
      imagePath: 'assets/fitness_app/Gym.png',
      navigateScreen: GymScreen(),
    ),
    HomeList(
      imagePath: 'assets/fitness_app/lunch.png',
      navigateScreen: FitnessAppLunchScreen(),
    ),
    HomeList(
      imagePath: 'assets/hotel/underbelly.jpeg',
      navigateScreen: UnderbellyScreen(),
    ),
    HomeList(
      imagePath: 'assets/doctor/doctor.png',
      navigateScreen: ChatWithDoctorScreen(),
    ),
    HomeList(
      imagePath: 'assets/design_course/webInterFace.png',
      navigateScreen: FitnessAppHomeScreen(),
    ),
    HomeList(
      imagePath: 'assets/images/calculator.jpg',
      navigateScreen: FitnessAppLunchScreen(),
    ),
    HomeList(
      imagePath: 'assets/Complaint/Complaint.png',
      navigateScreen: FitnessAppLunchScreen(),
    ),
  ];
}
