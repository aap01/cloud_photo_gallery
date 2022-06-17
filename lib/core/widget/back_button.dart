import 'package:flutter/material.dart';

class BackButton extends StatelessWidget {
  const BackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: const Icon(Icons.arrow_back_ios),
      onWillPop: () => onWillPop(context),
    );
  }

  Future<bool> onWillPop(context) async {
    Navigator.pop(context);
    return true;
  }
}
