class CategoriesModel {
  bool status = false;
  CategoriesDataModel data = CategoriesDataModel();

  CategoriesModel();
  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoriesDataModel.fromJson(json['data']);
  }
}

class CategoriesDataModel {
  int currentPage = 1;
  List<DataModel> data = [];
  CategoriesDataModel();

  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'] ?? 1;

    json['data'].forEach(
      (element) => data.add(DataModel.fromJson(element)),
    );
  }
}

class DataModel {
  int id = 0;
  String name = '';
  String image = '';

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 1;
    name = json['name'] ?? '';
    image = json['image'] ?? '';
  }
}
