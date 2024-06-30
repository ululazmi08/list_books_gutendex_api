import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:test_palmcode/constant/colors.dart';
import 'package:test_palmcode/constant/component.dart';
import 'package:test_palmcode/constant/typography.dart';
import 'package:test_palmcode/controller/home/home_controller.dart';
import 'package:test_palmcode/controller/search/search_controller.dart';
import 'package:test_palmcode/page/detail/detail_book_page.dart';
import 'package:test_palmcode/page/home/widget/card_list_widget.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  SearchPageController controller = Get.put(SearchPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorBackground,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: Get.width,
              padding: const EdgeInsets.only(top: 18, bottom: 18, right: 18),
              decoration: BoxDecoration(
                color: kColorWhite,
                boxShadow: [
                  BoxShadow(
                    color: kColorBlack.withOpacity(0.25),
                    blurRadius: 4,
                    spreadRadius: 0,
                    offset: Offset(0, 0),
                  )
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.arrow_back_rounded),
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: (value) => controller.onSearchChanged(value),
                      controller: controller.searchController.value,
                      decoration: kDecorationForm.copyWith(
                          hintText: 'search', alignLabelWithHint: true),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SmartRefresher(
                enablePullDown: true,
                enablePullUp: controller.enablePullUp.value,
                controller: controller.refreshController,
                onRefresh: () {
                  controller.refreshController.refreshCompleted();
                  controller.searchListBooks(query: controller.searchController.value.text, reset: true);
                },
                onLoading: () {
                  controller.searchListBooks(query: controller.searchController.value.text);
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(
                        () => controller.isLoadingSearch.value
                            ? const Center(child: CircularProgressIndicator())
                            : controller.listBookSearch.isNotEmpty
                                ? Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: controller.listBookSearch.length,
                                      itemBuilder: (context, index) {
                                        var dataSearch =
                                            controller.listBookSearch[index];
                                        return CardListWidget(
                                            data: dataSearch,
                                            onTapDetail: () {
                                              Get.to(
                                                () => DetailBookPage(
                                                  dataList: dataSearch,
                                                  onTapFavorite: () {
                                                    HomeController homeCtrl =
                                                        Get.put(HomeController());
                                                    homeCtrl.selectFavoriteBook(
                                                        dataSearch);
                                                  },
                                                ),
                                              );
                                            });
                                      },
                                    ),
                                )
                                : SizedBox(
                                    height: Get.height / 2,
                                    child: Center(
                                      child: Text(
                                        'There are no books',
                                        style: TStyle.regText
                                            .copyWith(color: kColorRegTxtGrey),
                                      ),
                                    ),
                                  ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
