import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kunwari_study/components/my_button.dart';
import 'package:kunwari_study/components/my_textfield.dart';
import 'package:http/http.dart' as http;
import 'package:kunwari_study/components/show_alert.dart';
import 'package:kunwari_study/pages/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  void _handleLogin () async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.parse("http://localhost/contact/api/users.php");
    Map<String, String> jsonData = {
      "username": _username.text,
      "password": _password.text,
    };

    Map<String, String> requestBody ={
      "operation": "login",
      "json": jsonEncode(jsonData),
    };

    var response = await http.post(url, body: requestBody);
    print("res ni login: ${response.body}");

    var res = jsonDecode(response.body);

    if(res != 0){
      print("id ni user ${res["usr_id"]}");
      // res ni login: {"usr_id":1,"usr_username":"pitok","usr_password":"12345","usr_fullname":"Pitok Batolata"}
      prefs.setInt("userId", res["usr_id"]);
      ShowAlert().showAlert("success", "Login Successful");
      Get.to(() => const Dashboard());
    }else{
      ShowAlert().showAlert("error", "Invalid Credentials");
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            child: Padding(
              padding:  EdgeInsets.all(Get.width * 0.1),
              child: Column(
                children: [
                  MyTextfield(
                    labelText: "Username",
                    controller: _username,
                  ),
                  const SizedBox(height: 10),
                  MyTextfield(
                    labelText: "Password",
                    controller: _password,
                    isObscure: true,
                  ),
                  const SizedBox(height: 16),
                  MyButton(
                    onPressed: () {
                      _handleLogin();
                    },
                    text: "Login",
                    color: Colors.purple.shade900,
                    size: 16.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
