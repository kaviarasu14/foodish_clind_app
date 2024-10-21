import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_clind_app/controller/home_controller.dart';
import 'package:food_delivery_clind_app/controller/purchase_controller.dart';
import 'package:food_delivery_clind_app/model/food/food.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class ProductDescriptionPage extends StatelessWidget {
  const ProductDescriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    Food food = Get.arguments['data'];
    return GetBuilder<PurchaseController>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "Food Details",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  food.image ?? '',
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                food.name ?? '',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                food.description ?? '',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Rs: ${food.price ?? ''}",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: ctrl.addresscontroller,
                maxLines: 4,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: "Enter Your Billing Address",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      ctrl.supmitOrder(
                          price: food.price ?? 0,
                          item: food.name ?? '',
                          description: food.description ?? '');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                    ),
                    child: Text("Buy Now")),
              ),
            ],
          ),
        ),
      );
    });
  }
}
