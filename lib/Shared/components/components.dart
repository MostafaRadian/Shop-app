import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/logic/Cubits/shopping/shopping_cubit.dart';
import 'package:shop_app/logic/models/Categories%20model/categories_model.dart';
import 'package:shop_app/logic/models/favourite%20model/favorite_model.dart';

import '../../Screens/login/login.dart';
import '../../logic/models/Home model/home_model.dart';
import '../constants/constants.dart';
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
  void Function(String value)? submit,
}) =>
    SizedBox(
      width: 400,
      child: TextFormField(
          controller: controller,
          keyboardType: type,
          obscureText: hidden,
          onFieldSubmitted: submit,
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
        style: const TextStyle(fontSize: 13),
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
  CacheHelper.removeData(key: 'token').then((value) {
    token = '';
    pushReplace(context, Login());
  });
}

//Products Screen

Widget productsBuilder(
        HomeModel model, CategoriesModel categoriesModel, context) =>
    SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model.data.banners
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        buildCategoryItem(categoriesModel.data.data[index]),
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 10),
                    itemCount: categoriesModel.data.data.length,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'New Products',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 1 / 1.70,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                model.data.products.length,
                (index) =>
                    buildGridProduct(model.data.products[index], context),
              ),
            ),
          )
        ],
      ),
    );

Widget buildGridProduct(ProductModel productModel, context) => Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(productModel.image),
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
                      onPressed: () {
                        ShoppingCubit.get(context)
                            .changeFavourite(productModel.id);
                      },
                      icon: CircleAvatar(
                        backgroundColor: ShoppingCubit.get(context)
                                        .favourites[productModel.id] !=
                                    null &&
                                ShoppingCubit.get(context)
                                    .favourites[productModel.id]!
                            ? defaultColor
                            : Colors.grey,
                        radius: 15,
                        child: const Icon(
                          Icons.favorite_outline,
                          size: 14,
                        ),
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

Widget buildCategoryItem(DataModel data) => Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(data.image),
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        Container(
            color: Colors.black.withOpacity(0.8),
            width: 100,
            child: Text(
              data.name,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ))
      ],
    );

//Category Screen

Widget categoryBuilder(CategoriesModel categoriesModel) => ListView.separated(
      itemBuilder: (context, index) =>
          buildCategoryScreenItem(categoriesModel.data.data[index]),
      separatorBuilder: (context, index) =>
          const Divider(), //const SizedBox(height: 20),
      itemCount: categoriesModel.data.data.length,
    );

Widget buildCategoryScreenItem(DataModel data) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(data.image),
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            data.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios)
        ],
      ),
    );

//Favorite screen

Widget favoriteBuilder(data, context, {bool isOldPrice = true}) =>
    ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildFavoriteItem(data[index], context),
      separatorBuilder: (context, index) =>
          const Divider(), //const SizedBox(height: 20),
      itemCount: data.length,
    );

Widget buildFavoriteItem(Product data, context, {bool isOldPrice = true}) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 120,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(data.image),
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
                if (data.discount != 0 && isOldPrice)
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
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(height: 1.3),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '${data.price}',
                        style: TextStyle(
                          fontSize: 12,
                          color: defaultColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (data.discount != 0 && isOldPrice)
                        Text(
                          '${data.oldPrice}',
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                          textAlign: TextAlign.center,
                        ),
                      const Spacer(),
                      BlocBuilder<ShoppingCubit, ShoppingState>(
                        builder: (context, state) {
                          return IconButton(
                            onPressed: () {
                              ShoppingCubit.get(context)
                                  .changeFavourite(data.id);
                            },
                            icon: CircleAvatar(
                              backgroundColor: ShoppingCubit.get(context)
                                          .favourites[data.id] ??
                                      false
                                  ? defaultColor
                                  : Colors.grey,
                              radius: 15,
                              child: const Icon(
                                Icons.favorite_outline,
                                size: 14,
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );

// Profile Screen

Widget buildSettings(
  context,
  userData,
  nameController,
  emailController,
  phoneController,
  formKey,
) =>
    BlocBuilder<ShoppingCubit, ShoppingState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(30),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (state is ShopUpdateUserLoadingState)
                    const LinearProgressIndicator(),
                  Center(
                    child: ClipOval(
                      child: Image(
                        image: userData!.image.isEmpty
                            ? const NetworkImage(
                                'https://media.istockphoto.com/id/1300845620/fr/vectoriel/appartement-dic%C3%B4ne-dutilisateur-isol%C3%A9-sur-le-fond-blanc-symbole-utilisateur.jpg?s=612x612&w=0&k=20&c=BVOfS7mmvy2lnfBPghkN__k8OMsg7Nlykpgjn0YOHj0=',
                              )
                            : NetworkImage(
                                userData.image,
                              ),
                        height: 200,
                        width: 200,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  defaultFormField(
                    nameController,
                    TextInputType.text,
                    (value) {
                      if (value!.isEmpty) {
                        return 'Name must not be empty';
                      } else {
                        return null;
                      }
                    },
                    '',
                    defaultColor,
                    const Icon(Icons.person_outline),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                    emailController,
                    TextInputType.emailAddress,
                    (value) {
                      if (value!.isEmpty) {
                        return 'email must not be empty';
                      } else {
                        return null;
                      }
                    },
                    '',
                    defaultColor,
                    const Icon(Icons.mail_outline),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                    phoneController,
                    TextInputType.phone,
                    (value) {
                      if (value!.isEmpty) {
                        return 'phone must not be empty';
                      } else {
                        return null;
                      }
                    },
                    '',
                    defaultColor,
                    const Icon(Icons.phone_outlined),
                  ),
                  const SizedBox(height: 50),
                  defaultButton(
                      function: () async {
                        if (formKey.currentState.validate()) {
                          await ShoppingCubit.get(context).updateProfileData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                        }
                      },
                      color: defaultColor,
                      text: 'Update Profile'),
                  const SizedBox(height: 30),
                  defaultButton(
                    function: () {
                      signOut(context);
                    },
                    color: Colors.grey.shade600,
                    text: 'Log Out',
                  )
                ],
              ),
            ),
          ),
        );
      },
    );

// printFullText(String text) {
//   final pattern = RegExp('.{1,800}');
//   pattern.allMatches(text).forEach((element) => print(element.group(0)));
// }
