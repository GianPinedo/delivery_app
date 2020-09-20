import 'package:delivery_app/scr/models/user.dart';
import 'package:delivery_app/scr/providers/product.dart';
import 'package:delivery_app/scr/providers/restaurant.dart';
import 'package:delivery_app/scr/screens/cart.dart';
import 'package:delivery_app/scr/screens/map.dart';
import 'package:delivery_app/scr/screens/order.dart';
import 'package:delivery_app/scr/widgets/featured_products.dart';
import 'package:delivery_app/scr/widgets/restaurant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:delivery_app/scr/helpers/screen_navigation.dart';
import 'package:delivery_app/scr/helpers/style.dart';
import 'package:delivery_app/scr/providers/category.dart';
import 'package:delivery_app/scr/providers/app.dart';
import 'package:delivery_app/scr/providers/user.dart';
import 'package:delivery_app/scr/screens/login.dart';
import 'package:delivery_app/scr/widgets/custom_text.dart';
import 'package:delivery_app/scr/widgets/categories.dart';
import 'package:delivery_app/scr/widgets/loading.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final user = Provider.of<UserProvider>(context);
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final app = Provider.of<AppProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: white),
        elevation: 0.5,
        backgroundColor: primary,
        title: CustomText(
          text: "Delivery app",
          color: white,
          size: 18,
          weight: FontWeight.w500,
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 9.0, vertical: 9.0),
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    changeScreen(context, CartScreen());
                  },
                ),
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    Container(
                      child: app.isLoading
                          ? Loading()
                          : user.userModel.cart.length > 0
                              ? Container(
                                  width: 18.0,
                                  height: 18.0,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.red,
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0.0, vertical: 0.0),
                                ),
                    ),
                    Container(
                      child: app.isLoading
                          ? Loading()
                          : user.userModel.cart.length > 0
                              ? Text(
                                  user.userModel.cart.length.toString(),
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0.0, vertical: 0.0),
                                ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: primary),
              accountName: CustomText(
                text: user.userModel?.name ?? "username lading...",
                color: white,
                weight: FontWeight.bold,
                size: 18,
              ),
              accountEmail: CustomText(
                text: user.userModel?.email ?? "email loading...",
                color: white,
              ),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, Home());
              },
              leading: Icon(Icons.home),
              title: CustomText(text: "Inicio"),
            ),
            ListTile(
              onTap: () async {
                await user.getOrders();
                changeScreen(context, OrdersScreen());
              },
              leading: Icon(Icons.bookmark_border),
              title: CustomText(text: "Mis pedidos"),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, CartScreen());
              },
              leading: Icon(Icons.shopping_cart),
              title: CustomText(text: "Carrito"),
            ),
            ListTile(
              onTap: () {
                user.signOut();
                changeScreenReplacement(context, LoginScreen());
              },
              leading: Icon(Icons.exit_to_app),
              title: CustomText(text: "Cerrar sesión"),
            ),
            ListTile(
              onTap: () {
                //user.signOut();
                changeScreenReplacement(context, MapSample());
              },
              leading: Icon(Icons.map),
              title: CustomText(text: "Mapa"),
            ),
          ],
        ),
      ),
      backgroundColor: white,
      body: app.isLoading
          ? Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Loading()],
              ),
            )
          : SafeArea(
              child: ListView(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8, left: 8, right: 8, bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.search,
                            color: red,
                          ),
                          title: TextField(
                            textInputAction: TextInputAction.search,
                            decoration: InputDecoration(
                              hintText: "Buscar comida o restaurante",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CustomText(
                        text: "Buscar por:",
                        color: grey,
                        weight: FontWeight.w300,
                      ),
                      DropdownButton<String>(
                        //value: app.filterBy,
                        style: TextStyle(
                            color: primary, fontWeight: FontWeight.w300),
                        icon: Icon(
                          Icons.filter_list,
                          color: primary,
                        ),
                        elevation: 0,
                        onChanged: (value) {
                          if (value == "Productos") {
                            //app.changeSearchBy(newSearchBy: SearchBy.PRODUCTS);
                          } else {
                            //app.changeSearchBy(
                            //  newSearchBy: SearchBy.RESTAURANTS);
                          }
                        },
                        items: <String>["Products", "Restaurants"]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                              value: value, child: Text(value));
                        }).toList(),
                      ),
                    ],
                  ),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 120,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryProvider.categories.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            child: CategoryWidget(
                              category: categoryProvider.categories[index],
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CustomText(
                          text: "Destacado",
                          size: 20,
                          color: grey,
                        ),
                      ],
                    ),
                  ),
                  Featured(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CustomText(
                          text: "Restaurantes",
                          size: 20,
                          color: grey,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: restaurantProvider.restaurants
                        .map((item) => GestureDetector(
                              child: RestaurantWidget(
                                restaurant: item,
                              ),
                            ))
                        .toList(),
                  )
                ],
              ),
            ),
    );
  }
}
