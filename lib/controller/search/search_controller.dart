import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:test_palmcode/models/list_book_model.dart';
import 'package:test_palmcode/services/book_services.dart';

class SearchPageController extends GetxController {
  var listBookSearch = <ListBookModel>[].obs;
  var isLoadingSearch = false .obs;
  var searchController = TextEditingController().obs;
  Timer? _timer;

  var enablePullUp = true.obs;
  var page = 1.obs;
  RefreshController refreshController = RefreshController(initialRefresh: false);


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    searchController.value.dispose();
    super.onClose();
  }


  void onSearchChanged(String value) {
    if (_timer?.isActive ?? false) _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 500), () {
      searchListBooks(query: value, reset: true);
    });
  }

  void searchListBooks({String query = '', bool reset = false}) async {
    if (reset) {
      page.value = 1;
      listBookSearch.clear();
      enablePullUp.value = true;
    }
    if (page.value == 1) {
      isLoadingSearch.value = true;
    }
    // listBookSearch.clear();
    try {
      String encodedQuery = Uri.encodeComponent(query);
      var data = await BookServices.searchListBooks(page.value, encodedQuery);
      if (data != null) {
        if(data.containsKey('detail')){
          print('Error response: ${data['detail']}');
          refreshController.loadNoData(); // Or any other appropriate action
          enablePullUp.value = false;
        }
        page.value += 1;
        var dataList = data['results'] as List;
        List<ListBookModel> list =
        dataList.map((e) => ListBookModel.fromJson(e)).toList();
        listBookSearch.addAll(list);
        refreshController.loadComplete();
      } else {
        enablePullUp.value = false;
      }
    } catch (e) {
      print('error searchListBooks : $e');
    } finally {
      isLoadingSearch.value = false;
    }
  }

}