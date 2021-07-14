import 'package:flutter/cupertino.dart';
import 'package:geeklibrary/constants/numers/nums.dart';
import 'package:geeklibrary/core/dialog/dialogs.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/models/page/page.dart';
import 'package:geeklibrary/models/page/pagination.dart';
import 'package:string_validator/string_validator.dart';

class PaginationStrip extends ConsumerWidget {
  PaginationStrip(
    this.info, {
    Key? key,
    required this.page,
    required this.pageination,
    required this.prevOnTap,
    required this.nextOnTap,
    required this.goOnTap,
  }) : super(key: key);

  final PageInfo page;
  final SizingInformation info;
  final Pageination pageination;
  final Function prevOnTap;
  final Function goOnTap;
  final Function nextOnTap;
  final FocusNode _focus = FocusNode();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var theme = watch(themeProvider);
    return Container(
      height: R.h(info, 10),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
      ),
      margin: const EdgeInsets.only(bottom: pad),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          pageination.hasPrev!
              ? Container(
                  margin: const EdgeInsets.symmetric(horizontal: pad),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(pad),
                        child: KText(
                          "previous",
                          size: R.f(info, 12),
                          weight: FontWeight.bold,
                        ),
                      ),
                      KClickable(
                        height: R.h(info, 5),
                        width: R.w(info, 16),
                        onPressed: () {
                          prevOnTap();
                        },
                        child: Icon(
                          EvaIcons.arrowLeft,
                          color: Colors.black,
                        ),
                        topDeco: G.green2GradBannerDeco,
                        bottomDeco: G.blackGradButtonDeco,
                      ),
                    ],
                  ),
                )
              : Container(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: pad),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(pad),
                  child: KText(
                    "jump to page",
                    size: R.f(info, 12),
                    weight: FontWeight.bold,
                  ),
                ),
                Consumer(
                  builder: (context, watch, child) {
                    var _jumper = watch(jumperProvider).pageNoController;
                    return Row(
                      children: [
                        Container(
                          width: R.h(info, 10),
                          height: R.h(info, 5),
                          margin: EdgeInsets.symmetric(horizontal: pad),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: CupertinoTextField(
                                    autofocus: false,
                                    controller: _jumper,
                                    style: TextStyle(
                                      fontSize: R.f(info, 10),
                                      color: theme.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    keyboardAppearance:
                                        Theme.of(context).brightness,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    onChanged: (value) {
                                      bool isint = isInt(value);
                                      if (isint) {
                                        var i = int.parse(value);
                                        if (i < 1 ||
                                            i > pageination.totalPageNumber) {
                                          _jumper.clear();
                                          _focus.unfocus();
                                          Kui().toast(
                                            context,
                                            "enter value between 1 to ${pageination.totalPageNumber.toString()}",
                                            textColor: Colors.red,
                                            backgroundColor: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                          );
                                        }
                                      } else {
                                        _jumper.clear();
                                        _focus.unfocus();
                                        Kui().toast(
                                          context,
                                          "enter a valid number",
                                          textColor: Colors.red,
                                          backgroundColor: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                        );
                                      }
                                    },
                                    textAlign: TextAlign.center,
                                    placeholder: page.currentPage,
                                    placeholderStyle: TextStyle(
                                      fontSize: R.f(info, 10),
                                      color: theme.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    maxLength: 3,
                                    maxLines: 1,
                                    maxLengthEnforcement:
                                        MaxLengthEnforcement.enforced,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: pad),
                                child: KText(
                                  "/ ${page.totalPages}",
                                  size: R.f(info, 10),
                                  weight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        KClickable(
                          height: R.h(info, 4),
                          width: R.w(info, 10),
                          onPressed: () {
                            goOnTap();
                          },
                          child: KText(
                            "go",
                            size: 11,
                            weight: FontWeight.bold,
                          ),
                          topDeco: G.redGradBannerDeco,
                          bottomDeco: G.blackGradButtonDeco,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          pageination.hasNext!
              ? Container(
                  margin: const EdgeInsets.symmetric(horizontal: pad),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(pad),
                        child: KText(
                          "next",
                          size: R.f(info, 12),
                          weight: FontWeight.bold,
                        ),
                      ),
                      KClickable(
                        height: R.h(info, 5),
                        width: R.w(info, 16),
                        onPressed: () {
                          nextOnTap();
                        },
                        child: Icon(
                          EvaIcons.arrowRight,
                          color: Colors.black,
                        ),
                        topDeco: G.green2GradBannerDeco,
                        bottomDeco: G.blackGradButtonDeco,
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
