import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movietime/src/page/screen/profile.dart';
import 'package:movietime/src/page/screen/search.dart';
import 'package:movietime/src/page/widget/latest_widget.dart';

import 'package:movietime/src/page/widget/slide_widget.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ScrollWidget(),
            GenreWidget(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    // Define the _buildAppBar method
    return AppBar(
      title: Text(
        "Movie Time",
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    Get.to(() => SearchScreen());
                  },
                  child: Icon(Icons.search)),
              CircleAvatar(
                backgroundColor: Colors.transparent,
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => ProfileScreen());
                  },
                  child: Image(
                    height: 30,
                    image: AssetImage(
                      'assets/acc.png',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
