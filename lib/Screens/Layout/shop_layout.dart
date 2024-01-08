import 'package:flutter/material.dart';
import 'package:shop_app/Shared/components/components.dart';
import 'package:shop_app/Shared/services/local/cache_helper.dart';

import '../login/login.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Salla"),
      ),
      body: TextButton(
        onPressed: () {
          CacheHelper.removeData(key: 'token').then(
            (value) => pushReplace(context, Login()),
          );
        },
        child: const Text("Log out"),
      ),
    );
  }
}
