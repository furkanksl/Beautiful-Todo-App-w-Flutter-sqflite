library animated_dialog_box;

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as math;

class animated_dialog_box {
  static Future showCustomAlertBox({
    @required BuildContext context,
    @required Widget yourWidget,
    @required Widget firstButton,
  }) {
    assert(context != null, "context is null!!");
    assert(yourWidget != null, "yourWidget is null!!");
    assert(firstButton != null, "Button is null!!");
    return showDialog(
      
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                yourWidget,
              ],
            ),
            actions: <Widget>[firstButton],
            elevation: 10,
          );
        });
  }



  static Future showRotatedAlert({
    @required BuildContext context,
    @required Widget yourWidget,
    Widget icon,
    Widget title,
    @required Widget firstButton,
    Widget secondButton,
  }) {
    assert(context != null, "context is null!!");
    assert(yourWidget != null, "yourWidget is null!!");
    assert(firstButton != null, "button is null!!");
    return showGeneralDialog(
        context: context,
        pageBuilder: (context, anim1, anim2) {},
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.7),
        barrierLabel: '',
        transitionBuilder: (context, anim1, anim2, child) {
          return Transform.rotate(
            angle: math.radians(anim1.value * 360),
            child: AlertDialog(
              backgroundColor: Colors.red,
              shape:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
              title: title,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  icon,
                  Container(
                    height: 10,
                  ),
                  yourWidget
                ],
              ),
              actions: <Widget>[firstButton, secondButton],
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 300));
  }
}
