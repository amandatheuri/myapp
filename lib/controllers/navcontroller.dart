import 'package:get/get.dart';
import 'package:myapp/screens/challenges.dart';
import 'package:myapp/screens/dispose.dart';
import 'package:myapp/screens/rewards.dart';
import 'package:myapp/screens/user_dashboard.dart';

class NavController extends GetxController{

 final Rx<int> selectedIndex = 0.obs;
 final screens = [
  UserDashboard(),
  RewardsScreen(),
  DisposeScreen(),
  ChallengesScreen()
 ];


 }