
import 'package:e_ciftcim/screens/cart/cart_screen.dart';
import 'package:e_ciftcim/screens/chat/chat_screen.dart';
import 'package:e_ciftcim/screens/chat/components/chat_form.dart';
import 'package:e_ciftcim/screens/complete_profile/complete_profile_screen.dart';
import 'package:e_ciftcim/screens/details/details_screen.dart';
import 'package:e_ciftcim/screens/forgot_password/forgot_password_screen.dart';
import 'package:e_ciftcim/screens/home/home_screen.dart';
import 'package:e_ciftcim/screens/login_success/login_success_screen.dart';
import 'package:e_ciftcim/screens/otp/otp_screen.dart';
import 'package:e_ciftcim/screens/profile/profile_screen.dart';
import 'package:e_ciftcim/screens/sign_in/sign_in_screen.dart';
import 'package:e_ciftcim/screens/splash/splash_screen.dart';
import 'package:flutter/widgets.dart';

import 'screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  ChatScreen.routeName: (context) => ChatScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),


};
