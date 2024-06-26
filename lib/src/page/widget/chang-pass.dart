import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movietime/src/enum/theme.dart';
import 'package:movietime/src/page/widget/changpass-widget.dart';
import 'package:provider/provider.dart';

class ChangPassword extends StatelessWidget {
  const ChangPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return ListTile(
      onTap: () {
        Get.to(() => ChangPassWordWidget());
      },
      leading: Icon(
        Icons.key_outlined,
        color: themeProvider.isDarkMode ? Colors.white : Colors.black,
      ),
      title: Text(
        "Change Password",
        style: TextStyle(
          color: themeProvider.isDarkMode ? Colors.white : Colors.black,
          fontSize: 18,
        ),
      ),
    );
  }
}
