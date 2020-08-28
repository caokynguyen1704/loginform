import 'package:flutter/material.dart';
import 'package:login_form/story.dart';

import 'formwidget.dart';

class GoTo {
  static gotoFormWidget(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormWidgets()));
  }

  static gotoStory(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormValidation()));
  }

  GoTo();
}
