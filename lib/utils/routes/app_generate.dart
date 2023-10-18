import 'package:humble_warrior/view/wish_list/wish_list_binding.dart';

import '../../hw.dart';

class AppGenerate {
  static generateRoutes(RouteSettings settings) {
    String? name = settings.name;
    Map<String, GetPageRoute> routes = {
      AppRoutes.introScreen: GetPageRoute(
          settings: settings,
          page: () => const IntroScreen(),
          binding: IntroBinding()),
      AppRoutes.webView: GetPageRoute(
          settings: settings,
          page: () => CommonWebView(url: 'https://www.amazon.com/shop/influencer-1604f2b0'),
          binding: IntroBinding()),
      AppRoutes.homePage: GetPageRoute(
        settings: settings,
        page: () => const HomeScreen(),
      ),
      AppRoutes.loginPage: GetPageRoute(
          settings: settings,
          page: () => const LoginScreen(),
          binding: LoginBinding()),
      AppRoutes.wishList: GetPageRoute(
          settings: settings,
          page: () {
            return const WishList();
          },
          binding: WishListBindings()),
      AppRoutes.bottomNavigation: GetPageRoute(
          settings: settings,
          page: () => const BottomNavigationScreen(),
          binding: BottomNavigationBindings()),
      AppRoutes.homeOptions: GetPageRoute(
          settings: settings,
          page: () {
            final args = settings.arguments;
            if (args is Map<String, dynamic>) {
              return HomeOptionScreen(
                data: args['id'] ?? 0, tabTitles: args['titles'] as List<String>,
              );
            } else {
              return HomeOptionScreen(
                data: 0,
                tabTitles: const ['Donna\'s Daily Deals','Donna\'s Favorite Things','Shop My Amazon Store'],
              );
            }
          },
          binding: HomeOptionBindings(settings: settings)),
      AppRoutes.dailyDealProductDetail: GetPageRoute(
          settings: settings,
          page: () {
      final args = settings.arguments;
      if (args is Map<String, ProductDetailsResponse?>) {
        return DailyDealProduct(details : args['details']);
      }else{
        return HomeScreen();
      }
          },
          binding: DailyDealProductBinding()),
      // AppRoutes.frontPageProductDetail: GetPageRoute(
      //     settings: settings,
      //     page: () {
      //       return FrontPageDetailScreen();
      //     },
      //     binding: FrontPageDetailBinding()),
      // AppRoutes.favouriteDeal: GetPageRoute(
      //     settings: settings,
      //     page: () {
      //       return const FavouriteDeals();
      //     },
      //     binding: FavouriteDealsBinding()),
      AppRoutes.aboutDonna: GetPageRoute(
          settings: settings,
          page: () {
            return const AboutScreen();
          },
          binding: AboutBinding()),
     /* AppRoutes.wishList: GetPageRoute(
          settings: settings,
          page: () {
            return const WishList();
          },
          binding: WishListBindings()),*/
      AppRoutes.splashScreen: GetPageRoute(
          settings: settings,
          page: () => const SplashScreen(),
          binding: SplashBinding()),
      AppRoutes.myAccount: GetPageRoute(
          settings: settings,
          page: () => const MyAccount(),
          binding: MyAccountBindings()),
      AppRoutes.notification: GetPageRoute(
          settings: settings,
          page: () {
            return const NotificationScreen();
          },
          binding: NotificationBindings()),
      AppRoutes.brands: GetPageRoute(
          settings: settings,
          page: () {
            return const BrandsScreen();
          },
          binding: BrandsBinding()),
      AppRoutes.categoryDetailsList: GetPageRoute(
          settings: settings,
          page: () {
            final args = settings.arguments;
            if(args is Map<String,ProductCategoryItem?>) {
              return  CategoryListDetails(item : args["record"]);
            }else{
              return HomeScreen();
            }
          },
          binding: CategoryDetailsListBinding()),
      AppRoutes.categoryItemDetail: GetPageRoute(
          settings: settings,
          page: () {
            final args = settings.arguments;
            if (args is Map<String, dynamic>) {
              return CategoryItemDetail(route: args['route'],details: args['details']);
            } else {
              return HomeScreen();
            }
          },
          binding: CategoryItemDetailBinding()),
      AppRoutes.accountDetails: GetPageRoute(
          settings: settings,
          page: () {
            return const AccountDetails();
          },
          binding: AccountDetailsBindings()),
      AppRoutes.staticPages: GetPageRoute(
          settings: settings,
          page: () {
            return StaticPagesScreen();
          },
          binding: StaticPagesBindings()),
      AppRoutes.sortPages: GetPageRoute(
          settings: settings,
          page: () {
            return const Sort();
          },
          binding: SortBindings()),
      AppRoutes.searchView: GetPageRoute(
          settings: settings,
          page: () {
            final args =  settings.arguments;
            if(args is Map<String, dynamic>) {

              String postType = args["postType"];
               String catId = args["itemId"];
              String name = args["catName"];
              String image = args["catImage"];
                      int route = args["route"];
              return  SearchView(postType: postType, catId: catId, name: name, image: image, route: route,);
            }
            return HomeScreen();
          },
          binding: SearchViewBindings()),
      AppRoutes.filterView: GetPageRoute(
        settings: settings,
        page: () {

         final  args = settings.arguments;
         if(args is Map<String, int?>){

          return FilterScreen(route: args["route"]);}else{
           return HomeScreen();
         }
        },
      )
    };

    return routes[name];
  }
}
