

import 'package:admin_dashboard/models/categorie.dart';
import 'package:admin_dashboard/providers/categories_provider.dart';
import 'package:admin_dashboard/ui/modals/category_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesDataSource extends DataTableSource {
  final List< Categoria > categories;
  final BuildContext context;

  CategoriesDataSource(this.categories, this.context);
  @override
  DataRow? getRow(int index) {
    final category = categories[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(
          Text(category.id),
        ),
        DataCell(
          Text(category.nombre),
        ),
        DataCell(
          Text(category.usuario.nombre),
        ),
        DataCell(
          Row(
            children: [
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context, 
                    builder: ( _ ) => CategoryModal( category:  category,),
                  );
                }, 
                icon: const Icon(Icons.edit_outlined),
              ),
              IconButton(
                onPressed: () {
                  final dialog = AlertDialog(
                    title: const Text('Are you sure Delete?'),
                    content: Text('Delete. ${category.nombre}'),
                    
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        }, 
                        child: const Text('No')
                      ),
                      TextButton(
                        onPressed: () async {
                          await Provider.of<CategoriesProvider>(context, listen: false).deleteCategory(category.id);
                          Navigator.of(context).pop();
                        }, 
                        child: const Text('yes, delete')
                      ),
                    ],
                  );
                  showDialog(
                    context: context, 
                    builder: ( _ ) => dialog,
                  );
                }, 
                icon: Icon(Icons.delete_outline, color: Colors.red.withOpacity(0.8),),
              )
            ],
          ),
        ),
      ]
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => categories.length;

  @override
  int get selectedRowCount => 0;
  
}