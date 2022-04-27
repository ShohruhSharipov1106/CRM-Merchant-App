import 'package:crm_merchant/constants/exports.dart';
import 'package:flutter/cupertino.dart';

class ProfileMenuPage extends StatefulWidget {
  const ProfileMenuPage({Key? key}) : super(key: key);

  @override
  State<ProfileMenuPage> createState() => _ProfileMenuPageState();
}

class _ProfileMenuPageState extends State<ProfileMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: Padding(
        padding: EdgeInsets.only(
          left: kWidth(30.0).w,
          top: kHeight(120.0).h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CupertinoSwitch(
              value: true,
              onChanged: (v) {},
            ),
            SizedBox(height: kHeight(28.0).h),
            Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/log-out.svg",
                  height: kHeight(33.0).h,
                  width: kWidth(33.0).w,
                ),
                SizedBox(width: kWidth(11.0).w),
                const LocaleText(
                  'log_out',
                  style: TextStyle(
                    color: kWhiteColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
