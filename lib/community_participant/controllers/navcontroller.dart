import 'package:get/get.dart';
import 'package:myapp/community_participant/screens/challenges.dart';
import 'package:myapp/community_participant/screens/dispose.dart';
import 'package:myapp/community_participant/screens/rewards.dart';
import 'package:myapp/community_participant/screens/user_dashboard.dart';

class NavController extends GetxController{

 final Rx<int> selectedIndex = 0.obs;
 final screens = [
  UserDashboard(),
  RewardsScreen(),
  DisposePage(),
  ChallengesScreen()
 ];


 }