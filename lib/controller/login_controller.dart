import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_clind_app/model/user.dart';
import 'package:food_delivery_clind_app/pages/home_page.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otp_text_field_v2/otp_field_v2.dart';

class LoginController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference userCollection;

  GetStorage box = GetStorage();

  TextEditingController Registernamecontroller = TextEditingController();
  TextEditingController Registerphone_nocontroller = TextEditingController();

  TextEditingController Loginphone_nocontroller = TextEditingController();

  OtpFieldControllerV2 otpController = OtpFieldControllerV2();
  bool otpFieldShown = false;
  int? otpsend;
  int? otpEntere;

  NewUser? loginUser;

  //if the user is already login directly go to the home page
  @override
  void onReady() {
    Map<String, dynamic>? user = box.read("loginUser");
    if (user != null) {
      loginUser = NewUser.fromJson(user);
      Get.to(const HomePage());
    }
    super.onReady();
  }

  @override
  void onInit() {
    userCollection = firestore.collection('users');
    super.onInit();
  }

  addUser() {
    try {
      if (otpsend == otpEntere) {
        //create a new document
        DocumentReference doc = userCollection.doc();
        //create a new document feild
        NewUser user = NewUser(
          id: doc.id,
          name: Registernamecontroller.text,
          phone_no: int.parse(Registerphone_nocontroller.text),
        );
        //convert to json formet
        final userjson = user.toJson();
        doc.set(userjson);

        setasdefauld();

        //create a snackbar for adding successfull
        Get.snackbar("Success", "User added successfully",
            colorText: Colors.green);
      } else {
        Get.snackbar("Error", "OTP is incorrect", colorText: Colors.red);
      }
    } catch (e) {
      //create a snackbar for any error found
      Get.snackbar("Error", e.toString(), colorText: Colors.red);
    }
  }

  sendOtp() async {
    try {
      if (Registernamecontroller.text.isEmpty ||
          Registerphone_nocontroller.text.isEmpty) {
        Get.snackbar("Error", "Please fill the fields", colorText: Colors.red);

        //use return to stop the code
        return;
      }
      final random = Random();
      int otp = 1000 + random.nextInt(9000); //Generates a 4-digit OTP

      String mobileNumber = Registerphone_nocontroller.text;
      //fast2sms API Url
      String url =
          "https://www.fast2sms.com/dev/bulkV2?authorization=8xUXZrCbYhcHeayld0ofu5GApTPsB74FmkvtV3nEKD9IML2w1iOibrKFxo0Ef3D9j2QP87mMdqnwG1Vz&route=otp&variables_values=$otp&flash=0&numbers=$mobileNumber";

      //send the message to user
      Response response = await GetConnect().get(url);
      print(otp);
      print(mobileNumber);
      print(response.body);

      if (response.body != null && response.body['message'] != null) {
        if (response.body['message'][0] == 'SMS sent successfully.') {
          otpFieldShown = true;
          otpsend = otp;
          Get.snackbar("Success", "OTP Send successfully",
              colorText: Colors.green);
        } else {
          Get.snackbar("Error", "Otp Not Send !!", colorText: Colors.red);
        }
      } else {
        Get.snackbar("Error", "Invalid response from SMS service",
            colorText: Colors.red);
      }
    } on Exception catch (e) {
      Get.snackbar("Error", "Otp Not Send !!", colorText: Colors.red);
    } finally {
      update();
    }
  }

  loginWithPhone() async {
    try {
      String phoneNumber = Loginphone_nocontroller.text;
      if (phoneNumber.isNotEmpty) {
        var querySnapshot = await userCollection
            .where('phone_no', isEqualTo: int.tryParse(phoneNumber))
            .limit(1)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          var userdoc = querySnapshot.docs.first;
          var userdata = userdoc.data() as Map<String, dynamic>;
          box.write("loginUser", userdata);
          Get.snackbar("Success", "Login successfull", colorText: Colors.green);
          Loginphone_nocontroller.clear();
          Get.to(const HomePage());
        } else {
          Get.snackbar("Error", "User not found, please register",
              colorText: Colors.red);
        }
      } else {
        Get.snackbar("Error", "please enter a phone number",
            colorText: Colors.red);
      }
    } catch (error) {
      print("Failed to login: $error");
      Get.snackbar("Error", "Failed to login", colorText: Colors.red);
    }
  }

  setasdefauld() {
    Registernamecontroller.clear();
    Registerphone_nocontroller.clear();
    otpController.clear();
    otpFieldShown = false;
    update();
  }
}
