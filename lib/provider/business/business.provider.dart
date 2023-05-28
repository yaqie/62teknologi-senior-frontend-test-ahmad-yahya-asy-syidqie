import 'package:enam_dua_teknologi/api/business/business.api.dart';
import 'package:enam_dua_teknologi/model/%20business/business.model.dart';
import 'package:enam_dua_teknologi/model/%20business/detail.model.dart';
import 'package:enam_dua_teknologi/model/%20business/review.model.dart';
import 'package:flutter/material.dart';

class ProviderBusiness with ChangeNotifier {
  String sortBy = 'Best Match';
  String openNow = '';
  String price = '';
  String term = '';
  bool isLoading = true;
  bool isLoadingReview = true;
  bool isLoadingDetail = true;
  BusinessModel? resBusiness;
  DetailBusinessModel? resDetailBusiness;
  ReviewBusinessModel? resReviewBusiness;
  int offset = 0;
  int limit = 20;
  bool isLoadingNextPage = false;

  reset() {
    sortBy = 'Best Match';
    openNow = '';
    price = '';
    notifyListeners();
  }

  setTerm(data) async {
    term = data;
    notifyListeners();
  }

  setSortBy(data) async {
    sortBy = data;
    notifyListeners();
  }

  setPrice(data) async {
    price = data;
    notifyListeners();
  }

  setOpenNow(data) async {
    openNow = data;
    notifyListeners();
  }

  getDetailBusiness(id) async {
    isLoadingDetail = true;
    notifyListeners();
    // var res = await ApiBusiness().getDetailBusiness(id);
    resDetailBusiness = await ApiBusiness().getDetailBusiness(id);
    isLoadingDetail = false;
    notifyListeners();
  }

  getReviewBusiness(id) async {
    isLoadingReview = true;
    notifyListeners();
    // var res = await ApiBusiness().getDetailBusiness(id);
    resReviewBusiness = await ApiBusiness().getReviewBusiness(id);
    isLoadingReview = false;
    notifyListeners();
  }

  getListBusiness({bool? reset}) async {
    if (reset == true) {
      offset = 0;
      resBusiness = null;
      isLoading = true;
      notifyListeners();
    }

    var qp = {
      'location': 'ID',
      'sort_by': sortBy.toLowerCase().replaceAll(' ', '_'),
      'limit': limit,
      'offset': offset,
    };

    if (term != '') {
      qp['term'] = term;
    }

    if (price != '') {
      qp['price'] = price;
    }

    if (openNow != '') {
      qp['open_now'] = openNow;
    }

    var res = await ApiBusiness().getBusiness(qp);

    if (res.businesses!.isNotEmpty) {
      if (offset == 0) {
        resBusiness = res;
      } else if (offset > 0) {
        resBusiness!.businesses!.addAll(res.businesses!);
      }
      isLoadingNextPage = true;
    } else {
      isLoadingNextPage = false;
    }

    if (res.businesses!.length < limit) {
      isLoadingNextPage = false;
    }

    offset = offset + 20;
    isLoading = false;
    notifyListeners();
  }
}
