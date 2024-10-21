import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String Name;
  final String ImageUrl;
  final double Price;
  final String offerTag;
  final Function onTap;

  const ProductCard(
      {super.key,
      required this.Name,
      required this.ImageUrl,
      required this.Price,
      required this.offerTag,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                ImageUrl,
                fit: BoxFit.cover,
                width: double.maxFinite,
                height: 120,
              ),
              SizedBox(
                height: 9,
              ),
              Text(
                Name,
                style: TextStyle(fontSize: 16, overflow: TextOverflow.ellipsis),
              ),
              SizedBox(
                height: 9,
              ),
              Text(
                "Rs :$Price",
                style: TextStyle(fontSize: 16, overflow: TextOverflow.ellipsis),
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    offerTag,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
