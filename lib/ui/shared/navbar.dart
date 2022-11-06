import 'package:admin_dashboard/providers/side_menu_provider.dart';
import 'package:admin_dashboard/ui/shared/widgets/navbar_avatar.dart';
import 'package:admin_dashboard/ui/shared/widgets/notification_indicator.dart';
import 'package:admin_dashboard/ui/shared/widgets/search_text.dart';
import 'package:flutter/material.dart';


class Navbar extends StatelessWidget {
  const Navbar ({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: 50,
      decoration: buildDecoration(),
      child: Row(
        children: [
          if( size.width <= 700) 
            ...[
              IconButton(
                onPressed: () {
                  SideMenuProvider.openMenu();    
                }, 
                icon: const Icon(Icons.menu_outlined)
              ),
            ],
          const SizedBox(width: 5,),

          // Search input
          if( size.width > 400)
            ConstrainedBox(
              constraints: const BoxConstraints( maxWidth:  250 ),
              child: const SearchText(),
            ),
          const Spacer(),
          const NotificationIndicator(),
          const SizedBox(width: 25),
          const NavbarAvatar(),
          const SizedBox(width: 10),
        ],
      )
    );
  }

  BoxDecoration buildDecoration() => const BoxDecoration(
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 5
      )
    ]
  );
}