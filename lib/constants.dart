import 'package:e_ciftcim/size_config.dart';
import 'package:flutter/material.dart';

const kPrimaryColor = Color.fromARGB(255, 107, 191, 89);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Lütfen E-postanızı giriniz";
const String kInvalidEmailError = "Lütfen Valid E-mailinizi giriniz";
const String kPassNullError = "Lütfen şifrenizi giriniz";
const String kShortPassError = "Şifre çok kısa";
const String kMatchPassError = "Şifreler eşleşmiyor";
const String kNamelNullError = "Lütfen adınızı giriniz";
const String kPhoneNumberNullError = "Lütfen telefon numaranızı giriniz";
const String kAddressNullError = "Lütfen adresinizi giriniz";
const String kMessageNullError= "Boş mesaj gönderilemez!";
const String kSexNullError= "Cinsiyetinizi giriniz";


final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}
