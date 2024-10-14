import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Home_Module/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firebase Firestore
import 'package:firebase_core/firebase_core.dart';
class HomeController extends GetxController{

RxList<QueryDocumentSnapshot> getFoodDetails=<QueryDocumentSnapshot>[].obs;

  void addDataToFirebase()async{
  var getFoodDetailsTemp= await FirebaseFirestore.instance.collection("FoodDetails").get();

  getFoodDetails.value=getFoodDetailsTemp.docs;

  }


}