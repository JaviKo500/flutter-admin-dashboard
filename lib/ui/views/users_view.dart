import 'package:admin_dashboard/datatables/users_datasource.dart';
import 'package:admin_dashboard/providers/users_provider.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../cards/white_card.dart';

class UsersView extends StatelessWidget {
  const UsersView ({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final usersProvider = Provider.of<UsersProvider>(context);
    final usersDataSource = UsersDataSource( usersProvider.users );
    return Container(
      padding: const EdgeInsets.symmetric( horizontal: 20,  vertical: 10 ),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text(
            'Users View',
            style: CustomLabels.h1
          ),
          const SizedBox(height: 10,),
          PaginatedDataTable(
            sortAscending: usersProvider.ascending,
            sortColumnIndex: usersProvider.sortColumIndex,
            columns:  [
                const DataColumn(label: Text('Avatar')),
                DataColumn(
                  label: Text('Name'),
                  onSort: (columnIndex, _ ) {
                    usersProvider.sortColumIndex = columnIndex;
                    usersProvider.sort< String >((user) =>  user.nombre);
                  },
                ),
                DataColumn(
                  label: Text('Email'),
                  onSort: (columnIndex, _ ) {
                    usersProvider.sortColumIndex = columnIndex;
                    usersProvider.sort((user) =>  user.correo);
                  },
                ),
                const DataColumn(label: Text('UID')),
                const DataColumn(label: Text('Actions'))
            ], 
            source: usersDataSource,
            onPageChanged: (value) {
              if (kDebugMode) {
                print(value);
              }
            },
          )
        ],
      ),
    );
  }
}