import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_palmcode/models/list_book_model.dart';
import 'package:test_palmcode/services/book_services.dart';

class HomeController extends GetxController {
  var isLoadingGetBooks = true.obs;
  var listBook = <ListBookModel>[].obs;
  var page = 1.obs;
  var menuPage = 0.obs;
  var listFavoriteBook = <ListBookModel>[].obs;
  var enablePullUp = true.obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getListBooks(reset: true);
    loadFavoriteBooks();
  }

  void loadFavoriteBooks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? selectedUsersString = prefs.getStringList('selectedUsers');
    if (selectedUsersString != null) {
      listFavoriteBook.value = selectedUsersString
          .map((user) => ListBookModel.fromJson(jsonDecode(user)))
          .toList();
    }
  }

  void saveFavoriteBooks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> selectedUsersString =
        listFavoriteBook.map((user) => jsonEncode(user.toJson())).toList();
    await prefs.setStringList('selectedUsers', selectedUsersString);
  }

  void selectFavoriteBook(ListBookModel book) {
    if (listFavoriteBook.contains(book)) {
      listFavoriteBook.remove(book);
    } else {
      listFavoriteBook.add(book);
    }
    saveFavoriteBooks();
  }

  bool isFavorite(ListBookModel book) {
    return listFavoriteBook.contains(book);
  }

  void getListBooks({bool reset = false}) async {
    if (reset) {
      page.value = 1;
      listBook.clear();
      enablePullUp.value = true;
    }
    if (page.value == 1) {
      isLoadingGetBooks.value = true;
    }
    try {
      var data = await BookServices.dataListBooks(page.value);
      if (data != null) {
        page.value += 1;
        var dataList = data['results'] as List;
        List<ListBookModel> list =
            dataList.map((e) => ListBookModel.fromJson(e)).toList();
        listBook.addAll(list);
        refreshController.loadComplete();
      } else {
        enablePullUp.value = false;
      }
    } catch (e) {
      print('error getListBooks : $e');
    } finally {
      isLoadingGetBooks.value = false;
    }
  }
}
