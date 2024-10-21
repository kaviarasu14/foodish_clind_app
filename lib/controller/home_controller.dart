import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_clind_app/model/food/food.dart';
import 'package:food_delivery_clind_app/model/food_category/food_category.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference foodcollection;
  late CollectionReference categorycollections;

  List<Food> foods = [];
  List<Food> sortedfoodsshowUi = [];
  List<FoodCategory> foodCategories = [];

  @override
  Future<void> onInit() async {
    //call the collection from firebasefirestore
    foodcollection = firestore.collection("foods");
    categorycollections = firestore.collection("category");

    await fetchCategory();

    //fetchfoods
    await fetchFoods();

    super.onInit();
  }

  fetchFoods() async {
    try {
      QuerySnapshot foodsnapshot = await foodcollection.get();
      final List<Food> retraivedfoods = foodsnapshot.docs
          .map((doc) => Food.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      //clear the previous collection documents
      foods.clear();

      //assign new data to the collection
      foods.assignAll(retraivedfoods);

      sortedfoodsshowUi.assignAll(foods);

      Get.snackbar("Success", "Food fetched successfully",
          colorText: Colors.blueGrey[400]);
    } catch (e) {
      Get.snackbar("Error", e.toString(), colorText: Colors.blueGrey[400]);
    } finally {
      update();
    }
  }

  fetchCategory() async {
    try {
      QuerySnapshot categorysnapshot = await categorycollections.get();
      final List<FoodCategory> retraivedcategories = categorysnapshot.docs
          .map((doc) =>
              FoodCategory.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      //clear the previous collection documents
      foodCategories.clear();

      //assign new data to the collection
      foodCategories.assignAll(retraivedcategories);
    } catch (e) {
      Get.snackbar("Error", e.toString(), colorText: Colors.blueGrey[400]);
    } finally {
      update();
    }
  }

  filterByCategory(String category) {
    sortedfoodsshowUi.clear();
    sortedfoodsshowUi =
        foods.where((food) => food.category == category).toList();
    update();
  }

  filterByShops(List<String> shops) {
    if (shops.isEmpty) {
      sortedfoodsshowUi = foods;
    } else {
      List<String> lowerCaseShops =
          shops.map((shop) => shop.toLowerCase()).toList();
      sortedfoodsshowUi = foods
          .where((food) => lowerCaseShops.contains(food.shop?.toLowerCase()))
          .toList();
    }
    update();
  }

  sortedByPrice({required bool ascending}) {
    List<Food> sortedfoods = List<Food>.from(sortedfoodsshowUi);
    sortedfoods.sort((a, b) => ascending
        ? a.price!.compareTo(b.price!)
        : b.price!.compareTo(a.price!));
    sortedfoodsshowUi = sortedfoods;
    update();
  }
}
