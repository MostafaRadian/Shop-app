class UserModel {
  bool status = false;
  String message = '';
  UserData data = UserData();

  UserModel();
  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? false;
    message = json['message'] ?? '';
    data = json['data'] != null
        ? UserData.fromJson(data: json['data'])
        : UserData();
  }
}

class UserData {
  int id = 0;
  String name = '';
  String email = '';
  String phone = '';
  String image = '';
  String token = '';
  int points = 0;
  int credit = 0;

  UserData();

  UserData.fromJson({required Map<String, dynamic> data}) {
    id = data['id'] ?? 0;
    name = data['name'] ?? '';
    email = data['email'] ?? '';
    phone = data['phone'] ?? '';
    if (data['image'] ==
        'https://student.valuxapps.com/storage/uploads/users/fEnNgRcltP_1703841665.jpeg') {
      image = '';
    } else {
      image = data['image'];
    }
    token = data['token'] ?? '';
    credit = data['credit'] ?? 0;
    points = data['points'] ?? 0;
  }
}
