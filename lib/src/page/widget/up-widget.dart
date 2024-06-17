import 'package:flutter/material.dart';

class Update_Widget extends StatelessWidget {
  const Update_Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(
          "Update App",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.info_outline,
              size: 26,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Hey there! We've just released a new update for our app and"
                " we really hope you'll install it as soon as possible. "
                "This update includes some great new features and improvements, as well as"
                " bug fixes and stability enhancements. "
                "So please, install the update and enjoy the best experience.",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  wordSpacing: 3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
