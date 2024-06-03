import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/components/button/button_account.dart';
import 'package:mobile/components/input/input.dart';
import 'package:mobile/components/title/screen_header.dart';
import 'package:mobile/module/account-screen/account_screen.dart';
import 'package:mobile/module/sign-up-screen/sign_up_screen.dart';
import 'package:mobile/provider/user_provider.dart';
import 'package:provider/provider.dart';

final emailController = TextEditingController();
final passwordController = TextEditingController();

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return SignInScreenState();
  }
}

class SignInScreenState extends State<SignInScreen> {
  void signIn(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final response =
        await userProvider.login(emailController.text, passwordController.text);
    if (response) {
      Navigator.pop(context,
          MaterialPageRoute(builder: (context) => const AccountScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Registration failed, please try again."),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: ScreenHeader(title: "Đăng nhập"),
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
                            onPressed: () => signIn(context),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text("Bạn chưa có tài khoản?"),
                          CupertinoButton(
                              onPressed: () {
                                Navigator.pushReplacement(
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
