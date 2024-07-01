import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:test_palmcode/constant/colors.dart';
import 'package:test_palmcode/constant/component.dart';
import 'package:test_palmcode/constant/typography.dart';
import 'package:test_palmcode/controller/home/home_controller.dart';
import 'package:test_palmcode/page/detail/detail_book_page.dart';
import 'package:test_palmcode/page/home/widget/card_list_widget.dart';
import 'package:test_palmcode/page/home/widget/tabbar_widgte.dart';
import 'package:test_palmcode/routes/route_name.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorBackground,
      body: SafeArea(
        child: Column(
          children: [
            searchBar(),
            Expanded(
              child: SmartRefresher(
                enablePullDown: true,
                enablePullUp: controller.enablePullUp.value,
                controller: controller.refreshController,
                onRefresh: () {
                  controller.refreshController.refreshCompleted();
                  controller.getListBooks(reset: true);
                },
                onLoading: () {
                  controller.getListBooks();
                },
                child: SingleChildScrollView(
                  child: Obx(
                    () => controller.menuPage.value == 0
                        ? buildBookList()
                        : builFavoriteList(),
                  ),
                ),
              ),
            ),
            buildTabBar(),
          ],
        ),
      ),
    );
  }

  Widget searchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: kColorWhite,
              boxShadow: [
                BoxShadow(
                  color: kColorBlack.withOpacity(0.25),
                  blurRadius: 4,
                  spreadRadius: 0,
                  offset: const Offset(0, 0),
                )
              ],
            ),
            child: Material(
              color: kColorForm,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {
                  Get.toNamed(RouteName.search);
                },
                borderRadius: BorderRadius.circular(10),
                child: TextField(
                  onChanged: (value) async {},
                  enabled: false,
                  decoration: kDecorationForm.copyWith(
                      filled: false, hintText: 'search', alignLabelWithHint: true),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildBookList() {
    return Obx(
      () => controller.isLoadingGetBooks.value
          ? SizedBox(
              height: Get.height / 2,
              child: const Center(child: CircularProgressIndicator()),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.listBook.length,
                itemBuilder: (context, index) {
                  var data = controller.listBook[index];
                  return CardListWidget(
                    data: data,
                    onTapDetail: () {
                      Get.to(
                        () => DetailBookPage(
                          dataList: data,
                          // boolFavorite: controller.isFavorite(data),
                          onTapFavorite: () {
                            controller.selectFavoriteBook(data);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
    );
  }

  Widget builFavoriteList() {
    return Obx(
      () => controller.listFavoriteBook.isNotEmpty
          ? Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.listFavoriteBook.length,
                    itemBuilder: (context, index) {
                      var dataFavorite = controller.listFavoriteBook[index];
                      return CardListWidget(
                        data: dataFavorite,
                        onTapDetail: () {
                          Get.to(
                            () => DetailBookPage(
                              dataList: dataFavorite,
                              // boolFavorite: controller.isFavorite(dataFavorite),
                              onTapFavorite: () {
                                controller.selectFavoriteBook(dataFavorite);
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            )
          : SizedBox(
              height: Get.height / 2,
              child: Center(
                child: Text(
                  'There are no books that are liked',
                  style: TStyle.regText.copyWith(color: kColorRegTxtGrey),
                ),
              ),
            ),
    );
  }

  Widget buildTabBar() {
    return Obx(
      () => Row(
        children: [
          Expanded(
            child: TabbarWidget(
              onTap: () {
                if (controller.menuPage.value == 0) {
                } else {
                  controller.menuPage.value = 0;
                }
              },
              isActive: controller.menuPage.value == 0,
              text: 'Home',
            ),
          ),
          Expanded(
            child: TabbarWidget(
              onTap: () {
                if (controller.menuPage.value == 1) {
                } else {
                  controller.menuPage.value = 1;
                }
              },
              isActive: controller.menuPage.value == 1,
              text: 'Likes',
            ),
          ),
        ],
      ),
    );
  }
}
