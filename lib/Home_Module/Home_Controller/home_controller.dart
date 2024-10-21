import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Home_Module/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firebase Firestore
import 'package:firebase_core/firebase_core.dart';


class HomeController extends GetxController{

RxList<QueryDocumentSnapshot> getFoodDetails=<QueryDocumentSnapshot>[].obs;


RxList<Map> orderDetail=<Map>[].obs;
RxDouble totalAmount=0.0.obs;

  void getDataToFirebase()async{
  var getFoodDetailsTemp= await FirebaseFirestore.instance.collection("FoodDetails").get();

  getFoodDetails.value=getFoodDetailsTemp.docs;

  }
String? savedEmail ;
String? userName;
Future<void> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    savedEmail = prefs.getString('userEmail');
     userName = prefs.getString('userName');
  }

void storeOrderDetails({required totalItems})async{
  await getUserDetails();
  await FirebaseFirestore.instance.collection("OrderDetails").doc().set({
    "foodDetails":orderDetail,
    "totalItem":totalItems,
    "totalAmount":totalAmount.value,
    "totalDish":orderDetail.length,
    "name":userName,
    "email":savedEmail,
  });

  orderDetail.clear();
  totalAmount.value=0.0;

  Get.offAll(ProductScreen());

}



}