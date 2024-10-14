import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Home_Module/home_screen.dart';

class LoginController extends GetxController{

   handleSignIn() async {
   GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
   GoogleSignInAuthentication? gAuth = await gUser!.authentication;
   final credential = GoogleAuthProvider.credential(
     accessToken: gAuth.accessToken,
     idToken: gAuth.idToken,
   );

   if(gAuth.idToken!=""&&gAuth.idToken!=null) {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     await prefs.setString('userEmail', gUser.email ?? '');
     await prefs.setString('userName', gUser.displayName ?? '');
     Get.to(() => ProductScreen());

   }


   print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${gUser.email}");
   print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${gUser.displayName}");
   print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${gAuth.idToken}");



  }


}