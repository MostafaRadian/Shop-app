class HomeModel {
  bool status = false;
  HomeDataModel data = HomeDataModel();
  HomeModel();

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? false;
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<BannerModel> banners = [];
  List<ProductModel> products = [];
  HomeDataModel();

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach(
      (element) {
        banners.add(BannerModel.fromJson(element));
      },
    );

    json['products'].forEach(
      (element) {
        products.add(ProductModel.fromJson(element));
      },
    );
  }
}

class BannerModel {
  int id = 0;
  String image = '';
  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'] ?? '';
  }
}

class ProductModel {
  int id = 0;
  dynamic price = 0.0;
  dynamic oldPrice = 0.0;
  dynamic discount = 0.0;
  String image = '';
  String name = '';
  bool inFavourite = false;
  bool inCart = false;
  String description = '';

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    price = json['price'] ?? 0.0;
    oldPrice = json['old_price'] ?? 0.0;
    discount = json['discount'] ?? 0.0;
    image = json['image'] ?? '';
    name = json['name'] ?? '';
    inFavourite = json['in_favourites'] ?? false;
    inCart = json['in_cart'] ?? false;
    description = json['description'] ?? '';
  }
}
