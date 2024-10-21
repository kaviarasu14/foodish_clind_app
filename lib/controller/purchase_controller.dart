import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_clind_app/controller/login_controller.dart';
import 'package:food_delivery_clind_app/model/user.dart';
import 'package:food_delivery_clind_app/pages/home_page.dart';
import 'package:get/get.dart';

class PurchaseController extends GetxController {
  TextEditingController addresscontroller = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference orderCollection;

  double orderprice = 0;
  String itemName = '';
  String orderAddress = '';

  @override
  void onInit() {
    orderCollection = firestore.collection('orders');
    super.onInit();
  }

  supmitOrder({
    required double price,
    required String item,
    required String description,
  }) {
    if (addresscontroller.text.isEmpty) {
      Get.snackbar('Error', 'Please give the address', colorText: Colors.red);
    } else {
      orderAddress = addresscontroller.text;
      itemName = item;
      orderprice = price;
      orderSuccess();
    }
  }

  Future<void> orderSuccess() async {
    NewUser? loginUse = Get.find<LoginController>().loginUser;

    if (addresscontroller.text.isNotEmpty) {
      DocumentReference docref = await orderCollection.add({
        'address': orderAddress,
        'customer': loginUse?.name ?? '',
        'dateTime': DateTime.now().toString(),
        'item': itemName,
        'phone': loginUse?.phone_no ?? '',
        'price': orderprice,
        'transactionId': 'no payment',
      });

      showOrderSuccessDialog(docref.id);

      Get.snackbar('Success', 'Order is placed Successfully',
          colorText: Colors.green);
    } else {
      Get.snackbar('Success', 'Order is placed Successfully',
          colorText: Colors.green);
    }
  }

  void showOrderSuccessDialog(String orderId) {
    Get.defaultDialog(
        title: "Order Success",
        content: Text('Your OrderId is [$orderId]'),
        confirm: TextButton(
          onPressed: () {
            Get.off(HomePage());
            addresscontroller.clear();
          },
          child: Text('Close'),
        ));
  }
}
