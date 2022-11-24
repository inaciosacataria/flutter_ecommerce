import 'package:ecommerce_int2/screens/auth/admin_login.dart';
import 'package:ecommerce_int2/screens/auth/register_page.dart';
import 'package:ecommerce_int2/screens/auth/registration-page-owner.dart';
import 'package:ecommerce_int2/screens/auth/welcome_back-page-owner.dart';
import 'package:ecommerce_int2/screens/auth/welcome_back_driver.dart';
import 'package:ecommerce_int2/screens/auth/welcome_back_page.dart';
import 'package:ecommerce_int2/screens/intro_page.dart';
import 'package:ecommerce_int2/screens/main/components/shop_item_list.dart';
import 'package:ecommerce_int2/screens/main/main_page.dart';
import 'package:ecommerce_int2/screens/marketplace/ProductsMarketPlace.dart';
import 'package:ecommerce_int2/screens/marketplace/SellProductUser.dart';
import 'package:ecommerce_int2/screens/marketplace/marketPlacePage.dart';
import 'package:ecommerce_int2/screens/profile_page_content/orderHistoryUser.dart';
import 'package:ecommerce_int2/screens/profile_page_content/showMessageDriver.dart';
import 'package:ecommerce_int2/screens/profile_page_content/showMessageUser.dart';
import 'package:ecommerce_int2/screens/profile_page_content/showMessagesAdmin.dart';
import 'package:flutter/material.dart';

import 'screens/profile_page_content/accept_repair.dart';
import 'screens/profile_page_content/appointments_user.dart';
import 'screens/profile_page_content/order_request.dart';
import 'screens/profile_page_content/pending_requests.dart';
import 'screens/profile_page_content/repair_request.dart';
import 'screens/profile_page_content/repair_shopwork.dart';
import 'screens/profile_page_content/restrict_seller.dart';
import 'screens/profile_page_content/restrict_user.dart';
import 'screens/profile_page_content/sell_item.dart';
import 'screens/profile_page_content/showMessageSeller.dart';
import 'screens/profile_pages/profile_page.dart';
import 'screens/profile_pages/profile_page_admin.dart';
import 'screens/profile_pages/profile_page_driver.dart';
import 'screens/profile_pages/profile_page_seller.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shope',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.yellow,
        canvasColor: Colors.transparent,
        primarySwatch: Colors.blue,
        fontFamily: "Montserrat",
      ),
      routes: {
        '/': (ctx) => WelcomeBackPage(),
        ProfilePage.routeName: (ctx) => ProfilePage(),
        RegisterPageOwner.routeName: (ctx) => RegisterPageOwner(),
        MainPage.routeName: (ctx) => MainPage(),
        IntroPage.routeName: (ctx) => IntroPage(),
        SellItem.routeName: (ctx) => SellItem(),
        ProfilePageSeller.routeName: (ctx) => ProfilePageSeller(),
        ProfilePageDriver.routeName: (ctx) => ProfilePageDriver(),
        ShopList.routeName: (ctx) => ShopList(),
        ProfilePageAdmin.routeName: (ctx) => ProfilePageAdmin(),
        RepairShopwork.routeName: (ctx) => RepairShopwork(),
        RestrictUser.routeName: (ctx) => RestrictUser(),
        RestrictSeller.routeName: (ctx) => RestrictSeller(),
        RepairRequest.routeName: (ctx) => RepairRequest(),
        PendingRequest.routeName: (ctx) => PendingRequest(),
        RepairRequestAccept.routeName: (ctx) => RepairRequestAccept(),
        AppointmentUser.routeName: (ctx) => AppointmentUser(),
        OrderRequest.routeName: (ctx) => OrderRequest(),
        MarketPlaceProducts.routeName: (ctx) => MarketPlaceProducts(),
        SellProductUser.routeName: (ctx) => SellProductUser(),
        ProductMarketPlace.routeName: (ctx) => ProductMarketPlace(),
        OrderHistroyUser.routeName: (ctx) => OrderHistroyUser(),
        ShowMessagesUser.routeName: (ctx) => ShowMessagesUser(),
        ShowMessagesSeller.routeName: (ctx) => ShowMessagesSeller(),
        ShowMessagesAdmin.routeName: (ctx) => ShowMessagesAdmin(),
        ShowMessagesDriver.routeName: (ctx) => ShowMessagesDriver(),
        'register': (context) => RegisterPage(),
        'login': (context) => WelcomeBackPage(),
        'register-seller': (context) => RegisterPageOwner(),
        'login-seller': (context) => WelcomeBackPageOwner(),
        'login-driver': (context) => WelcomeBackPageDriver(),
        'login-admin': (context) => AdminLoginPage(),
      },
    );
  }
}
