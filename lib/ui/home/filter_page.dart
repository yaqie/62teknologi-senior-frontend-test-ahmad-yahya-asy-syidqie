import 'package:dotted_line/dotted_line.dart';
import 'package:enam_dua_teknologi/components/addspace.dart';
import 'package:enam_dua_teknologi/components/business/selected_button.dart';
import 'package:enam_dua_teknologi/components/modal/title.dart';
import 'package:enam_dua_teknologi/provider/business/business.provider.dart';
import 'package:enam_dua_teknologi/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderBusiness>(
        builder: (BuildContext context, vBusiness, Widget? child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleModal(
            title: 'Filter Business',
          ),
          // AddHeight(20),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Sort By',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                AddHeight(10),
                Wrap(
                  children: [
                    SelectedButton(
                      isActive: vBusiness.sortBy == 'Best Match' ? true : false,
                      callback: () {
                        vBusiness.setSortBy('Best Match');
                      },
                      name: 'Best Match',
                    ),
                    SelectedButton(
                      isActive: vBusiness.sortBy == 'Rating' ? true : false,
                      callback: () {
                        vBusiness.setSortBy('Rating');
                      },
                      name: 'Rating',
                    ),
                    SelectedButton(
                      isActive:
                          vBusiness.sortBy == 'Review Count' ? true : false,
                      callback: () {
                        vBusiness.setSortBy('Review Count');
                      },
                      name: 'Review Count',
                    ),
                    SelectedButton(
                      isActive: vBusiness.sortBy == 'Distance' ? true : false,
                      callback: () {
                        vBusiness.setSortBy('Distance');
                      },
                      name: 'Distance',
                    ),
                  ],
                ),
                AddHeight(10),
                const DottedLine(
                  dashColor: Colors.grey,
                ),
                AddHeight(10),
                const Text(
                  'Price',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                AddHeight(10),
                Wrap(
                  children: [
                    SelectedButton(
                        isActive: vBusiness.price == '1' ? true : false,
                        callback: () {
                          vBusiness.setPrice('1');
                        },
                        name: '\$'),
                    SelectedButton(
                        isActive: vBusiness.price == '2' ? true : false,
                        callback: () {
                          vBusiness.setPrice('2');
                        },
                        name: '\$\$'),
                    SelectedButton(
                        isActive: vBusiness.price == '3' ? true : false,
                        callback: () {
                          vBusiness.setPrice('3');
                        },
                        name: '\$\$\$'),
                    SelectedButton(
                        isActive: vBusiness.price == '4' ? true : false,
                        callback: () {
                          vBusiness.setPrice('4');
                        },
                        name: '\$\$\$\$'),
                  ],
                ),
                AddHeight(10),
                const DottedLine(
                  dashColor: Colors.grey,
                ),
                AddHeight(10),
                const Text(
                  'Other',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                AddHeight(10),
                Wrap(
                  children: [
                    SelectedButton(
                        isActive: vBusiness.openNow == '' ? false : true,
                        callback: () {
                          if (vBusiness.openNow == '') {
                            return vBusiness.setOpenNow('true');
                          }
                          if (vBusiness.openNow == 'true') {
                            return vBusiness.setOpenNow('');
                          }
                          // if (vBusiness.openNow == 'true') {
                          //   vBusiness.setOpenNow('false');
                          // }
                          // print(vBusiness.openNow);
                        },
                        name: 'Open Now'),
                  ],
                ),
                AddHeight(20),
                Row(children: [
                  Expanded(
                    child: MaterialButton(
                      elevation: 0,
                      color: greyColor,
                      textColor: Colors.white,
                      onPressed: () async {
                        await vBusiness.reset();
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Text(
                          'Atur Ulang',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  AddWidth(20),
                  Expanded(
                    child: MaterialButton(
                      elevation: 0,
                      color: primaryColor,
                      textColor: Colors.white,
                      onPressed: () {
                        vBusiness.getListBusiness(reset: true);
                        Navigator.pop(context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Text(
                          'Terapkan Filter',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ],
            ),
          )
        ],
      );
    });
  }
}
