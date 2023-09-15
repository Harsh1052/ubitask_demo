// padding extension

import 'package:flutter/widgets.dart';

extension CustomPadding on Widget{


  Padding addPadding(double padding){
    return Padding(
      padding: EdgeInsets.all(padding),
      child: this,
    );
  }

  Padding addPaddingSymmetric({double? horizontal, double? vertical}){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal??0, vertical: vertical??0),
      child: this,
    );
  }


}