class ApiConsts {
  //Base URL
  static const String apiBaseUrl = "http://192.168.1.10:3000/api/";
  static const String sockecIOUrl = "http://192.168.1.10:3000";
  // static const String apiBaseUrl = "https://ssc-grad.up.railway.app/api/";
  // static const String sockecIOUrl = "https://ssc-grad.up.railway.app";

  //Authentication
  static const String auth = "auth/";
  static const String signUp = "signup";
  static const String verifyEmail = "verifyEmail";
  static const String login = "login";
  static const String logout = "logout";
  static const String refreshToken = "refresh-token";
  static const String passwordRecovery = "password-recovery";
  static const String resetPassword = "reset-password/";

  //Cart
  static const String cart = "cart/";
  static const String products = "products";
  static const String addUserToCart = "addUser";
  static const String removeUserFromCart = "removeUser";
  static const String deleteProductFromCart = "deleteproduct";

  //User
  static const String user = "user/";
  static const String categories = "categories";

  //Stripe
  static const String stripeUrl = "https://api.stripe.com/v1/payment_intents";
  static const String stripeToken =
      "sk_test_51QmhlE2LYZqbIr0bJGl3cR4FMfGwvNDFeH4nJvZ5t4m9WVWys9C44mOducYYOGhvd6IZ1GlqGdqKpHWzIjJfgLZi00bBGLAsRP";
}

class ApiKeys {
  static const String name = "name";
  static const String email = "email";
  static const String password = "password";
  static const String gender = "gender";
  static const String birthdate = "birthDate";
  static const String message = "message";
  static const String cartUpdated = "cartUpdated";
  static const String results = "results";
  static const String data = "data";
  static const String userID = "userID";
  static const String productID = "productID";
  static const String code = "code";
}
