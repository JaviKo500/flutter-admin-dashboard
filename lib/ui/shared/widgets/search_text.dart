import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';
import 'package:flutter/material.dart';


class SearchText extends StatelessWidget {
  const SearchText ({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40 ,
      decoration: buildDecoration(),
      child: TextField(
        decoration: CustomInputs.searchInputDecoration(hint: 'Search' , icon: Icons.search_outlined),
      )
    );
  }

  BoxDecoration buildDecoration() => BoxDecoration( 
    borderRadius: BorderRadius.circular(10),
    color: Colors.grey.withOpacity(0.1)
  );
}