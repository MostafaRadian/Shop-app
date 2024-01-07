class LoginModel {
  late bool status;
  late String message;
  late UserData? data;
  LoginModel.fromJason(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJason(data: json['data']) : null;
  }
}

class UserData {
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late String token;
  int? points;
  int? credit;
  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.token,
    this.credit,
    this.points,
  });

  UserData.fromJason({required Map<String, dynamic> data}) {
    id = data['id'] ?? 0;
    name = data['name'] ?? '';
    email = data['email'] ?? '';
    phone = data['phone'] ?? '';
    image = data['image'] ?? '';
    token = data['token'] ?? '';
    credit = data['credit'] ?? 0;
    points = data['points'] ?? 0;
  }
}
