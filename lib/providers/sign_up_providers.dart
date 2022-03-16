import 'package:crm_merchant/constants/exports.dart';

class SignUpProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController smsChecker = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final pinputKey = GlobalKey<FormState>();
}
