class LoginModel {
  LoginModel({
      String? token, 
      String? id, 
      String? name, 
      String? email, 
      bool? isAdmin, 
      String? lastLogin,}){
    _token = token;
    _id = id;
    _name = name;
    _email = email;
    _isAdmin = isAdmin;
    _lastLogin = lastLogin;
}

  LoginModel.fromJson(dynamic json) {
    _token = json['token'];
    _id = json['_id'];
    _name = json['name'];
    _email = json['email'];
    _isAdmin = json['isAdmin'];
    _lastLogin = json['lastLogin'];
  }
  String? _token;
  String? _id;
  String? _name;
  String? _email;
  bool? _isAdmin;
  String? _lastLogin;

  String? get token => _token;
  String? get id => _id;
  String? get name => _name;
  String? get email => _email;
  bool? get isAdmin => _isAdmin;
  String? get lastLogin => _lastLogin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = _token;
    map['_id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['isAdmin'] = _isAdmin;
    map['lastLogin'] = _lastLogin;
    return map;
  }

}