import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/scr/models/cart_item.dart';
import 'package:delivery_app/scr/models/user.dart';

class UserServices {
  String collection = "users";
  Firestore _firestore = Firestore.instance;

  void createUser(Map<String, dynamic> values) {
    String id = values["id"];
    _firestore.collection(collection).document(id).setData(values);
  }

  void updateUserData(Map<String, dynamic> values) {
    _firestore.collection(collection).document(values['id']).updateData(values);
  }

  Future<UserModel> getUserById(String id) => _firestore
          .collection(collection)
          .document(id.toString())
          .get()
          .then((doc) {
        return UserModel.fromSnapshot(doc);
      });

  Future<List<UserModel>> getUsers() async =>
      _firestore.collection(collection).getDocuments().then((result) {
        List<UserModel> categories = [];
        for (DocumentSnapshot category in result.documents) {
          categories.add(UserModel.fromSnapshot(category));
        }
        return categories;
      });

  void addToCart({String userId, CartItemModel cartItem}) {
    print("THE USER ID IS: $userId");
    print("cart items are: ${cartItem.toString()}");
    _firestore.collection(collection).document(userId).updateData({
      "cart": FieldValue.arrayUnion([cartItem.toMap()])
    });
  }

  void removeFromCart({String userId, CartItemModel cartItem}) {
    print("THE USER ID IS: $userId");
    print("cart items are: ${cartItem.toString()}");
    _firestore.collection(collection).document(userId).updateData({
      "cart": FieldValue.arrayRemove([cartItem.toMap()])
    });
  }
}
