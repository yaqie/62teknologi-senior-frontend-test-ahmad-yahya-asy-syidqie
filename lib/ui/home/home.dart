import 'dart:async';

import 'package:enam_dua_teknologi/components/business/item_business.dart';
import 'package:enam_dua_teknologi/components/shimmer.dart';
import 'package:enam_dua_teknologi/provider/business/business.provider.dart';
import 'package:enam_dua_teknologi/ui/detail/detail.dart';
import 'package:enam_dua_teknologi/ui/home/filter.dart';
import 'package:enam_dua_teknologi/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchTextController = TextEditingController(text: '');
  var scrollController = ScrollController();
  Timer? debounce;

  onSearchChanged(String query) {
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () async {
      var provBusiness = Provider.of<ProviderBusiness>(context, listen: false);
      await provBusiness.setTerm(query);
      await provBusiness.getListBusiness(reset: true);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var provBusiness = Provider.of<ProviderBusiness>(context, listen: false);

      await provBusiness.getListBusiness();
      scrollController.addListener(() async {
        if (scrollController.offset >=
                scrollController.position.maxScrollExtent &&
            !scrollController.position.outOfRange) {
          await provBusiness.getListBusiness();
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderBusiness>(
        builder: (BuildContext context, vBusiness, Widget? child) {
      return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print('test');
            showFilter(context);
            // Add your onPressed code here!
          },
          backgroundColor: primaryColor,
          child: const Icon(Icons.filter_list),
        ),
        body: CustomScrollView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                backgroundColor: primaryColor,
                elevation: 0,
                floating: true,
                pinned: true,
                snap: false,
                centerTitle: false,
                title: const Text(
                  'Explore Business',
                  style: TextStyle(color: Colors.white),
                ),
                bottom: AppBar(
                  toolbarHeight: 80,
                  elevation: 0,
                  backgroundColor: primaryColor,
                  title: Container(
                    decoration: BoxDecoration(
                      color: const Color(0XFFF1F1F1),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: TextFormField(
                      onChanged: (v) {
                        onSearchChanged(v);
                      },
                      controller: searchTextController,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: const InputDecoration(
                        // hintStyle: TextStyle(fontSize: 17),
                        hintText: 'Search Business',
                        suffixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                vBusiness.isLoading
                    ? Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: CustomShimmer(),
                      )
                    : SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...vBusiness.resBusiness!.businesses!
                                  .map((e) => Builder(builder: (context) {
                                        int index = vBusiness
                                            .resBusiness!.businesses!
                                            .indexOf(e);
                                        return InkWell(
                                          onTap: () {
                                            Get.to(DetailBusiness(id: e.id));
                                          },
                                          child: ItemBusiness(
                                            isLast: (index + 1) ==
                                                    vBusiness.resBusiness!
                                                        .businesses!.length
                                                ? true
                                                : false,
                                            rating: e.rating.toString(),
                                            image: e.imageUrl.toString(),
                                            name: e.name,
                                            price: e.price,
                                            category: e.categories
                                                ?.map((e2) => e2.title)
                                                .toString(),
                                            distance: e.distance.toString(),
                                          ),
                                        );
                                      })),
                              if (vBusiness.isLoadingNextPage)
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: CustomShimmer(),
                                )
                            ],
                          ),
                        ),
                      )
              ]))
            ]),
      );
    });
  }
}
