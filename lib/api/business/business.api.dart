import 'package:enam_dua_teknologi/helper/api_handler.dart';
import 'package:enam_dua_teknologi/model/%20business/business.model.dart';
import 'package:enam_dua_teknologi/model/%20business/detail.model.dart';
import 'package:enam_dua_teknologi/model/%20business/review.model.dart';
import 'package:enam_dua_teknologi/utils/const.dart';
import 'package:flutter/material.dart';

class ApiBusiness {
  String url(String path) => baseUrl + path;

  Future<BusinessModel> getBusiness(queryParameters) async {
    try {
      final res = await Api().handler(
          method: 'GET',
          url: url('businesses/search'),
          queryParameters: queryParameters);

      if (res.statusCode == 200) {
        return BusinessModel.fromJson(res.data);
      }

      return BusinessModel();
    } catch (e) {
      return BusinessModel();
    }
  }

  Future<DetailBusinessModel> getDetailBusiness(id) async {
    try {
      final res =
          await Api().handler(method: 'GET', url: url('businesses/$id'));

      // debugPrint(res.data.toString());
      // debugPrint(res.statusCode.toString());
      if (res.statusCode == 200) {
        return DetailBusinessModel.fromJson(res.data);
      }

      return DetailBusinessModel();
    } catch (e) {
      return DetailBusinessModel();
    }
  }

  Future<ReviewBusinessModel> getReviewBusiness(id) async {
    try {
      final res = await Api().handler(
          method: 'GET',
          url: url('businesses/$id/reviews?limit=20&sort_by=yelp_sort'));

      // debugPrint('test');
      debugPrint(res.data.toString());
      // debugPrint(res.statusCode.toString());
      if (res.statusCode == 200) {
        return ReviewBusinessModel.fromJson(res.data);
      }

      return ReviewBusinessModel();
    } catch (e) {
      return ReviewBusinessModel();
    }
  }
}
