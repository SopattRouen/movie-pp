import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movietime/src/page/widget/up-widget.dart';

class Upgrade extends StatelessWidget {
  const Upgrade({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.to(() => Update_Widget());
      },
      leading: Icon(
        Icons.update,
        color: Colors.black,
      ),
      title: Text(
        "Upgrade",
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
    );
  }
}
