import 'package:dotted_line/dotted_line.dart';
import 'package:enam_dua_teknologi/components/addspace.dart';
import 'package:enam_dua_teknologi/components/image_not_found.dart';
import 'package:enam_dua_teknologi/utils/colors.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

class ItemBusiness extends StatelessWidget {
  String? image, name, price, category, distance, rating;
  bool? isLast = false;
  ItemBusiness({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.category,
    required this.distance,
    required this.rating,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast! ? 0 : 20.0),
      child: Container(
          color: Colors.white,
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      FancyShimmerImage(
                        width: 90,
                        height: 90,
                        imageUrl: image!,
                        boxFit: BoxFit.cover,
                        errorWidget: const ImageNotFoundWidget(),
                      ),
                      Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                              color: primaryColor,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.star_rate_rounded,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                  AddWidth(5),
                                  Text(
                                    rating!,
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                ],
                              )))
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(name!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 18)),
                  AddHeight(10),
                  Row(
                    children: [
                      if (price != null)
                        Text(price!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(color: Colors.grey)),
                      if (price != null) AddWidth(5),
                      if (price != null)
                        const Text('·', style: TextStyle(color: Colors.grey)),
                      if (price != null) AddWidth(5),
                      Expanded(
                        child: Text(
                            category!.substring(1, category!.length - 1),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(color: Colors.grey)),
                      ),
                    ],
                  ),
                  AddHeight(10),
                  const DottedLine(
                    dashColor: Colors.grey,
                  ),
                  AddHeight(10),
                  Text(
                      "${(double.parse(distance!) / 1000).toStringAsFixed(2)} Km",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(fontWeight: FontWeight.w400)),
                ],
              )),
            ],
          )),
    );
  }
}
