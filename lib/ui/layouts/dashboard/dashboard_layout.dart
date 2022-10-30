import 'package:admin_dashboard/ui/shared/sidebar.dart';
import 'package:flutter/material.dart';


class DashboardLayout extends StatelessWidget {
  final Widget child;
  const DashboardLayout ({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color(0xffEDF1F2),
      body: Row(
        children: [
          const Sidebar(),
          // * main view
          Expanded(
            child: child
          )
        ],
      )
    );
  }
}