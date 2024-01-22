import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Screens/login/login.dart';
import '../../logic/models/Home model/home_model.dart';
import '../services/local/cache_helper.dart';
import '../styles/themes.dart';

String getWarningMessage() {
  return "Incorrect email format";
}

void navigateTo(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void pushReplace(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

Widget defaultButton({
  var function = print,
  Color color = Colors.indigoAccent,
  double width = 150,
  String text = "Sign in",
}) =>
    Container(
      width: width,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );

// ignore: non_constant_identifier_names
Widget defaultFormField(
  TextEditingController controller,
  TextInputType type,
  String? Function(String? value) validate,
  String label,
  Color color,
  Icon prefixIcon, {
  bool hidden = false,
  Function()? function,
  IconData? suffixIcon,
}) =>
    SizedBox(
      width: 300,
      child: TextFormField(
          controller: controller,
          keyboardType: type,
          obscureText: hidden,
          decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
              prefixIcon: prefixIcon,
              prefixIconColor: color,
              suffixIcon: IconButton(
                  onPressed: function, icon: Icon(suffixIcon ?? suffixIcon)),
              suffixIconColor: color),
          validator: validate),
    );

Widget defaultTextButton({
  required String text,
  required void Function()? function,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text,
        style: const TextStyle(fontSize: 15),
        textAlign: TextAlign.center,
      ),
    );

void showToast({required String message, required ToastStates state}) =>
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 3,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ToastStates { success, error, warning }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.orange;
      break;
  }
  return color;
}

void signOut(context) {
  TextButton(
    onPressed: () {
      CacheHelper.removeData(key: 'token').then(
        (value) => pushReplace(context, Login()),
      );
    },
    child: const Text("Log out"),
  );
}

Widget productsBuilder(HomeModel? model) => SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          CarouselSlider(
            items: model?.data?.banners
                .map(
                  (e) => Image(
                    image: NetworkImage(e.image),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: 250,
              initialPage: 0,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 1 / 1.58,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                model?.data?.products.length ?? 0,
                (index) => buildGridProduct(model?.data!.products[index]),
              ),
            ),
          )
        ],
      ),
    );

Widget buildGridProduct(ProductModel? productModel) => Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(productModel!.image),
                width: double.infinity,
                height: 200,
              ),
              if (productModel.discount != 0)
                Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: const Text(
                    'Discount',
                    style: TextStyle(color: Colors.white, fontSize: 8),
                  ),
                )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productModel.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(height: 1.3),
                ),
                Row(
                  children: [
                    Text(
                      '${productModel.price.round()}',
                      style: TextStyle(
                        fontSize: 12,
                        color: defaultColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (productModel.discount != 0)
                      Text(
                        '${productModel.oldPrice.round()}',
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                        textAlign: TextAlign.center,
                      ),
                    const Spacer(),
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite_outline,
                        size: 14,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((element) => print(element.group(0)));
}
