import 'package:flutter/material.dart';
import 'package:test_palmcode/constant/colors.dart';
import 'package:test_palmcode/constant/typography.dart';

class TabbarWidget extends StatelessWidget {
  const TabbarWidget({
    Key? key,
    required this.text,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);
  final String text;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kColorWhite,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: kColorMainLine),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      style: isActive
                          ? TStyle.title.copyWith(color: kColorOrangeTab)
                          : TStyle.regText.copyWith(color: kColorRegTxtBlack),
                    )
                  ],
                ),
              ),
              // isActive
              //     ? Container(
              //   width: double.infinity,
              //   height: 4,
              //   decoration: BoxDecoration(
              //     color: kColorOrangeTab,
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              // )
              //     : const SizedBox(
              //   height: 4,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
