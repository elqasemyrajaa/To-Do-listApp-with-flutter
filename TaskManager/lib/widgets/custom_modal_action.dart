import 'package:flutter/material.dart';
import 'package:TaskManager/widgets/custom_button.dart';

class CustomModalActionButton extends StatelessWidget {
  final VoidCallback onClose;
  final VoidCallback onSave;
  CustomModalActionButton({
    @required this.onClose,
    @required this.onSave
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CustomButton(
          onPressed: onClose,
          buttonText: "close",
        ),
        CustomButton(
          onPressed: onSave,
          buttonText: "save",
          color: Color.fromRGBO(142, 188, 35, 1),
          textColor: Colors.white,
        )
      ],
    );
  }
}
