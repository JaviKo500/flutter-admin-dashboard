import 'package:admin_dashboard/models/categorie.dart';
import 'package:admin_dashboard/providers/categories_provider.dart';
import 'package:admin_dashboard/services/notification_service.dart';
import 'package:admin_dashboard/ui/buttons/custom_outline_button.dart';
import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CategoryModal extends StatefulWidget {
  final Categoria? category;
  const CategoryModal ({Key? key, this.category}) : super(key: key);

  @override
  State<CategoryModal> createState() => _CategoryModalState();
}

class _CategoryModalState extends State<CategoryModal> {

  String name = '';
  String? id;

  @override
  void initState() {
    super.initState();
    id = widget.category?.id;
    name = widget.category?.nombre ?? '';
  }
  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoriesProvider>(context, listen: false);
    return Container(
      padding: const EdgeInsets.all(20),
      height: 500,
      width: 300,
      decoration: buildBoxDecoration(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text( widget.category?.nombre ?? 'New category', style: CustomLabels.h1.copyWith( color: Colors.white,),),
              IconButton(
                onPressed: () => Navigator.of(context).pop(), 
                icon: const Icon( Icons.close , color: Colors.white,)
              )
            ],
          ),
          Divider( color: Colors.white.withOpacity(0.3),),
          const SizedBox(height: 20,),
          TextFormField(
            initialValue: widget.category?.nombre ?? '',
            onChanged: (value) => name = value,
            decoration: CustomInputs.loginInputDecoration(
              hint: 'Category name', 
              label: 'Category', 
              icon: Icons.new_releases_outlined
            ),
            style: const TextStyle( color: Colors.white,),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            child: CustomOutlineButton(
              onPressed: () async {
                if( name.isEmpty ) return;
                try {
                  if ( id ==  null ) {
                    await categoryProvider.newCategory(name);
                    NotificationService.showSnackbarOk('$name created');
                  } else {
                    await categoryProvider.updateCategory(id!, name);
                    NotificationService.showSnackbarOk('$name updated');
                  }
                  Navigator.of( context ).pop();
                } catch (e) {
                  Navigator.of( context ).pop();
                  NotificationService.showSnackbarError('$e');
                }
              }, 
              text: 'Save',
              color: Colors.white,
            ),
          )
        ],
      )
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20) ),
    color: Color(0xff0F2041),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
      )
    ]
  );
}