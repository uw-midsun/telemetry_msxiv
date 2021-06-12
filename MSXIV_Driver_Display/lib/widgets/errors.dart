import 'package:MSXIV_Driver_Display/constants/std_fonts.dart';
import 'package:MSXIV_Driver_Display/utils/errors.dart';
import 'package:flutter/material.dart';

const int MAX_ERRORS = 4;

/// Renders errors.
///
/// Receives a List of ErrorStates to render.
class Errors extends StatelessWidget {
  final List<ErrorStates> errors;

  Errors(this.errors, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Filter duplicate errors.
    List<ErrorStates> filtered = errors.toSet().toList();

    // Sort errors such that dangerous errors come first.
    filtered.sort((a, b) {
      final severity1 = a.errorInfo["severity"];
      final severity2 = b.errorInfo["severity"];
      if (severity1 == severity2) {
        return 0;
      } else if (severity1 == ErrorSeverity.Dangerous) {
        return -1;
      }
      return 1;
    });

    bool isTooManyErrors = filtered.length > MAX_ERRORS;

    // If too many errors, slice list based on MAX_ERRORS.
    if (isTooManyErrors) {
      filtered = filtered.sublist(0, MAX_ERRORS - 1);
    }

    List<Widget> errorWidgets = filtered.map((error) {
      final errorInfo = error.errorInfo;
      return ErrorItem(
          errorInfo["heading"], errorInfo["caption"], errorInfo["severity"]);
    }).toList();

    if (isTooManyErrors) {
      errorWidgets.add(ErrorItem(
          "+" + (errors.length - 3).toString(), "", ErrorSeverity.Dangerous));
    }

    return Container(
      margin: EdgeInsets.only(top: 100, left: 24),
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: errorWidgets,
      ),
    );
  }
}

class ErrorItem extends StatelessWidget {
  final String heading, caption;
  final severity;
  ErrorItem(this.heading, this.caption, this.severity);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 13, bottom: 13),
      child: Column(
        children: <Widget>[
          Text(heading, style: Fonts.getErrorHeader(severity)),
          Text(caption, style: Fonts.getErrorCaption(severity))
        ],
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}
