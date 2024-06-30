import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_palmcode/constant/colors.dart';
import 'package:test_palmcode/constant/typography.dart';
import 'package:test_palmcode/controller/home/home_controller.dart';
import 'package:test_palmcode/models/list_book_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailBookPage extends StatelessWidget {
  DetailBookPage({
    required this.dataList,
    required this.onTapFavorite,
    Key? key,
  }) : super(key: key);

  ListBookModel dataList;
  VoidCallback onTapFavorite;

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    return Scaffold(
      backgroundColor: kColorBackground,
      body: SafeArea(
        child: SizedBox(
          height: Get.height,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back_rounded),
                    ),
                    buildImageSection(),
                    buildDetailSection(),
                  ],
                ),
                Positioned(
                  top: Get.height / 2.85,
                  right: 16,
                  child: Obx(
                    () => IconButton(
                      onPressed: onTapFavorite,
                      icon: Icon(
                        Icons.favorite,
                        size: 50,
                        color: controller.isFavorite(dataList) == true
                            ? kColorRed
                            : kColorMainGrey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildImageSection() {
    return Row(
      children: [
        Expanded(
          child: dataList.formats.image != null
              ? Container(
                  height: Get.height / 3,
                  margin: const EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: kColorMainGrey,
                    image: DecorationImage(
                      image: NetworkImage(dataList.formats.image ?? ''),
                      fit: BoxFit.fill,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: kColorBlack.withOpacity(0.25),
                        blurRadius: 4,
                        spreadRadius: 0,
                        offset: const Offset(0, 0),
                      )
                    ],
                  ),
                )
              : Container(
                  height: Get.height / 3,
                  margin: const EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: kColorMainGrey,
                    image: const DecorationImage(
                      image: AssetImage('assets/images/book.png'),
                      fit: BoxFit.fill,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: kColorBlack.withOpacity(0.25),
                        blurRadius: 4,
                        spreadRadius: 0,
                        offset: const Offset(0, 0),
                      )
                    ],
                  ),
                ),
        ),
      ],
    );
  }

  Widget buildDetailSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              dataList.title,
              style: TStyle.title.copyWith(fontSize: 22),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'Author',
            style: TStyle.title.copyWith(fontSize: 17),
          ),
          Text(
            dataList.authors.isNotEmpty ? dataList.authors[0].name : 'Unknown',
            style: TStyle.regText.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 6),
          dataList.bookshelves.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Genre',
                      style: TStyle.title.copyWith(fontSize: 17),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: dataList.bookshelves.map((e) {
                          return Text(
                            '$e, ',
                            style: TStyle.regText.copyWith(fontSize: 16),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
          const SizedBox(height: 6),
          dataList.subjects.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Subjects',
                      style: TStyle.title.copyWith(fontSize: 17),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: dataList.subjects.map((e) {
                        return Text(
                          '$e, ',
                          style: TStyle.regText.copyWith(fontSize: 16),
                        );
                      }).toList(),
                    ),
                  ],
                )
              : const SizedBox(),
          const SizedBox(height: 6),
          buildLinkSection('Download file', [
            {'text': 'download epub', 'url': dataList.formats.epub ?? ''},
            {
              'text': 'download mobipocket',
              'url': dataList.formats.mobipocket ?? ''
            },
          ]),
          const SizedBox(height: 6),
          buildLinkSection('Read book online', [
            {'text': 'online reading', 'url': dataList.formats.html ?? ''},
          ]),
        ],
      ),
    );
  }

  Widget buildLinkSection(String title, List<Map<String, String>> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TStyle.title.copyWith(fontSize: 17),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: links.map((link) {
            return InkWell(
              onTap: () async {
                if (link['url'] != '') {
                  await launchUrl(Uri.parse(link['url']!));
                } else {
                  Get.snackbar(
                    'NO SITES FOUND',
                    'Theres no file / link to download or read',
                    backgroundColor: kColorRed.withOpacity(0.6),
                  );
                }
              },
              borderRadius: BorderRadius.circular(6),
              child: Text(
                link['text']!,
                style: TStyle.regText.copyWith(
                  color: Colors.blue,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
