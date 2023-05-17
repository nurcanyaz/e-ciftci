import 'package:e_ciftcim/components/rounded_icon_btn.dart';
import 'package:e_ciftcim/models/Product.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ColorDots extends StatefulWidget {
  const ColorDots({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  _ColorDotsState createState() => _ColorDotsState();
}

class _ColorDotsState extends State<ColorDots> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundedIconBtn(
            icon: Icons.remove,
            press: () {
              setState(() {
                if (quantity > 1) {
                  quantity--;
                }
              });
            },
          ),
          SizedBox(width: getProportionateScreenWidth(20)),
          Text(
            quantity.toString(),
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(width: getProportionateScreenWidth(20)),
          RoundedIconBtn(
            icon: Icons.add,
            showShadow: true,
            press: () {
              setState(() {
                quantity++;
              });
            },
          ),
        ],
      ),
    );
  }
}


