import 'package:e_ciftcim/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key? key,
    required this.product,
    this.pressOnSeeMore,
  }) : super(key: key);

  final Product product;
  final GestureTapCallback? pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Satıcı: ${product.seller}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 16,
                  ),
                ],
              ),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // Takip et butonuna tıklanınca yapılacak işlemler
                    },
                    icon: Icon(Icons.add),
                    label: Text("Takip Et"),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: getProportionateScreenWidth(64),
                    decoration: BoxDecoration(
                      color: product.isFavourite ? Color(0xFFFFE6E6) : Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {
                        // Kalp ikonuna tıklanınca yapılacak işlemler
                      },
                      icon: SvgPicture.asset(
                        "assets/icons/Heart Icon_2.svg",
                        color: product.isFavourite ? Color(0xFFFF4848) : Color(0xFFDBDEE4),
                        height: getProportionateScreenWidth(16),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(64),
          ),
          child: Text(
            product.description,
            maxLines: 3,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: 10,
          ),
          child: GestureDetector(
            onTap: pressOnSeeMore,
            child: Row(
              children: [
                Text(
                  "Daha fazla detay gör",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor,
                  ),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: kPrimaryColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
