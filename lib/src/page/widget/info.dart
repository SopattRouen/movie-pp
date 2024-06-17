import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movietime/src/enum/theme.dart';
import 'package:movietime/src/page/widget/info-widget.dart';
import 'package:provider/provider.dart';

class Info extends StatelessWidget {
  const Info({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return ListTile(
      onTap: () {
        Get.to(() => InfoWidget());
      },
      leading: Icon(
        Icons.info_outline,
        color: themeProvider.isDarkMode ? Colors.white : Colors.black,
      ),
      title: Text(
        "Information",
        style: TextStyle(
          color: themeProvider.isDarkMode ? Colors.white : Colors.black,
          fontSize: 18,
        ),
      ),
    );
  }
}
