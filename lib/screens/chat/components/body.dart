import 'package:e_ciftcim/components/socal_card.dart';
import 'package:e_ciftcim/constants.dart';
import 'package:e_ciftcim/size_config.dart';
import 'package:flutter/material.dart';

import '../../complete_profile/complete_profile_screen.dart';
import 'chat_form.dart';
import 'contact_display.dart';

class Body extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child:
                MessagePanelDisplay(),

            ),
        ),
      ),
    );
  }
}
