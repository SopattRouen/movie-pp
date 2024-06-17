import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:movietime/src/enum/theme.dart';
import 'package:movietime/src/service/authservice.dart';
import 'package:provider/provider.dart';

class Logout extends StatefulWidget {
  const Logout({
    super.key,
  });

  @override
  State<Logout> createState() => _LogoutState();
}

final controll = AuthService();

class _LogoutState extends State<Logout> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return ListTile(
      onTap: () {
        setState(() {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.info,
            animType: AnimType.rightSlide,
            title: 'Are you sure to log out?',
            titleTextStyle: TextStyle(fontSize: 25),
            desc: '',
            descTextStyle: TextStyle(fontSize: 23),
            btnCancelOnPress: () {},
            btnOkOnPress: () {
              controll.signout();
            },
          )..show();
        });
      },
      leading: Icon(
        Icons.logout,
        color: themeProvider.isDarkMode ? Colors.white : Colors.black,
      ),
      title: Text(
        "Logout",
        style: TextStyle(
          color: themeProvider.isDarkMode ? Colors.white : Colors.black,
          fontSize: 18,
        ),
      ),
    );
  }
}
