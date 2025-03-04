class LoginModel {
  LoginModel({
    String? accessToken,
    String? refreshToken,
    String? id,
    String? name,
    String? email,
    bool? isAdmin,
    String? lastLogin,
  }) {
    _accessToken = accessToken;
    _accessToken = accessToken;
    _id = id;
    _name = name;
    _email = email;
    _isAdmin = isAdmin;
    _lastLogin = lastLogin;
  }

  LoginModel.fromJson(dynamic json) {
    _accessToken = json['accessToken'];
    _refreshToken = json['refreshToken'];
    _id = json['_id'];
    _name = json['name'];
    _email = json['email'];
    _isAdmin = json['isAdmin'];
    _lastLogin = json['lastLogin'];
  }

  String? _accessToken;
  String? _refreshToken;
  String? _id;
  String? _name;
  String? _email;
  bool? _isAdmin;
  String? _lastLogin;

  String? get accessToken => _accessToken;

  String? get refreshToken => _refreshToken;
  String? get id => _id;
  String? get name => _name;
  String? get email => _email;
  bool? get isAdmin => _isAdmin;
  String? get lastLogin => _lastLogin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accessToken'] = _accessToken;
    map['refreshToken'] = _refreshToken;
    map['_id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['isAdmin'] = _isAdmin;
    map['lastLogin'] = _lastLogin;
    return map;
  }
}
