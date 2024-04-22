import 'package:flutter/material.dart';
import 'package:mobile/module/sign-in-screen/sign_in_screen.dart';
import 'package:mobile/module/sign-up-screen/sign_up_screen.dart';
import 'package:mobile/provider/user_provider.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return AccountScreenState();
  }
}

class AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.checkLoginStatus();
  }

  void logout() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.logout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFECE6D6),
          title: Text(
            "Cá nhân",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: const [
            IconButton(
              icon: Icon(
                Icons.search,
                color: Color(0xFFB2572B),
              ),
              tooltip: 'Search',
              onPressed: null,
            ),
          ],
        ),
        body: Consumer<UserProvider>(builder: (context, userProvider, child) {
          return SafeArea(
            child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.all(10.0),
                child: userProvider.currentUser != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.account_circle_outlined,
                                  size: 100,
                                  color: Color(0xFFB2572B),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userProvider.currentUser!.name,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 25),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      userProvider.currentUser!.email,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    IconButton(
                                        onPressed: null,
                                        icon: Icon(
                                          Icons.create_outlined,
                                          size: 20,
                                          color: Color(0xFFB2572B),
                                        ))
                                  ],
                                )
                              ],
                            ),
                            TextButton(
                              onPressed: logout,
                              style: ElevatedButton.styleFrom(
                                textStyle: const TextStyle(
                                    color: Color(0xFFB2572B),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18),
                                padding: const EdgeInsets.all(0),
                              ),
                              child: const Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 50,
                                    child: Icon(
                                      Icons.logout_rounded,
                                      color: Color(0xFFB2572B),
                                    ),
                                  ),
                                  Text(
                                    "Đăng xuất tài khoản",
                                    style: TextStyle(
                                        color: Color(0xFFB2572B), fontSize: 18),
                                  ),
                                ],
                              ),
                            )
                          ])
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                            Column(children: <Widget>[
                              const SizedBox(
                                height: 30,
                              ),
                              MaterialButton(
                                minWidth: double.infinity,
                                height: 60,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignInScreen()));
                                },
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                    borderRadius: BorderRadius.circular(50)),
                                child: Text(
                                  "Đăng nhập",
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              MaterialButton(
                                minWidth: double.infinity,
                                height: 60,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpScreen()));
                                },
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                    borderRadius: BorderRadius.circular(50)),
                                child: Text(
                                  "Đăng ký",
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                              ),
                            ]),
                          ])),
          );
        }));
  }
}
