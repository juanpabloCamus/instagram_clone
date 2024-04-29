import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/utils/globals.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget mobileScreenLayout;
  final Widget webScreenLayout;
  const ResponsiveLayout({
    Key? key,
    required this.mobileScreenLayout,
    required this.webScreenLayout,
  }) : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    final UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > webScreenSize) {
            // Web Screen
            return widget.webScreenLayout;
          }
          // Mobile Screen
          return widget.mobileScreenLayout;
        },
      ),
    );
  }
}
