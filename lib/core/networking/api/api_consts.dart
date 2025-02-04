class ApiConsts {
  //Base URL
  static const String apiBaseUrl = "http://192.168.110.1:3000/api/";
  static const String sockecIOUrl = "http://192.168.110.1:3000";
  // static const String apiBaseUrl = "https://ssc-grad.up.railway.app/api/";
  // static const String sockecIOUrl = "https://ssc-grad.up.railway.app";

  //Authentication
  static const String auth = "auth";
  static const String signUp = "signup";
  static const String verifyEmail = "verifyEmail";
  static const String passwordRecovery = "password-recovery";
  static const String resetPassword = "reset-password/";

  //Cart
  static const String cart = "cart/";
  static const String products = "products";
  static const String addUserToCart = "addUser";
  static const String removeUserFromCart = "removeUser";
  static const String deleteProductFromCart = "deleteproduct";
}

class ApiKeys {
  static const String message = "message";
  static const String cartUpdated = "cartUpdated";
  static const String results = "results";
  static const String userID = "userID";
  static const String productID = "productID";
}
