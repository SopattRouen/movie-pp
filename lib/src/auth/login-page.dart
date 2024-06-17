import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movietime/src/service/authservice.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegister;
  const LoginPage({super.key, required this.showRegister});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formemail = GlobalKey<FormState>();
  final _formpass = GlobalKey<FormState>();
  bool isClick = true;
  final _service = Get.put(AuthService());

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
            Positioned(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 100,
                    horizontal: 25,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Log into your account",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
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
                            hintText: "Enter Name or Email",
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
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Fogot Password?",
                            style: TextStyle(color: Colors.red, fontSize: 14),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formemail.currentState!.validate() &&
                              _formpass.currentState!.validate()) {
                            
                            _service.signIn();
                          }
                        },
                        child: Text("Login"),
                      ),
                      Row(
                        children: [
                          Text(
                            "Don't Have an Account yet?",
                            style: TextStyle(color: Colors.white),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                widget.showRegister();
                              });
                            },
                            child: Text(
                              "Sign Up",
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
          ],
        ),
      ),
    );
  }
}
