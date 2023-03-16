import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../error/error.dart';

void errorDialog({
  required BuildContext context,
  CustomError? customError,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Center(child: Text(customError?.title ?? '서버 오류')),
        content:
            Text(customError?.message ?? '서버로부터의 통신이 원활하지 않습니다. 재요청 해주세요.'),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          // TextButton(
          //   onPressed: () => Navigator.pop(context),
          //   child: Text('A'),
          // ),
          // TextButton(
          //   onPressed: () => Navigator.pop(context),
          //   child: Text('B'),
          // ),
        ],
      );
    },
  );
}
