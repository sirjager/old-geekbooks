import 'package:geeklibrary/widgets/kbuttons/kleaf_button.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:geeklibrary/export/export.dart';

class UiDialog {
  static void showExceptionDialog(
      {String title = "Error", String desc = "Something went wrong"}) {
    Get.dialog(
      Dialog(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          height: 850.h,
          width: 300.w,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(MyAssets.cross, height: 400.w),
                  Text(
                    title,
                    style: Get.textTheme.headline4,
                  ),
                  Text(
                    desc,
                    style: Get.textTheme.headline4,
                  ),
                  TextButton(
                    onPressed: () {
                      if (Get.isDialogOpen == true) Get.back();
                    },
                    child: Text("Okay"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void showDialog({
    required String title,
    String desc = "",
    required String lottie,
    bool enableAction = false,
    required String actionTitle,
    Color? color,
    Widget? child,
  }) {
    Get.dialog(
      Dialog(
        backgroundColor: color,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: child ??
            Consumer(
              builder: (context, watch, child) {
                bool isDarkMode = watch(themeProvider).isDarkMode;
                return child ??
                    Container(
                      height: 900.h,
                      width: 300.w,
                      child: Padding(
                        padding: EdgeInsets.all(10.w),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 50.h),
                              Lottie.asset(lottie, height: 400.w),
                              SizedBox(height: 50.h),
                              KText(
                                title,
                                size: 80.sp,
                                weight: FontWeight.bold,
                                color: isDarkMode
                                    ? Colors.black
                                    : XColors.grayColor,
                              ),
                              SizedBox(height: 10.h),
                              KText(desc, size: 40.sp, weight: FontWeight.bold),
                              SizedBox(height: 50.h),
                              KLeafButton(
                                onPressed: () {
                                  if (Get.isDialogOpen == true) Get.back();
                                },
                                color1: isDarkMode
                                    ? XColors.darkColor
                                    : Colors.blueGrey[100]!,
                                color2: isDarkMode
                                    ? XColors.darkColor2
                                    : Colors.blueGrey[200]!,
                                height: 150.h,
                                width: 350.w,
                                child: KText(
                                  "continue",
                                  googleFont: GoogleFonts.poppins(),
                                  size: 40.sp,
                                  color: isDarkMode
                                      ? XColors.darkText
                                      : XColors.darkColor2,
                                  weight: FontWeight.bold,
                                ),
                                icon: Ionicons.arrow_forward_circle,
                                iconColor: isDarkMode
                                    ? XColors.darkText
                                    : XColors.darkColor2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
              },
            ),
      ),
      barrierDismissible: false,
    );
  }

  static Future<bool> choiseDialog({
    required String title,
    String desc = "",
    required String lottie,
    bool enableAction = false,
    String choice1 = "no",
    String choice2 = "yes",
    Color? color,
    Widget? child,
  }) async {
    late bool result;
    await Get.dialog(
      Dialog(
        backgroundColor: color,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: child ??
            Consumer(
              builder: (context, watch, child) {
                bool isDarkMode = watch(themeProvider).isDarkMode;
                return child ??
                    Container(
                      height: 900.h,
                      width: 300.w,
                      child: Padding(
                        padding: EdgeInsets.all(10.w),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 50.h),
                              Lottie.asset(lottie, height: 400.w),
                              SizedBox(height: 50.h),
                              KText(
                                title,
                                size: 80.sp,
                                weight: FontWeight.bold,
                                color: isDarkMode
                                    ? Colors.black
                                    : XColors.grayColor,
                              ),
                              SizedBox(height: 10.h),
                              KText(desc, size: 40.sp, weight: FontWeight.bold),
                              SizedBox(height: 50.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  KLeafButton(
                                    onPressed: () {
                                      while (Get.isDialogOpen == true) {
                                        Get.back();
                                      }
                                      result = false;
                                    },
                                    color1: isDarkMode
                                        ? XColors.darkColor
                                        : Colors.blueGrey[100]!,
                                    color2: isDarkMode
                                        ? XColors.darkColor2
                                        : Colors.blueGrey[200]!,
                                    height: 100.h,
                                    width: 250.w,
                                    child: KText(
                                      choice1,
                                      googleFont: GoogleFonts.poppins(),
                                      size: 40.sp,
                                      color: isDarkMode
                                          ? XColors.darkText
                                          : XColors.darkColor2,
                                      weight: FontWeight.bold,
                                    ),
                                    icon: Typicons.cancel,
                                    iconColor: isDarkMode
                                        ? XColors.darkText
                                        : XColors.darkColor2,
                                  ),
                                  KLeafButton(
                                    onPressed: () {
                                      while (Get.isDialogOpen == true) {
                                        Get.back();
                                      }
                                      result = true;
                                    },
                                    color1: isDarkMode
                                        ? XColors.darkColor
                                        : Colors.blueGrey[100]!,
                                    color2: isDarkMode
                                        ? XColors.darkColor2
                                        : Colors.blueGrey[200]!,
                                    height: 100.h,
                                    width: 250.w,
                                    child: KText(
                                      choice2,
                                      googleFont: GoogleFonts.poppins(),
                                      size: 40.sp,
                                      color: isDarkMode
                                          ? XColors.darkText
                                          : XColors.darkColor2,
                                      weight: FontWeight.bold,
                                    ),
                                    icon: Ionicons.exit_outline,
                                    iconColor: isDarkMode
                                        ? XColors.darkText
                                        : XColors.darkColor2,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
              },
            ),
      ),
      barrierDismissible: false,
    );
    return result;
  }
}
