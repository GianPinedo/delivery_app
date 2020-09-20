import 'package:delivery_app/scr/helpers/style.dart';
import 'package:delivery_app/scr/providers/DirectionsProvider.dart';
import 'package:delivery_app/scr/providers/app.dart';
import 'package:delivery_app/scr/providers/category.dart';
import 'package:delivery_app/scr/providers/product.dart';
import 'package:delivery_app/scr/providers/restaurant.dart';
import 'package:delivery_app/scr/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/scr/providers/user.dart';
import 'package:delivery_app/scr/screens/home.dart';
import 'package:delivery_app/scr/screens/login.dart';
import 'package:delivery_app/scr/screens/splash.dart';

import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppProvider()),
        ChangeNotifierProvider.value(value: UserProvider.initialize()),
        ChangeNotifierProvider.value(value: CategoryProvider.initialize()),
        ChangeNotifierProvider.value(value: RestaurantProvider.initialize()),
        ChangeNotifierProvider.value(value: ProductProvider.initialize()),
        ChangeNotifierProvider.value(value: DirectionProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'delivery app',
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          home: ScreensController())));
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);
    switch (auth.status) {
      case Status.Uninitialized:
        return Splash();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return LoginScreen();
      case Status.Authenticated:
        return Home();
      default:
        return LoginScreen();
    }
  }
}
