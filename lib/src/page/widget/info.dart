
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movietime/src/page/widget/info-widget.dart';

class Info extends StatelessWidget {
  const Info({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.to(() => InfoWidget());
      },
      leading: Icon(
        Icons.info_outline,
        color: Colors.black,
      ),
      title: Text(
        "Information",
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
    );
  }
}
