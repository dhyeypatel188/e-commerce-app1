import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shoping/consts/consts.dart';
import 'package:shoping/models/cetegory_models.dart';

class Productcontroller extends GetxController {
  var subcat = [];
  var quentity = 0.obs;
  var colorIndex = 0.obs;
  var totalprice = 0.obs;

  var isFav = false.obs;

  getSubcategories(title) async {
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = cetegorymodelFromJson(data);
    var s =
        decoded.categories.where((element) => element.name == title).toList();

    for (var e in s[0].subcategory) {
      subcat.add(e);
    }
  }

  changeColorIndex(index) {
    colorIndex = index;
  }

  increaseQuentity(totleQuentity) {
    if (quentity.value < totleQuentity) {
      quentity.value++;
    }
  }

  decreaseQuentity() {
    if (quentity.value > 0) {
      quentity.value--;
    }
  }

  calculateTotlePrice(price) {
    totalprice.value = price * quentity.value;
  }

  addToCart(
      {title, img, sellername, color, qty, tprice, context, venderId}) async {
    await firestore.collection(cartCollection).doc().set({
      'title': title,
      'img': img,
      'sellername': sellername,
      'color': color,
      'qty': qty,
      'vendor_id': venderId,
      'tprice': tprice,
      'added_by': currentUser!.uid
    }).catchError((error) {
      VxToast.show(context, msg: error.toString());
    });
  }

  resetValues() {
    totalprice.value = 0;
    quentity.value = 0;
    colorIndex.value = 0;
  }

  addToWishList(docId, context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));

    isFav(true);
    VxToast.show(context, msg: "Add to Wishlst");
  }

  removeFromWishList(docId, context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(false);
    VxToast.show(context, msg: "Remove from Wishlst");
  }

  checkIfFav(data) async {
    if (data['p_wishlist'].contains(currentUser!.uid)) {
      isFav(true);
    } else {
      isFav(false);
    }
  }
}
