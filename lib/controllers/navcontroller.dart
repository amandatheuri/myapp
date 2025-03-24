import 'package:get/get.dart';
import 'package:myapp/app_user/screens/challenges.dart';
import 'package:myapp/app_user/screens/dispose.dart';
import 'package:myapp/app_user/screens/rewards.dart';
import 'package:myapp/app_user/screens/user_dashboard.dart';

class NavController extends GetxController{

 final Rx<int> selectedIndex = 0.obs;
 final screens = [
  UserDashboard(),
  RewardsScreen(),
  DisposePage(),
  ChallengesScreen()
 ];


 }