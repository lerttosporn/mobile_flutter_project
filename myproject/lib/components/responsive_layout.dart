import 'package:flutter/material.dart';
import 'package:myproject/themes/colors.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget tabletBody;
  const ResponsiveLayout({
    Key? key,
    required this.mobileBody,
    required this.tabletBody,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryDark, primaryLight],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: EdgeInsetsGeometry.all(16.0),
                child: Card(
                  elevation: 12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                          Widget childWidget=mobileBody;
                          if(constraints.maxWidth>800){
                            childWidget=tabletBody;
                          }
                          return childWidget;
                        },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
