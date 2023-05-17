import 'package:e_ciftcim/models/Cart.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Sepetim",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "${demoCarts.length} ürün",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
