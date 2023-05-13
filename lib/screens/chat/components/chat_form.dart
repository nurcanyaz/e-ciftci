import 'package:e_ciftcim/components/custom_surfix_icon.dart';
import 'package:e_ciftcim/components/default_button.dart';
import 'package:e_ciftcim/components/form_error.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../firebase_options.dart';
import '../../../size_config.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  late String msg;

  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  Future<void> firebase() async {
// Ideal time to initialize
  }

//...
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (BuildContext context, AsyncSnapshot<FirebaseApp> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return Form(
              key: _formKey,
              child: Column(
                children: [

                  buildMessageFormField(),
                  FormError(errors: errors),
                  SizedBox(height: getProportionateScreenHeight(40), width: getProportionateScreenWidth(100) ,),
                  DefaultButton(
                    text: "➤",
                    press: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        try {

                        } on FirebaseAuthException catch (e) {
                          if (e.code == "") addError(error: e.code);
                        }

                        // if all are valid then go to success screen
                        // Navigator.pushNamed(context, CompleteProfileScreen.routeName);// this used to be the complete_profile screen
                      }
                    },
                  ),
                ],
              ),
            );

          default:
            return const Text("Loading");
        }
      },
    );
  }

  TextFormField buildMessageFormField() {
    return TextFormField(
      obscureText: false,
      onSaved: (newValue) => msg = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kMessageNullError);
        }
        msg = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kMessageNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Buraya mesajinizi yaziniz...",
        floatingLabelBehavior: FloatingLabelBehavior.always,

      ),
    );
  }


}
