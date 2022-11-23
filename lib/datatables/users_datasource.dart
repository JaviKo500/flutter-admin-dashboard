

import 'package:admin_dashboard/models/user.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:flutter/material.dart';

class UsersDataSource extends DataTableSource {
  UsersDataSource( this.users );
  List< Usuario > users;
  @override
  DataRow? getRow(int index) {
    final Usuario user = users[index];
    final image = user.img == null 
      ? const Image(image: AssetImage( 'no-image.jpg' ), width: 35, height: 35, )
      : FadeInImage.assetNetwork(placeholder: 'loader.gif', image: user.img!, fit: BoxFit.cover, width: 35, height: 35,);
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(
          ClipOval(
            child: image,
          )
        ),
        DataCell(
          Text( user.nombre )
        ),
        DataCell(
          Text( user.correo )
        ),
        DataCell(
          Text( user.uid )
        ),
        DataCell(
          IconButton(
            onPressed: () {
               NavigationService.navigateTo('dashboard/users/${user.uid}');
            }, 
            icon: const Icon(Icons.edit_outlined),
          )
        ),
      ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => users.length;

  @override
  int get selectedRowCount => 0;
  
  
}