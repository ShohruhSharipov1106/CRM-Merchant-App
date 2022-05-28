import 'package:crm_merchant/constants/exports.dart';

import '../profile/two_panels_page.dart';
// ignore: must_be_immutable
class HomeBodyPage extends StatefulWidget {
  ZoomDrawerController drawerController;
  HomeBodyPage(this.drawerController, {Key? key}) : super(key: key);

  @override
  State<HomeBodyPage> createState() => _HomeBodyPageState();
}

class _HomeBodyPageState extends State<HomeBodyPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
    value: -1.0,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool get isPanelVisible {
    final AnimationStatus status = controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: LocaleText(
          "list_of_zayavka",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        centerTitle: true,
        leadingWidth: kWidth(36.0).w,
        leading: Row(
          children: [
            const Spacer(),
            InkWell(
              onTap: () {
                widget.drawerController.toggle!();
              },
              child: SizedBox(
                height: kHeight(20.0).h,
                width: kWidth(20.0).w,
                child: SvgPicture.asset(
                  "assets/icons/menu.svg",
                ),
              ),
            ),
          ],
        ),
      ),
      body: TwoPanels(
        controller: controller,
      ),
    );
  }
}
