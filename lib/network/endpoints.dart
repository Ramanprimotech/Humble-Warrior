class Endpoints {
  //Base Urls Endpoints
  static const String baseUrl = "http://112.196.54.37/Development/HW";
  static const String generateToken = "/wp-json/jwt-auth/v1/token/";
  static const String verifyToken = "/wp-json/jwt-auth/v1/token/validate";
  static const String donnaDeals = "/wp-json/hwapi/get_donna_daily_deals";
  static const String frontPage = "/wp-json/hwapi/get_front_page_deals";
  static const String donnaFavourite = "/wp-json/hwapi/get_favourite_things";
  static const String allBrands = "/wp-json/hwapi/get_all_brands";
  static const String productCategories =
      "/wp-json/hwapi/get_all_product_categories";
  static const String productCategoriesItemList =
      "/wp-json/hwapi/get_all_products_by_category";
  static const String homeCategories = "/wp-json/hwapi/get_all_home_categories";
  static const String staticPages = "/wp-json/hwapi/get_page_content";
  static const String productDetails = "/wp-json/hwapi/get_product_detail";
  static const String registerUser = "/pnfw/register";
  static const String notificationStatus = "/pnfw/posts";
  static const String notificationList = "/pnfw/posts";
  static const String deleteNotificationList = "/wp-json/hwapi/clear_all_notifications";
  static const String search = "/wp-json/wp/v2/search";

  static String token = "";
  static String pdf = "https://humblewarrior.com/wp-content/uploads/2020/09/humble-warrior-media.pdf";
}
