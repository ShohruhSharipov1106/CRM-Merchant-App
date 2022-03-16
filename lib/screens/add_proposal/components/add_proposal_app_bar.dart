import 'package:crm_merchant/constants/exports.dart';

AppBar addProposalAppBar(
  BuildContext context,
  String appBarTitle,
) {
  return AppBar(
    title: Text(
      appBarTitle,
      style: Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 24.0),
    ),
    centerTitle: true,
  );
}
