import 'package:flutter/material.dart';
import 'package:MSXIV_Driver_Display/constants/std_colors.dart';

// gradient for bottom of display
class BgGradient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.24,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: StdColors.backgroundGradient,
                stops: [0.5, 1.0],
                begin: Alignment(0.0, -1.0),
                end: Alignment(0.0, 1.0)),
          ),
        ));
  }
}
