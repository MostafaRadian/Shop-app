class SimpleFavoriteModel {
  bool status = false;
  String message = '';
  SimpleFavoriteModel();
  SimpleFavoriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
