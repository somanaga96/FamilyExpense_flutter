import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/global/global.dart';

class Business extends StatefulWidget {
  const Business({Key? key}) : super(key: key);

  @override
  State<Business> createState() => _BusinessState();
}

class _BusinessState extends State<Business> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<Global>(context, listen: false)
          .updateCurrentPageTitle('Business');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("Business"),
    );
  }
}
