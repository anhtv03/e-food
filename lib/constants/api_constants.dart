class RouteConstants {
  static const String baseUrl = 'http://30.30.30.86:7777';

  static String getUrl(String endPoint) {
    return "$baseUrl/api$endPoint";
  }

  static String getImageUrl(String endPoint) {
    return baseUrl + endPoint;
  }
}
