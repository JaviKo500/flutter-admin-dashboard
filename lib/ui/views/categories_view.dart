import 'package:admin_dashboard/ui/modals/category_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/datatables/categories_datasource.dart';

import 'package:admin_dashboard/providers/categories_provider.dart';

import 'package:admin_dashboard/ui/buttons/custom_icon_button.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';


class CategoriesView extends StatefulWidget {
  const CategoriesView ({Key? key}) : super(key: key);

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  @override
  void initState() {
    super.initState();
    Provider.of<CategoriesProvider>(context, listen: false).getCategories();
  }
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<CategoriesProvider>(context).categories;
    return Container(
      padding: const EdgeInsets.symmetric( horizontal: 20,  vertical: 10 ),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text(
            'Categories',
            style: CustomLabels.h1
          ),
          const SizedBox(height: 10,),
          PaginatedDataTable(
            columns: const [
              DataColumn(
                label: Text('ID'),
              ),
              DataColumn(
                label: Text('Categorie')
              ),
              DataColumn(
                label: Text('Create by')
              ),
              DataColumn(
                label: Text('Actions')
              ),
            ],
            source: CategoriesDataSource( categories, context ),
            header: const Text('List all categories available', maxLines: 2,),
            onRowsPerPageChanged: (value) => setState(() => _rowsPerPage = value ?? 10),
            rowsPerPage: _rowsPerPage,
            actions: [
              CustomIconButton(
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context, 
                    builder: ( _ ) => const CategoryModal(),
                  );
                }, 
                text: 'Create', 
                icon: Icons.add_outlined
              )
            ],
          ),
        ],
      ),
    );
  }
}