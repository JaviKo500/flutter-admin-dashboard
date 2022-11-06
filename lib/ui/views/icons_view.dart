import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';

import '../cards/white_card.dart';

class IconsView extends StatelessWidget {
  const IconsView ({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric( horizontal: 20,  vertical: 10 ),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text(
            'Icons',
            style: CustomLabels.h1
          ),
          const SizedBox(height: 10,),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            direction: Axis.horizontal,
            children: const [
              WhiteCard(
                title: 'ac_unit_outlined',
                width: 170,
                child: Center(
                  child: Icon(Icons.ac_unit_outlined),
                )
              ),
              WhiteCard(
                title: 'access_alarm_sharp',
                width: 170,
                child: Center(
                  child: Icon(Icons.access_alarm_sharp),
                )
              ),
              WhiteCard(
                title: 'all_inbox_outlined',
                width: 170,
                child: Center(
                  child: Icon(Icons.all_inbox_outlined),
                )
              ),
              WhiteCard(
                title: 'delivery_dining_outlined',
                width: 170,
                child: Center(
                  child: Icon(Icons.delivery_dining_outlined),
                )
              ),
              WhiteCard(
                title: 'one_x_mobiledata_outlined',
                width: 170,
                child: Center(
                  child: Icon(Icons.one_x_mobiledata_outlined),
                )
              ),
              WhiteCard(
                title: 'zoom_in_map_outlined',
                width: 170,
                child: Center(
                  child: Icon(Icons.zoom_in_map_outlined),
                )
              ),
            ],
          )
        ],
      ),
    );
  }
}