import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movietime/src/enum/theme.dart';
import 'package:movietime/src/page/widget/up-widget.dart';
import 'package:provider/provider.dart';

class Upgrade extends StatelessWidget {
  const Upgrade({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return ListTile(
      onTap: () {
        Get.to(() => Update_Widget());
      },
      leading: Icon(
        Icons.update,
        color: themeProvider.isDarkMode ? Colors.white : Colors.black,
      ),
      title: Text(
        "Upgrade",
        style: TextStyle(
          color: themeProvider.isDarkMode ? Colors.white : Colors.black,
          fontSize: 18,
        ),
      ),
    );
  }
}
