import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard/providers/side_menu_provider.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/ui/shared/widgets/custom_menu_item.dart';
import 'package:admin_dashboard/ui/shared/widgets/logo.dart';
import 'package:admin_dashboard/ui/shared/widgets/text_separator.dart';
import 'package:provider/provider.dart';


class Sidebar extends StatelessWidget {
  const Sidebar ({Key? key}) : super(key: key);

  void navigateTo(String routeName) {
    NavigationService.replaceTo( routeName );
    SideMenuProvider.closeMenu();
  }
  @override
  Widget build(BuildContext context) {
    final sideMenuBar = Provider.of<SideMenuProvider>( context );
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
            isActive: sideMenuBar.currentPage == CustomFluroRouter.dashboardRoute, 
            text: 'Dashboard', 
            icon: Icons.compass_calibration_outlined, 
            onPressed: () => navigateTo( CustomFluroRouter.dashboardRoute)
          ),
          CustomMenuItem( 
            // isActive: sideMenuBar.currentPage == '', 
            text: 'Orders',    
            icon: Icons.shopping_cart_outlined, 
            onPressed: () => navigateTo( CustomFluroRouter.dashboardRoute)
          ),
          CustomMenuItem( 
            // isActive: sideMenuBar.currentPage == '', 
            text: 'Analytics', 
            icon: Icons.show_chart_outlined  , 
            onPressed: () => navigateTo( CustomFluroRouter.dashboardRoute)
          ),
          CustomMenuItem( 
            isActive: sideMenuBar.currentPage == CustomFluroRouter.categoriesRoute,
            text: 'Categories', 
            icon: Icons.layers_outlined, 
            onPressed: () => navigateTo( CustomFluroRouter.categoriesRoute)
          ),
          CustomMenuItem( 
            // isActive: sideMenuBar.currentPage == '', 
            text: 'Products', 
            icon: Icons.dashboard_outlined, 
            onPressed: () => navigateTo( CustomFluroRouter.dashboardRoute)
          ),
          CustomMenuItem( 
            // isActive: sideMenuBar.currentPage == '', 
            text: 'Discount', 
            icon: Icons.attach_money_outlined, 
            onPressed: () => navigateTo( CustomFluroRouter.dashboardRoute)
          ),
          CustomMenuItem( 
            isActive: sideMenuBar.currentPage == CustomFluroRouter.usersRoute, 
            text: 'Customers', 
            icon: Icons.people_alt_outlined, 
            onPressed: () => navigateTo( CustomFluroRouter.usersRoute)
          ),
          
          const SizedBox(height: 30,),
          const TextSeparator( text: 'UI Elements'),
          CustomMenuItem( 
            isActive: sideMenuBar.currentPage == CustomFluroRouter.iconsRoute,
            text: 'Icons', 
            icon: Icons.list_alt_outlined  ,
            onPressed: () => navigateTo( CustomFluroRouter.iconsRoute )
          ),
          CustomMenuItem( 
            text: 'Marketing', 
            icon: Icons.mark_email_read_outlined, 
            onPressed: () => navigateTo( CustomFluroRouter.dashboardRoute)
          ),
          CustomMenuItem( 
            text: 'Camping', 
            icon: Icons.note_add_outlined, 
            onPressed: () => navigateTo( CustomFluroRouter.dashboardRoute)
          ),
          CustomMenuItem(
            isActive: sideMenuBar.currentPage == CustomFluroRouter.blankRoute, 
            text: 'Blank', 
            icon: Icons.post_add_outlined, 
            onPressed: () => navigateTo( CustomFluroRouter.blankRoute)
          ),
          const SizedBox(height: 50,),
          const TextSeparator( text: 'Exit'),
          CustomMenuItem( 
            text: 'Logout', 
            icon: Icons.exit_to_app_outlined, 
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
            }
          ),
           
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