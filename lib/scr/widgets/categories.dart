import 'package:flutter/material.dart';
import 'package:delivery_app/scr/models/category.dart';
import 'package:delivery_app/scr/widgets/loading.dart';
import 'package:transparent_image/transparent_image.dart';

import '../helpers/style.dart';
import 'custom_text.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryModel category;

  const CategoryWidget({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
      child: Column(
          //padding: const EdgeInsets.all(6),
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: <Widget>[
                Container(
                  //color: Colors.white,

                  height: 75.0,
                  width: 75.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(110.0),
                    border: Border.all(
                      color: second,
                      width: 2.0,
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.0, vertical: 3.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Image.network(
                        category.image,
                        fit: BoxFit.contain,
                        width: 50.0,
                        height: 50.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              category.name,
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w300,
              ),
            ),
          ]),
    );
  }
}
