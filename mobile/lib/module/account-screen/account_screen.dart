import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return AccountScreenState();
  }
}

class AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return const Text('Account Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold));
  }
}
