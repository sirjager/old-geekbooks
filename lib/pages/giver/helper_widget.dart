import 'package:flutter/cupertino.dart';
import 'package:geeklibrary/export/export.dart';
import 'package:geeklibrary/pages/giver/provider.dart';

class HelperWidget extends StatelessWidget {
  HelperWidget({Key? key, required this.isDarkMode, required this.pro})
      : super(key: key);

  final bool isDarkMode;
  final DownloadExternallyProvider pro;

  final List<String> providerList = ["GET", "CLOUDFLARE", "IPFS", "INFURA"];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDarkMode ? XColors.darkColor : XColors.lightColor1,
      ),
      padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 50.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                KText(
                  "Frequently Asked Questions",
                  color: XColors.grayColor,
                  weight: FontWeight.bold,
                  size: 40.sp,
                  googleFont: GoogleFonts.mavenPro(),
                ),
              ],
            ),
            SizedBox(height: 40.h),
            KText(
              "How many providers are there ?",
              color: Colors.red,
              weight: FontWeight.bold,
              size: 40.sp,
              googleFont: GoogleFonts.mavenPro(),
            ),
            KText(
              "There are 4 different download providers.",
              weight: FontWeight.bold,
              size: 40.sp,
              googleFont: GoogleFonts.mavenPro(),
            ),
            SizedBox(height: 40.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: providerList
                  .map(
                    (e) => Container(
                      decoration: G.green2GradBannerDeco,
                      height: 100.w,
                      width: 200.w,
                      padding: EdgeInsets.all(20.w),
                      alignment: Alignment.center,
                      child: KText(
                        e,
                        size: 20.sp,
                        weight: FontWeight.bold,
                        color: isDarkMode
                            ? XColors.darkColor1
                            : XColors.lightColor1,
                      ),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 40.h),
            KText(
              "What should i do if link dosen't work ?",
              color: Colors.red,
              weight: FontWeight.bold,
              size: 40.sp,
              googleFont: GoogleFonts.mavenPro(),
            ),
            KText(
              "If one dosen't work or show \"Something went wrong\",then try downloading with different download provider.",
              weight: FontWeight.bold,
              size: 40.sp,
              googleFont: GoogleFonts.mavenPro(),
            ),
            SizedBox(height: 40.h),
            KText(
              "Some links are old and might not work or take more time",
              weight: FontWeight.bold,
              size: 40.sp,
              googleFont: GoogleFonts.mavenPro(),
            ),
            SizedBox(height: 40.h),
            KText(
              "What can i do if in-app downloading is not working ?",
              color: Colors.red,
              weight: FontWeight.bold,
              size: 40.sp,
              googleFont: GoogleFonts.mavenPro(),
            ),
            KText(
              "If In-App Download is still not working then try switching to Browser Mode.",
              color: XColors.grayColor,
              weight: FontWeight.bold,
              size: 40.sp,
              googleFont: GoogleFonts.mavenPro(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                KText(
                  "Enable Broweser Mode",
                  size: 40.sp,
                  googleFont: GoogleFonts.mavenPro(),
                  weight: FontWeight.bold,
                  color: isDarkMode
                      ? XColors.darkGray.withOpacity(0.7)
                      : XColors.darkColor1.withOpacity(0.7),
                ),
                CupertinoSwitch(
                  value: pro.external,
                  onChanged: (val) {
                    pro.changeMode(val);
                    while (Get.isBottomSheetOpen == true) {
                      Get.back();
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 40.h),
            KText(
              "BROWSER MODE will open same download link in your browser.",
              color: Colors.blueAccent,
              weight: FontWeight.bold,
              size: 40.sp,
              googleFont: GoogleFonts.mavenPro(),
            ),
            SizedBox(height: 40.h),
            KText(
              "After File is Downloaded You can directly open from Popup Snackbar",
              color: isDarkMode ? Colors.yellowAccent : Colors.indigo,
              weight: FontWeight.bold,
              size: 40.sp,
              googleFont: GoogleFonts.mavenPro(),
            ),
            SizedBox(height: 40.h),
            KText(
              "Snackbar Will automatically close after 5 seconds",
              color: isDarkMode ? Colors.yellowAccent : Colors.indigo,
              weight: FontWeight.bold,
              size: 40.sp,
              googleFont: GoogleFonts.mavenPro(),
            ),
          ],
        ),
      ),
    );
  }
}
