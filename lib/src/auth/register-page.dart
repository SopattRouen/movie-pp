import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movietime/src/service/authservice.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLogin;
  const RegisterPage({super.key, required this.showLogin});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formemail = GlobalKey<FormState>();
  final _formpass = GlobalKey<FormState>();
  final _service = Get.put(AuthService());
  bool isClick = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image(
                fit: BoxFit.fill,
                image: AssetImage('assets/movie.jpg'),
              ),
            ),
            SingleChildScrollView(
              child: Positioned(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 130,
                      horizontal: 25,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Create Your Account",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 34,
                          ),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        Form(
                          key: _formemail,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter Email";
                              } else {
                                return null;
                              }
                            },
                            controller: _service.form.con_mail,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Enter Name or  Email",
                              hintStyle: TextStyle(color: Colors.white),
                              suffixIcon: Icon(
                                Icons.email,
                                color: Colors.white,
                              ),
                            ),
                            cursorColor: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 55,
                        ),
                        Form(
                          key: _formpass,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter your password";
                              } else {
                                return null;
                              }
                            },
                            controller: _service.form.con_pass,
                            obscureText: isClick,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: "Enter Your Password",
                              labelStyle: TextStyle(color: Colors.white),
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    isClick = !isClick;
                                  });
                                },
                                child: Icon(
                                  isClick
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            cursorColor: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formemail.currentState!.validate() &&
                                _formpass.currentState!.validate()) {
                              
                              _service.createAcount();
                            }
                          },
                          child: Text("Sign Up"),
                        ),
                        Row(
                          children: [
                            Text(
                              "Already Have an Account?",
                              style: TextStyle(color: Colors.white),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  widget.showLogin();
                                });
                              },
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Or",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              child: Image(
                                image: AssetImage('assets/facebook.png'),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: Image(
                                image: AssetImage('assets/google.png'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
