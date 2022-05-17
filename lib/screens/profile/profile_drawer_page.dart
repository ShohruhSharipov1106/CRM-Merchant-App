import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/home/home_body_page.dart';
import 'package:crm_merchant/screens/profile/profile_menu_page.dart';

class ProfileDrawerPage extends StatefulWidget {
  const ProfileDrawerPage({Key? key}) : super(key: key);

  @override
  State<ProfileDrawerPage> createState() => _ProfileDrawerPageState();
}

class _ProfileDrawerPageState extends State<ProfileDrawerPage> {
  final ZoomDrawerController _drawerController = ZoomDrawerController();
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(      
        controller: _drawerController,
        closeCurve: Curves.easeInSine,
        showShadow: true,
        style: DrawerStyle.defaultStyle,
        menuBackgroundColor: kMainColor,
        angle: -2.0,
        mainScreenTapClose: true,
        androidCloseOnBackTap: true,
        drawerShadowsBackgroundColor: kWhiteColor,
        menuScreen: const ProfileMenuPage(),
        mainScreen:  HomeBodyPage(_drawerController));
  }
}
