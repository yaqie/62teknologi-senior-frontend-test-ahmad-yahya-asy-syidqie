import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:enam_dua_teknologi/components/addspace.dart';
import 'package:enam_dua_teknologi/components/border_radius.dart';
import 'package:enam_dua_teknologi/components/image_not_found.dart';
import 'package:enam_dua_teknologi/components/shimmer.dart';
import 'package:enam_dua_teknologi/provider/business/business.provider.dart';
import 'package:enam_dua_teknologi/utils/colors.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailBusiness extends StatefulWidget {
  String? id;
  DetailBusiness({super.key, required this.id});

  @override
  State<DetailBusiness> createState() => _DetailBusinessState();
}

class _DetailBusinessState extends State<DetailBusiness> {
  final CarouselController _controller = CarouselController();
  int _current = 0;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var provBusiness = Provider.of<ProviderBusiness>(context, listen: false);
      await provBusiness.getDetailBusiness(widget.id);
      await provBusiness.getReviewBusiness(widget.id);
      debugPrint(widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderBusiness>(
        builder: (BuildContext context, vBusiness, Widget? child) {
      return Scaffold(
          appBar: AppBar(
              backgroundColor: primaryColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded,
                    color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: const Text(
                'Detail Business',
                style: TextStyle(color: Colors.white),
              )),
          bottomNavigationBar: vBusiness.isLoadingDetail
              ? const SizedBox()
              : Material(
                  elevation: 20,
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: MaterialButton(
                          elevation: 0,
                          color: primaryColor,
                          textColor: Colors.white,
                          onPressed: () async {
                            final Uri url = Uri.parse(
                                'http://www.google.com/maps/place/${vBusiness.resDetailBusiness!.coordinates!.latitude},${vBusiness.resDetailBusiness!.coordinates!.longitude}');
                            if (!await launchUrl(url,
                                mode: LaunchMode.externalApplication)) {
                              throw 'Could not launch $url';
                            }
                          },
                          child: const Text(
                            'See maps',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
          body: SingleChildScrollView(
            child: vBusiness.isLoadingDetail
                ? Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CustomShimmer(),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: vBusiness.resDetailBusiness!.photos!.isNotEmpty
                            ? Stack(
                                children: [
                                  CarouselSlider(
                                      options: CarouselOptions(
                                        onPageChanged: (index, reason) {
                                          setState(() {
                                            _current = index;
                                          });
                                        },
                                        height: double.infinity,
                                        autoPlay: true,
                                        viewportFraction: 1,
                                      ),
                                      items: vBusiness
                                          .resDetailBusiness!.photos!
                                          .map((i) {
                                        return Builder(
                                          builder: (BuildContext context) {
                                            return FancyShimmerImage(
                                              imageUrl: i.toString(),
                                              width: double.infinity,
                                              boxFit: BoxFit.cover,
                                              errorWidget:
                                                  const ImageNotFoundWidget(),
                                            );
                                          },
                                        );
                                      }).toList()),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: vBusiness
                                          .resDetailBusiness!.photos!
                                          .asMap()
                                          .entries
                                          .map((entry) {
                                        return GestureDetector(
                                          onTap: () => _controller
                                              .animateToPage(entry.key),
                                          child: Container(
                                            width: 12.0,
                                            height: 12.0,
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 8.0, horizontal: 4.0),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: (Theme.of(context)
                                                                .brightness ==
                                                            Brightness.dark
                                                        ? Colors.white
                                                        : Colors.white)
                                                    .withOpacity(
                                                        _current == entry.key
                                                            ? 0.9
                                                            : 0.4)),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  )
                                ],
                              )
                            : FancyShimmerImage(
                                imageUrl: vBusiness.resDetailBusiness!.imageUrl
                                    .toString(),
                                width: double.infinity,
                                boxFit: BoxFit.cover,
                                errorWidget: const ImageNotFoundWidget(),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(vBusiness.resDetailBusiness!.name.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            AddHeight(15),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: RatingBar.builder(
                                    itemSize: 25,
                                    initialRating:
                                        vBusiness.resDetailBusiness!.rating!,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding:
                                        const EdgeInsets.only(right: 5.0),
                                    itemBuilder: (context, _) => Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: const Icon(
                                        Icons.star,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onRatingUpdate: (rating) {
                                      // print(rating);
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                      '${vBusiness.resDetailBusiness!.reviewCount} Reviews'),
                                )
                              ],
                            ),
                            AddHeight(15),
                            Row(
                              children: [
                                vBusiness.resDetailBusiness!.isClaimed!
                                    ? Row(
                                        children: [
                                          Icon(
                                            Icons.verified,
                                            color: blueColor,
                                            size: 15,
                                          ),
                                          AddWidth(5),
                                          Text('Claimed',
                                              style:
                                                  TextStyle(color: blueColor))
                                        ],
                                      )
                                    : const Text('Unclaimed'),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Text('·',
                                      style: TextStyle(color: Colors.grey)),
                                ),
                                Text(vBusiness.resDetailBusiness!.price!,
                                    style: const TextStyle(color: Colors.grey)),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Text('·',
                                      style: TextStyle(color: Colors.grey)),
                                ),
                                Expanded(
                                  child: Text(
                                      vBusiness.resDetailBusiness!.categories!
                                          .map((e) => e.title)
                                          .toString()
                                          .substring(
                                              1,
                                              vBusiness.resDetailBusiness!
                                                      .categories!
                                                      .map((e) => e.title)
                                                      .toString()
                                                      .length -
                                                  1),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          const TextStyle(color: Colors.grey)),
                                ),
                              ],
                            ),
                            AddHeight(15),
                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: primaryColor,
                                  size: 15,
                                ),
                                AddWidth(5),
                                Text(vBusiness.resDetailBusiness!.displayPhone
                                    .toString()),
                              ],
                            ),
                            AddHeight(15),
                            Row(
                              children: [
                                Text(
                                  vBusiness.resDetailBusiness!.isClosed!
                                      ? "Closed"
                                      : "Open",
                                  style: TextStyle(
                                      color:
                                          vBusiness.resDetailBusiness!.isClosed!
                                              ? Colors.red
                                              : Colors.green),
                                ),
                                AddWidth(5),
                                vBusiness.resDetailBusiness!.hours!.isNotEmpty
                                    ? Row(
                                        children: [
                                          Text(
                                            '${vBusiness.resDetailBusiness!.hours!.first.open!.first.start!.substring(0, 2)}:${vBusiness.resDetailBusiness!.hours!.first.open!.first.start!.substring(2, 4)} - ',
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            '${vBusiness.resDetailBusiness!.hours!.first.open!.first.end!.substring(0, 2)}:${vBusiness.resDetailBusiness!.hours!.first.open!.first.end!.substring(2, 4)}',
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                        ],
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                            AddHeight(20),
                            const DottedLine(
                              dashColor: Colors.grey,
                            ),
                            AddHeight(20),
                            const Text(
                              'Reviews',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            AddHeight(20),
                            vBusiness.isLoadingReview
                                ? CustomShimmer()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ...vBusiness.resReviewBusiness!.reviews!
                                          .map((e) => Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Corner(
                                                          corner: 999,
                                                          child:
                                                              FancyShimmerImage(
                                                            imageUrl: e.user
                                                                    ?.imageUrl ??
                                                                '',
                                                            width: 50,
                                                            height: 50,
                                                            boxFit:
                                                                BoxFit.cover,
                                                            errorWidget:
                                                                const ImageNotFoundWidget(),
                                                          ),
                                                        ),
                                                        AddWidth(10),
                                                        Text(e.user!.name
                                                            .toString())
                                                      ],
                                                    ),
                                                    AddHeight(10),
                                                    RatingBar.builder(
                                                      itemSize: 25,
                                                      initialRating:
                                                          double.parse(e.rating
                                                              .toString()),
                                                      minRating: 1,
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemPadding:
                                                          const EdgeInsets.only(
                                                              right: 5.0),
                                                      itemBuilder:
                                                          (context, _) =>
                                                              Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        decoration: BoxDecoration(
                                                            color: Colors.red,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: const Icon(
                                                          Icons.star,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      onRatingUpdate: (rating) {
                                                        // print(rating);
                                                      },
                                                    ),
                                                    AddHeight(10),
                                                    Text(e.text.toString()),
                                                  ],
                                                ),
                                              ))
                                    ],
                                  )
                          ],
                        ),
                      )
                    ],
                  ),
          ));
    });
  }
}
