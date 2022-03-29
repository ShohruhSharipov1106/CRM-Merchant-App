import 'package:crm_merchant/constants/exports.dart';


class Testssss extends StatelessWidget {
  final number = new ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackTextColor,
      body: ValueListenableBuilder<int>(
        valueListenable: number,
        builder: (context, value, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    number.value++;
                  },
                  child: Text("Boss"),
                ),
              ),
              MyWidget(number),
            ],
          );
        },
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  final ValueListenable<int> number;

  MyWidget(this.number);

  @override
  Widget build(BuildContext context) {
    return new Text(number.value.toString());
  }
}
