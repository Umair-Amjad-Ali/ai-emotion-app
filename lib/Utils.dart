import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class Utils{
  static goBack(BuildContext context){
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      SystemNavigator.pop();
    }
  }
}