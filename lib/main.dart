import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as hook;
import 'package:nimihub_online/models/cartItem.dart';
import 'package:nimihub_online/models/products.dart';
import 'package:nimihub_online/models/order.dart';
import 'package:nimihub_online/models/user_data.dart';
import 'package:nimihub_online/routes.dart';
import 'package:nimihub_online/screens/home/home_screen.dart';
import 'package:nimihub_online/screens/intro_screen/intro_screen.dart';
import 'package:nimihub_online/service/auth_service.dart';
import 'package:nimihub_online/service/database.dart';
import 'package:nimihub_online/theme.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_)=>UserData(),
        ),
        ChangeNotifierProvider.value(
          value: CartMain(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
        ChangeNotifierProvider.value(
          value: Product(),
        ),
        Provider<DatabaseService> (
          create: (_) => DatabaseService(),
        ),
        Provider<AuthService> (
          create: (_) => AuthService(),
        ),

      ],
      child:  MyApp(),
    ),
  );
}





class MyApp extends StatelessWidget
{
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context)
  {

    return hook.ProviderScope(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme(),
        routes:routes,
        home: StreamBuilder<User>(
          stream: Provider.of<AuthService>(context, listen: false).user,
          builder: (BuildContext context, AsyncSnapshot snapshot)
          {
            if(snapshot.connectionState == ConnectionState.waiting)
            {
              Center(
                child: Platform.isIOS ? CupertinoActivityIndicator() : CircularProgressIndicator(),
              );
            }
            if(snapshot.hasData)
            {

              Provider.of<UserData>(context, listen: false).currentUserId
              = snapshot.data.uid;
              return HomeScreen();
            }
            else
            {
              return IntroScreen();
            }

          },

        ),
      ),
    );

  }
}

class SBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

