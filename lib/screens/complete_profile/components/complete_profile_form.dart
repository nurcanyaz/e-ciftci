import 'package:e_ciftcim/Controllers/ProfileController.dart';
import 'package:e_ciftcim/components/custom_surfix_icon.dart';
import 'package:e_ciftcim/components/default_button.dart';
import 'package:e_ciftcim/components/form_error.dart';
import 'package:e_ciftcim/models/User.dart';
import 'package:e_ciftcim/screens/home/home_screen.dart';
import 'package:e_ciftcim/screens/otp/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/Combobox.dart';
import '../../../size_config.dart';

class CompleteProfileForm extends StatefulWidget {
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? sex;
  String? username;
  String? iconFilename;

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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildUsernameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildSexFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "continue",
            press: () {

              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                iconFilename = (sex == 'Kadın') ? 'female.png' : 'male.png';
                Map<String, dynamic> updatedData = {
                  'fName': firstName,
                  'lName': lastName,
                  'telno': phoneNumber,
                  'seller': false,
                  'username': username,
                  'sex': sex,
                  'icon': iconFilename,
                };
                final user= FirebaseAuth.instance;
                UserProfileController userProfile= UserProfileController();
                userProfile.updateProfile(user.currentUser!.uid, updatedData);

                Navigator.pushNamed(context, HomeScreen.routeName);



              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildUsernameFormField() {
    return TextFormField(
      onSaved: (newValue) => username = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Kullanıcı adı",
        hintText: "Kullanıcı adınızı giriniz"
            ,

        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Telefon numara",
        hintText: "Telefon numaranızı giriniz",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      onSaved: (newValue) => lastName = newValue,
      decoration: InputDecoration(
        labelText: "Soyad",
        hintText: "Soyadınızı giriniz",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.dart.svg"),
      ),
    );
  }

  CustomComboBoxFormField buildSexFormField() {
    return CustomComboBoxFormField(
      labelText: "Cinsiyet",
      hintText: "Cinsiyetinizi giriniz",
      options: ['Erkek', 'Kadın'],

    onSaved: (value) => sex =value
    ,
      onChanged: (newValue) {
        if (newValue!.isNotEmpty) {
          removeError(error: kSexNullError);
        }
        return null;
      },
    validator: (value) {
    if (value == null || value.isEmpty) {
     addError(error: kSexNullError);
    }
    return null; // No error
    },
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      onSaved: (newValue) => firstName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Ad",
        hintText: "Adınızı giriniz",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.dart.svg"),
      ),
    );
  }
}
