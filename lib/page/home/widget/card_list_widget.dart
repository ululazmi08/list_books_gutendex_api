import 'package:flutter/material.dart';
import 'package:test_palmcode/constant/colors.dart';
import 'package:test_palmcode/constant/typography.dart';
import 'package:test_palmcode/models/list_book_model.dart';

class CardListWidget extends StatelessWidget {
  CardListWidget({
    required this.data,
    required this.onTapDetail,
    Key? key,
  }) : super(key: key);

  ListBookModel data;
  VoidCallback onTapDetail;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: kColorMainLine,
            ),
            color: kColorWhite,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTapDetail,
              borderRadius: BorderRadius.circular(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 16,
                      bottom: 8,
                    ),
                    child: Center(
                      child: Text(
                        data.title,
                        textAlign: TextAlign.center,
                        style: TStyle.title,
                      ),
                    ),
                  ),
                  const Divider(
                    color: kColorMainLine,
                    thickness: 1,
                    height: 0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 8,
                      bottom: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Author', style: TStyle.regText),
                        Text(
                          data.authors.isNotEmpty
                              ? data.authors[0].name
                              : 'Unknown',
                          style:
                              TStyle.regText.copyWith(color: kColorRegTxtGrey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
