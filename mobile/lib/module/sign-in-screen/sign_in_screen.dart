import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/components/button/button_account.dart';
import 'package:mobile/components/input/input.dart';
import 'package:mobile/module/sign-up-screen/sign_up_screen.dart';

final emailController = TextEditingController();
final passwordController = TextEditingController();

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});
/*
  Future<String> signIn() async {
    final email = emailController.text;
    final password = passwordController.text;
    final body = {
      'email': email,
      'password': password,
    };
    final response = await http.post(Uri.parse(Url.login),
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    } else {
      print(response.body);
      print('Sign in error');
      throw Exception('Failed to sign in');
    }
  }
*/
void signIn(){}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: const Color(0xFFECE6D6),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          title: Text(
            "Đăng nhập",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        body: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            color: const Color(0xFFDCD1B3),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: <Widget>[
                            InputField(
                              label: "Email",
                              obscureText: false,
                              textController: emailController,
                            ),
                            InputField(
                              label: "Mật khẩu",
                              obscureText: true,
                              textController: passwordController,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 80),
                          child: ButtonAccount(
                            label: "Đăng nhập",
                            onPressed: signIn,
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text("Bạn chưa có tài khoản?"),
                          CupertinoButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpScreen()));
                              },
                              child: const Text(
                                "Đăng ký ngay!",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              )),
                        ],
                      )
                    ],
                  ),
                ])));
  }
}
