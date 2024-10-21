import 'package:flutter/material.dart';
import 'package:food_delivery_clind_app/controller/home_controller.dart';
import 'package:food_delivery_clind_app/pages/login_page.dart';
import 'package:food_delivery_clind_app/pages/product_description_page.dart';
import 'package:food_delivery_clind_app/widgets/Multiselect_DropDown_btn.dart';
import 'package:food_delivery_clind_app/widgets/drop_down_btn.dart';
import 'package:food_delivery_clind_app/widgets/product_card.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return RefreshIndicator(
        onRefresh: () async {
          ctrl.fetchFoods();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(
                "Foodie world",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
            actions: [
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Logout"),
                            content: const Text(
                                "if you want to logout, your all data will be cleared"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    GetStorage box = GetStorage();
                                    box.erase();
                                    Get.offAll(LoginPage());
                                  },
                                  child: const Text(("Clear")))
                            ],
                          );
                        });
                  },
                  icon: Icon(Icons.logout))
            ],
          ),
          body: Column(
            children: [
              SizedBox(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: ctrl.foodCategories.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          ctrl.filterByCategory(
                              ctrl.foodCategories[index].name ?? '');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Chip(
                              label: Text(
                                  ctrl.foodCategories[index].name ?? 'Error')),
                        ),
                      );
                    }),
              ),
              Row(
                children: [
                  Flexible(
                    child: DropDownBtn(
                        items: ["Rs: low to high", "Rs: high to low"],
                        selectedTextitem: "sort",
                        onselected: (selectedValue) {
                          ctrl.sortedByPrice(
                              ascending: selectedValue == "Rs: low to high"
                                  ? true
                                  : false);
                        }),
                  ),
                  Flexible(
                      child: MultiselectDropdownBtn(
                    items: [
                      "anbuselvi teastall",
                      "aryabhavan",
                      "sathya",
                      "MalaiRam",
                      "A1"
                    ],
                    onSelectionChanged: (selectedItems) {
                      ctrl.filterByShops(selectedItems);
                    },
                  )),
                ],
              ),
              Expanded(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8),
                    itemCount: ctrl.sortedfoodsshowUi.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        Name: ctrl.sortedfoodsshowUi[index].name ?? 'No name',
                        ImageUrl: ctrl.sortedfoodsshowUi[index].image ?? 'Url',
                        Price: ctrl.sortedfoodsshowUi[index].price ?? 00,
                        offerTag: '0% off',
                        onTap: () {
                          Get.to(() => ProductDescriptionPage(), arguments: {
                            'data': ctrl.sortedfoodsshowUi[index]
                          });
                        },
                      );
                    }),
              )
            ],
          ),
        ),
      );
    });
  }
}
