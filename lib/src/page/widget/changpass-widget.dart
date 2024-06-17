
import 'package:flutter/material.dart';



class ChangPassWordWidget extends StatelessWidget {
  ChangPassWordWidget({super.key});
  final _curkey = GlobalKey<FormState>();
  final _newkey = GlobalKey<FormState>();
  final txt_cur = TextEditingController();
  final txt_new = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Change Password",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25),
              child: Form(
                key: _curkey,
                child: TextFormField(
                  controller: txt_cur,
                  decoration: InputDecoration(
                    label: Text("Current Password"),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if ((value == null || value.isEmpty)) {
                      return ("Please Enter Current Password");
                    }
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Form(
                key: _newkey,
                child: TextFormField(
                  controller: txt_new,
                  decoration: InputDecoration(
                    label: Text("New Password"),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if ((value == null || value.isEmpty)) {
                      return ("Please Enter New Password");
                    }
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(25),
          ),
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {
              if (_curkey.currentState!.validate() &&
                  _newkey.currentState!.validate()) {
                // Get.to(() => OtpCode());
              }
            },
            child: Text(
              "Send",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
