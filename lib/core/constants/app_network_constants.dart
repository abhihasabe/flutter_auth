class AppNetworkConstants {
  AppNetworkConstants._();

  static const baseURL = "http://13.235.190.137/mahalaxmi/public/api";
  static const loginURL = '$baseURL/login';
  static const fuelInURL = '$baseURL/fuelin';
  static const fuelQrURL = '$baseURL/fuel/qr';
  static const fuelOutURL = '$baseURL/fuelout';
  static const dailyQrURL = '$baseURL/daily/qr';
  static const tripQrURL = '$baseURL/trip/qr';
  static const projectURL = '$baseURL/projects';
  static const dailyStartURL = '$baseURL/daily/start';
  static const dailyStopURL = '$baseURL/daily/stop';
  static const tripInURL = '$baseURL/trip/in';
  static const tripOutURL = '$baseURL/trip/out';
  static const driverURL = '$baseURL/drivers';
  static const storesURL = '$baseURL/stores';

  //Methods
  static const get = 'get';
  static const post = 'post';
  static const put = 'put';
  static const delete = 'delete';
  static const image = 'image';
}
