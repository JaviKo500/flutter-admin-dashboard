

import 'package:flutter/material.dart';

class UsersDataSource extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(
          Text( index.toString() )
        ),
        DataCell(
          Text( index.toString() )
        ),
        DataCell(
          Text( index.toString() )
        ),
        DataCell(
          Text( index.toString() )
        ),
        DataCell(
          Text( index.toString() )
        ),
      ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 100;

  @override
  int get selectedRowCount => 0;
  
  
}