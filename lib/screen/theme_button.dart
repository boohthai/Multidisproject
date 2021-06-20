import 'package:multidisproject_2/screen/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeButton extends StatelessWidget {
  ThemeData buttonThemeData  ;
  ThemeButton({ required this.buttonThemeData});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

 return OutlinedButton(
    child: Text('Change Theme'),
    style: OutlinedButton.styleFrom(
      primary: Colors.black,
      backgroundColor: buttonThemeData.primaryColor,
      side: BorderSide(color: Colors.black, width: 2),
      //  primary:  Colors.black ,
      // backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)),),
    ),
    onPressed: () => themeNotifier.setTheme(buttonThemeData),
  );
  }

  Widget _getIcon(ThemeNotifier themeNotifier) {
    bool selected = (themeNotifier.getTheme() == buttonThemeData);

    return Container(
      key: Key((selected) ? "ON" : "OFF"),
      child: Icon(
        (selected) ? Icons.done : Icons.close,
        color: buttonThemeData.accentColor,
        size: 10.0,
      ),
    );

  }
}
