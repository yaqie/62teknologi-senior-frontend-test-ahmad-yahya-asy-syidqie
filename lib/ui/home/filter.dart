import 'package:enam_dua_teknologi/provider/business/business.provider.dart';
import 'package:enam_dua_teknologi/ui/home/filter_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

showFilter(context) {
  showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext bc) {
        return Consumer<ProviderBusiness>(
            builder: (BuildContext context, vTabBar, Widget? child) {
          return Container(
            // color: PickColor.formFillColor(context),
            child: Wrap(
              children: const <Widget>[
                FilterPage()
                // if (vTabBar.pageDocument == 0) const FilterPeraturan(),
                // if (vTabBar.pageDocument == 1) const FilterMonografi()
                // Text(vTabBar.pageDocument.toString()),
              ],
            ),
          );
        });
      }).whenComplete(() {});
}
