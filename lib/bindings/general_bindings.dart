import 'package:get/get.dart';
import 'package:myapp/admins_authentication/admin_service/adminauth_service.dart';
import 'package:myapp/community_participant/controllers/auth_controller.dart';
import 'package:myapp/community_participant/controllers/navcontroller.dart';
import 'package:myapp/community_participant/controllers/onboardingcontroller.dart';
import 'package:myapp/community_participant/controllers/signup_controller.dart';
import 'package:myapp/community_participant/controllers/token_controller.dart';
import 'package:myapp/core/utils/helpers/network_manager.dart';
import 'package:myapp/repository/auth_repo.dart';
import 'package:myapp/waste_collector/controllers/waste_controller.dart';

class GeneralBindings extends Bindings{
  @override
  void dependencies (){
    Get.put(NetworkManager());
        Get.lazyPut(()=>OnboardingController());
        Get.lazyPut(()=>AuthRepo());
        Get.lazyPut(()=>AuthService());
        Get.lazyPut(()=>SignupController());
        Get.lazyPut(()=>NavController());
        Get.lazyPut(()=>AuthController());
        Get.lazyPut(()=>WasteController());
        Get.lazyPut(()=>TokenController());
        }
}