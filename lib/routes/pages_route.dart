import 'package:get/get.dart';
import 'package:test_palmcode/page/search/search_page.dart';
import 'package:test_palmcode/routes/route_name.dart';

class PagesRoute {
  static final pages = [
    GetPage(name: RouteName.search, page: ()=> SearchPage()),
  ];
}