class SearchModel {
  bool status = false;
  Data data = Data();
  SearchModel();

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : Data();
  }
}

class Data {
  Data();
  int currentPage = 0;
  List<Product> data = [];
  String firstPageUrl = '';
  int from = 0;
  int lastPage = 0;
  String lastPageUrl = '';
  Null nextPageUrl;
  String path = '';
  int perPage = 0;
  Null prevPageUrl;
  int to = 0;
  int total = 0;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'] ?? 0;
    firstPageUrl = json['first_page_url'] ?? '';
    from = json['from'] ?? 0;
    lastPage = json['last_page'] ?? 0;
    lastPageUrl = json['last_page_url'] ?? '';
    nextPageUrl = json['next_page_url'];
    path = json['path'] ?? '';
    perPage = json['per_page'] ?? 0;
    prevPageUrl = json['prev_page_url'];
    to = json['to'] ?? 0;
    total = json['total'] ?? 0;

    if (json['data'] != null) {
      data = [];
      json['data'].forEach(
        (element) {
          data.add(Product.fromJson(element));
        },
      );
    }
  }
}

class Product {
  int id = 0;
  dynamic price = 0;
  dynamic oldPrice = 0;
  int discount = 0;
  String image = '';
  String name = '';
  String description = '';

  Product();

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    price = json['price'] ?? 0.0;
    oldPrice = json['old_price'] ?? 0.0;
    discount = json['discount'] ?? 0.0;
    image = json['image'] ?? '';
    name = json['name'] ?? '';
    description = json['description'] ?? '';
  }
}
