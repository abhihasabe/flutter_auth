class AppNetworkConstants {
  AppNetworkConstants._();

  static const baseURL = "http://mindtechsolutions.com/tester/MindcubeDiamondAPI_Test/api/Authentication";
  static const mobileAuthenticationURL = '$baseURL/MobileAuthentication';
  static const checkValidateOTPURL = '$baseURL/CheckValidateOTP';

  //Methods
  static const get = 'get';
  static const post = 'post';
  static const put = 'put';
  static const delete = 'delete';
  static const image = 'image';
}
