import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/components/button/button_account.dart';
import 'package:mobile/components/input/input.dart';
import 'package:mobile/module/account-screen/account_screen.dart';
import 'package:mobile/module/sign-in-screen/sign_in_screen.dart';
import 'package:mobile/provider/user_provider.dart';
import 'package:provider/provider.dart';

final nameController = TextEditingController();
final emailController = TextEditingController();
final passwordController = TextEditingController();

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return SignUpScreenState();
  }
}

class SignUpScreenState extends State<SignUpScreen> {
  void signUp(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final response = await userProvider.signUp(
        nameController.text, emailController.text, passwordController.text);
    if (response) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const AccountScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registration failed, please try again.")));
    }
  }

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
            "Đăng ký",
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
                children: <Widget>[
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.0),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Column(
                                children: <Widget>[
                                  InputField(
                                    label: "Họ và tên",
                                    obscureText: false,
                                    textController: nameController,
                                  ),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 80),
                              child: ButtonAccount(
                                label: "Đăng ký",
                                onPressed: () => signUp(context),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text("Bạn đã có tài khoản?"),
                                CupertinoButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SignInScreen()));
                                    },
                                    child: const Text(
                                      "Đăng nhập ngay!",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ]),
                ])));
  }
}
