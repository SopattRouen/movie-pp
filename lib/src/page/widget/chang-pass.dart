import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movietime/src/page/widget/changpass-widget.dart';

class ChangPassword extends StatelessWidget {
  const ChangPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.to(() => ChangPassWordWidget());
      },
      leading: Icon(
        Icons.key_outlined,
        color: Colors.black,
      ),
      title: Text(
        "Change Password",
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
    );
  }
}
