import 'package:flutter/material.dart';
import 'package:food_delivery_clind_app/controller/login_controller.dart';
import 'package:food_delivery_clind_app/pages/home_page.dart';
import 'package:food_delivery_clind_app/pages/login_page.dart';
import 'package:food_delivery_clind_app/widgets/otp_text_field.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  get verificationId => null;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (ctrl) {
      return Scaffold(
        body: Container(
          padding: EdgeInsets.all(20),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.blueGrey[50],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Create Your Account !!",
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: ctrl.Registernamecontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  prefixIcon: Icon(Icons.phone_android),
                  labelText: "Name",
                  hintText: "Enter your name",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: ctrl.Registerphone_nocontroller,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  prefixIcon: Icon(Icons.phone_android),
                  labelText: "Phone Number",
                  hintText: "Enter your Phone Number",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              OtpTextField(
                otpController: ctrl.otpController,
                visible: ctrl.otpFieldShown,
                complete: (otp) {
                  ctrl.otpEntere = int.tryParse(otp);
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (ctrl.otpFieldShown) {
                      ctrl.addUser();
                    } else {
                      ctrl.sendOtp();
                      print(ctrl.Registerphone_nocontroller.text);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(ctrl.otpFieldShown ? "Register" : "Send OTP")),
              TextButton(
                  onPressed: () {
                    Get.to(LoginPage());
                  },
                  child: Text("login"))
            ],
          ),
        ),
      );
    });
  }
}
