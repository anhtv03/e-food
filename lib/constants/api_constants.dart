class RouteConstants {
  static const String baseUrl = 'http://10.2.44.84:7777';

  static String getUrl(String endPoint) {
    return "$baseUrl/api$endPoint";
  }

  static String getImageUrl(String endPoint) {
    return baseUrl + endPoint;
  }
}
