import 'package:admin_dashboard/ui/shared/widgets/custom_menu_item.dart';
import 'package:admin_dashboard/ui/shared/widgets/logo.dart';
import 'package:admin_dashboard/ui/shared/widgets/text_separator.dart';
import 'package:flutter/material.dart';


class Sidebar extends StatelessWidget {
  const Sidebar ({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: double.infinity,
      decoration: buildDecoration(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const Logo(),
          const SizedBox(height: 50,),
          const TextSeparator( text: 'Main'),
          CustomMenuItem(
            text: 'Dashboard',
            icon: Icons.compass_calibration_outlined,
            onPressed: () => print('Dashboard')
          )
        ],
      ),
    );
  }

  BoxDecoration buildDecoration() {
    return const BoxDecoration(
      gradient: LinearGradient(
        colors:  [
          Color(0xff092044),
          Color(0xff092043),
        ],
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
           blurRadius: 10
        )
      ]
    );
  }
}