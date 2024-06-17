import 'package:flutter/material.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(
          "Information App",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "This App helps people better understand an app’s "
                "privacy practices before they download the app on any "
                "Apple platform. On each app’s "
                "product page, users can learn about some of"
                "the data types the app may collect, and whether "
                "that data is linked to them or used to track them."
                "You’ll need to provide information about your apps "
                "privacy practices, including the practices of "
                "third-party partners whose code you integrate "
                "into your app, in App Store Connect. "
                "This information is required to submit new"
                "apps and app updates to the App.",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  wordSpacing: 3,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
