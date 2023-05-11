import 'package:flutter/material.dart';

class CustomAlertDialog{

  static Future<void> customAlertButton(BuildContext context,final Function()? onTapOk,String title,String ok,String cancel) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 30,
            title: Text(title),
            actions: <Widget>[
              TextButton(
                child: Text(cancel),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text(ok),
                onPressed: () {
                  onTapOk!();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
    );
  }
}

