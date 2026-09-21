import 'dart:developer';
import 'dart:math' hide log;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlr/data/models/category_model/category_model.dart';
import 'package:vlr/data/models/category_model/facilities_model.dart';
import 'package:vlr/data/models/category_model/listing_model.dart';
import 'package:vlr/data/models/category_model/staff_model.dart';
import 'package:vlr/data/models/pagination/pagination_state.dart';
import 'package:vlr/data/models/response/response_model.dart';
import 'package:vlr/data/repositories/home_repo.dart';

import '../services/constants.dart';

class HomeController extends GetxController implements GetxService {
  final HomeRepo homeRepo;

  HomeController({required this.homeRepo});

  // -------------------- DISTANCE CALCULATION --------------------

  /// Calculates distance between two coordinates using the Haversine formula.
  /// Returns distance in kilometers.
  double _calculateDistance(
    double lat1, double lon1, double lat2, double lon2,
  ) {
    const double earthRadiusKm = 6371.0;
    final double dLat = _degreesToRadians(lat2 - lat1);
    final double dLon = _degreesToRadians(lon2 - lon1);

    final double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) *
            cos(_degreesToRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadiusKm * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }

  /// Calculates distance for each listing from user's location, sets calculatedDistanceKm,
  /// and sorts listings by distance (nearest first).
  void _calculateDistanceForListings({
    required List<ListingModel> listings,
    required double? userLat,
    required double? userLng,
  }) {
    if (userLat == null || userLng == null) return;

    for (final listing in listings) {
      final double? listingLat = double.tryParse(listing.lat ?? '');
      final double? listingLng = double.tryParse(listing.lng ?? '');

      if (listingLat != null && listingLng != null) {
        listing.calculatedDistanceKm = _calculateDistance(
          userLat, userLng, listingLat, listingLng,
        );
      }
    }

    // Sort listings by effective distance (nearest first)
    listings.sort((a, b) {
      final aDist = a.effectiveDistanceKm ?? double.infinity;
      final bDist = b.effectiveDistanceKm ?? double.infinity;
      return aDist.compareTo(bDist);
    });
  }

  bool isLoading = false;
  bool isListingLoading = false;
  bool isFacilitiesLoading = false;
  bool isStaffLoading = false;

  List<CategoryModel> categoryModelList = [];

  CategoryModel? selectCategoryModel;

  void updateSelectCategoryModel(CategoryModel value) {
    selectCategoryModel = value;
    log("selectCategoryModel : ${selectCategoryModel?.name ?? ""}");
    update();
  }

  TextEditingController searchController = TextEditingController();

  Future<ResponseModel> fetchCategories() async {
    log('----------- logout fetchCategories ----------');

    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Response response = await homeRepo.fetchCategories();

      if (response.body['status'] == "success") {
        categoryModelList = (response.body['data'] as List)
            .map((e) => CategoryModel.fromJson(e))
            .toList();

        log("categoryModelList ; ${categoryModelList.length}");

        responseModel = ResponseModel(
            true, response.body['message'] ?? "success fetchCategories  ");
      } else {
        responseModel = ResponseModel(
            false, response.body['message'] ?? "Error while fetchCategories  ");
      }
    } catch (e) {
      log('ERROR AT fetchCategories(): $e');
      responseModel = ResponseModel(false, "Error while fetchCategories   $e");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  List<ListingModel> listingModelList = [];

  // Categorized lists for home screen sections
  bool isGymLoading = false;
  List<ListingModel> gymList = [];

  bool isDanceLoading = false;
  List<ListingModel> danceList = [];

  bool isPgHostelLoading = false;
  List<ListingModel> pgHostelList = [];

  bool isSearchLoading = false;
  List<ListingModel> searchResultList = [];

  Future<ResponseModel> searchListings({
    required String search,
    required double? latitude,
    required double? longitude,
  }) async {
    log('----------- searchListings ----------');
    ResponseModel responseModel;
    isSearchLoading = true;
    update();
    try {
      final Map<String, dynamic> queryParameters = {
        if (latitude != null) "latitude": latitude.toString(),
        if (longitude != null) "longitude": longitude.toString(),
        "category_id": "",
        "search": search,
        "page": "1",
      };
      final Response response = await homeRepo.fetchCategoriesListing(data: queryParameters);
      if (response.body['status'] == "success") {
        searchResultList = (response.body['data']['data'] as List)
            .map((e) => ListingModel.fromJson(e))
            .toList();
        _calculateDistanceForListings(
          listings: searchResultList,
          userLat: latitude,
          userLng: longitude,
        );
        responseModel = ResponseModel(true, "success");
      } else {
        searchResultList = [];
        responseModel = ResponseModel(false, response.body['message'] ?? "Error");
      }
    } catch (e) {
      log('ERROR AT searchListings(): $e');
      searchResultList = [];
      responseModel = ResponseModel(false, "Error: $e");
    }
    isSearchLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> fetchGymListing({
    required double? latitude,
    required double? longitude,
  }) async {
    log('----------- fetchGymListing ----------');
    ResponseModel responseModel;
    isGymLoading = true;
    update();
    try {
      final Map<String, dynamic> queryParameters = {
        if (latitude != null) "latitude": latitude.toString(),
        if (longitude != null) "longitude": longitude.toString(),
        "category_id": "1",
        "page": "1",
        "search": "",
      };

      String queryString = queryParameters.entries
          .map((e) => '${e.key}=${Uri.encodeComponent(e.value.toString())}')
          .join('&');
      log("FULL URL HIT (Gym): ${AppConstants.baseUrl}${AppConstants.getListing}?$queryString");

      final Response response = await homeRepo.fetchCategoriesListing(data: queryParameters);
      if (response.body['status'] == "success") {
        gymList = (response.body['data']['data'] as List)
            .map((e) => ListingModel.fromJson(e))
            .toList();
        _calculateDistanceForListings(
          listings: gymList,
          userLat: latitude,
          userLng: longitude,
        );
        listingModelList = gymList; // Fallback for other parts using listingModelList
        responseModel = ResponseModel(true, response.body['message'] ?? "success");
      } else {
        responseModel = ResponseModel(false, response.body['message'] ?? "error");
      }
    } catch (e) {
      responseModel = ResponseModel(false, "error $e");
    }
    isGymLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> fetchDanceListing({
    required double? latitude,
    required double? longitude,
  }) async {
    log('----------- fetchDanceListing ----------');
    ResponseModel responseModel;
    isDanceLoading = true;
    update();
    try {
      final Map<String, dynamic> queryParameters = {
        if (latitude != null) "latitude": latitude.toString(),
        if (longitude != null) "longitude": longitude.toString(),
        "category_id": "2",
        "page": "1",
        "search": "",
      };

      String queryString = queryParameters.entries
          .map((e) => '${e.key}=${Uri.encodeComponent(e.value.toString())}')
          .join('&');
      log("FULL URL HIT (Dance): ${AppConstants.baseUrl}${AppConstants.getListing}?$queryString");

      final Response response = await homeRepo.fetchCategoriesListing(data: queryParameters);
      if (response.body['status'] == "success") {
        danceList = (response.body['data']['data'] as List)
            .map((e) => ListingModel.fromJson(e))
            .toList();
        _calculateDistanceForListings(
          listings: danceList,
          userLat: latitude,
          userLng: longitude,
        );
        responseModel = ResponseModel(true, response.body['message'] ?? "success");
      } else {
        responseModel = ResponseModel(false, response.body['message'] ?? "error");
      }
    } catch (e) {
      responseModel = ResponseModel(false, "error $e");
    }
    isDanceLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> fetchPgHostelListing({
    required double? latitude,
    required double? longitude,
  }) async {
    log('----------- fetchPgHostelListing ----------');

    ResponseModel responseModel;
    isPgHostelLoading = true;
    update();

    try {
      final Map<String, dynamic> queryParameters = {
        if (latitude != null) "latitude": latitude.toString(),
        if (longitude != null) "longitude": longitude.toString(),
        "category_id": "3",
        "page": "1",
        "search": "",
      };

      String queryString = queryParameters.entries
          .map((e) => '${e.key}=${Uri.encodeComponent(e.value.toString())}')
          .join('&');
      log("FULL URL HIT (PG): ${AppConstants.baseUrl}${AppConstants.getListing}?$queryString");

      final Response response = await homeRepo.fetchCategoriesListing(data: queryParameters);

      if (response.body['status'] == "success") {
        pgHostelList = (response.body['data']['data'] as List)
            .map((e) => ListingModel.fromJson(e))
            .toList();
        _calculateDistanceForListings(
          listings: pgHostelList,
          userLat: latitude,
          userLng: longitude,
        );

        log("pgHostelList count: ${pgHostelList.length}");

        responseModel = ResponseModel(
            true, response.body['message'] ?? "success fetchPgHostelListing");
      } else {
        responseModel = ResponseModel(false,
            response.body['message'] ?? "Error while fetchPgHostelListing");
      }
    } catch (e) {
      log('ERROR AT fetchPgHostelListing(): $e');
      responseModel = ResponseModel(false, "Error while fetchPgHostelListing $e");
    }

    isPgHostelLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> fetchCategoriesListing({
    required double? latitude,
    required double? longitude,
    String? categoryId,
  }) async {
    log('----------- fetchCategoriesListing ----------');

    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      final Map<String, dynamic> queryParameters = {
        "latitude": latitude?.toString() ?? "",
        "longitude": longitude?.toString() ?? "",
        "category_id": categoryId ?? selectCategoryModel?.id?.toString() ?? "1",
        "page": "1",
        "search": "",
      };

      // Construct and print full URL
      String queryString = queryParameters.entries
          .map((e) => '${e.key}=${Uri.encodeComponent(e.value.toString())}')
          .join('&');
      String fullUrl = "${AppConstants.baseUrl}${AppConstants.getListing}?$queryString";
      log("FULL URL HIT: $fullUrl");

      final Response response =
          await homeRepo.fetchCategoriesListing(data: queryParameters);

      log("Raw response body: ${response.body}");

      final body = response.body;

      if (body == null) {
        responseModel = ResponseModel(false, "Empty response from server");
      } else if (body is Map<String, dynamic> && body['status'] == "success") {
        final listingResponse = body['data'];

        if (listingResponse is Map<String, dynamic> &&
            listingResponse['data'] is List) {
          listingModelList = (listingResponse['data'] as List)
              .map((e) => ListingModel.fromJson(e))
              .toList();
          _calculateDistanceForListings(
            listings: listingModelList,
            userLat: latitude,
            userLng: longitude,
          );

          log("Listing count: ${listingModelList.length}");

          responseModel = ResponseModel(
            true,
            body['message'] ?? "success fetchCategoriesListing",
          );
        } else {
          responseModel = ResponseModel(
            false,
            "Invalid listing response format",
          );
        }
      } else {
        responseModel = ResponseModel(
          false,
          body is Map<String, dynamic>
              ? (body['message'] ?? "Error while fetchCategoriesListing")
              : "Invalid server response",
        );
      }
    } catch (e) {
      log('ERROR AT fetchCategoriesListing(): $e');
      responseModel =
          ResponseModel(false, "Error while fetchCategoriesListing $e");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  // final PaginationState<ListingModel> listingState =
  //     PaginationState<ListingModel>();

  // List<ListingModel> get listingList => listingState.items;

  // Future<ResponseModel> fetchCategoriesListingPagination({
  //   required double? latitude,
  //   required double? longitude,
  //   bool loadMore = false,
  //   bool refresh = false,
  // }) async {
  //   log('fetchCategoriesListingPagination called '
  //       '(loadMore: $loadMore, refresh: $refresh)');

  //   ResponseModel responseModel = ResponseModel(false, "Unknown error");

  //   if (refresh) {
  //     listingState.page = 1;
  //     listingState.lastPage = 1;
  //     listingState.items.clear();
  //     listingState.dedupeIds.clear();
  //   }

  //   if (loadMore) {
  //     if (!listingState.canLoadMore) {
  //       return ResponseModel(false, "No more pages");
  //     }
  //     listingState.isMoreLoading = true;
  //     listingState.page += 1;
  //   } else {
  //     listingState.isInitialLoading = true;
  //     listingState.page = 1;
  //     listingState.items.clear();
  //     listingState.dedupeIds.clear();
  //   }

  //   update();

  //   try {
  //     final Map<String, dynamic> data = {
  //       "latitude": latitude?.toString() ?? "",
  //       "longitude": longitude?.toString() ?? "",
  //       "category_id": selectCategoryModel?.id?.toString() ?? "",
  //       "search": searchController.text.trim(),
  //       "page": listingState.page.toString(),
  //     };

  //     final Response response =
  //         await homeRepo.fetchCategoriesListing(data: data);

  //     log("Raw response body: ${response.body}");

  //     if (response.statusCode != 200) {
  //       responseModel =
  //           ResponseModel(false, "Status code: ${response.statusCode}");
  //     } else if (response.body is Map<String, dynamic> &&
  //         response.body['status'] == "success") {
  //       final paginated = response.body['data'];

  //       if (paginated is Map<String, dynamic> && paginated['data'] is List) {
  //         final List itemsJson = paginated['data'] as List;

  //         final List<ListingModel> parsedData = itemsJson
  //             .map((e) => ListingModel.fromJson(e as Map<String, dynamic>))
  //             .toList();

  //         final int currentPage =
  //             int.tryParse(paginated['current_page'].toString()) ??
  //                 listingState.page;
  //         final int lastPage =
  //             int.tryParse(paginated['last_page'].toString()) ?? currentPage;

  //         listingState.lastPage = lastPage;
  //         listingState.page = currentPage;

  //         if (loadMore) {
  //           for (final item in parsedData) {
  //             if (!listingState.dedupeIds.contains(item.id)) {
  //               listingState.dedupeIds.add(item.id);
  //               listingState.items.add(item);
  //             }
  //           }
  //         } else {
  //           listingState.items
  //             ..clear()
  //             ..addAll(parsedData);

  //           listingState.dedupeIds
  //             ..clear()
  //             ..addAll(parsedData.map((e) => e.id));
  //         }

  //         log("Listing count: ${listingState.items.length}");
  //         responseModel = ResponseModel(
  //           true,
  //           response.body['message'] ?? "success fetchCategoriesListing",
  //         );
  //       } else {
  //         responseModel =
  //             ResponseModel(false, "Invalid listing response format");
  //       }
  //     } else {
  //       responseModel = ResponseModel(
  //         false,
  //         response.body is Map<String, dynamic>
  //             ? (response.body['message'] ??
  //                 "Error while fetchCategoriesListing")
  //             : "Invalid server response",
  //       );
  //     }
  //   } catch (e) {
  //     log('ERROR AT fetchCategoriesListingPagination(): $e');
  //     responseModel =
  //         ResponseModel(false, "Error while fetchCategoriesListing $e");
  //   }

  //   listingState.isInitialLoading = false;
  //   listingState.isMoreLoading = false;
  //   update();
  //   return responseModel;
  // }

  final PaginationState<ListingModel> listingStateSearch =
      PaginationState<ListingModel>();

  List<ListingModel> get listingSearchList => listingStateSearch.items;

  Future<ResponseModel> searchFetchCategoriesListingPagination({
    required double? latitude,
    required double? longitude,
    bool loadMore = false,
    bool refresh = false,
  }) async {
    log('searchFetchCategoriesListingPagination called '
        '(loadMore: $loadMore, refresh: $refresh)');

    ResponseModel responseModel = ResponseModel(false, "Unknown error");

    if (refresh) {
      listingStateSearch.page = 1;
      listingStateSearch.lastPage = 1;
      listingStateSearch.items.clear();
      listingStateSearch.dedupeIds.clear();
    }

    if (loadMore) {
      if (!listingStateSearch.canLoadMore) {
        return ResponseModel(false, "No more pages");
      }
      listingStateSearch.isMoreLoading = true;
      listingStateSearch.page += 1;
    } else {
      listingStateSearch.isInitialLoading = true;
      listingStateSearch.page = 1;
      listingStateSearch.items.clear();
      listingStateSearch.dedupeIds.clear();
    }

    update();

    try {
      final Map<String, dynamic> queryParameters = {
        if (latitude != null) "latitude": latitude.toString(),
        if (longitude != null) "longitude": longitude.toString(),
        "category_id": selectCategoryModel?.id?.toString() ?? "",
        "search": searchController.text.trim(),
        "page": listingStateSearch.page.toString(),
      };

      final Response response =
          await homeRepo.fetchCategoriesListing(data: queryParameters);

      log("Raw response body: ${response.body}");

      if (response.statusCode != 200) {
        responseModel =
            ResponseModel(false, "Status code: ${response.statusCode}");
      } else if (response.body is Map<String, dynamic> &&
          response.body['status'] == "success") {
        final paginated = response.body['data'];

        if (paginated is Map<String, dynamic> && paginated['data'] is List) {
          final List itemsJson = paginated['data'] as List;

          final List<ListingModel> parsedData = itemsJson
              .map((e) => ListingModel.fromJson(e as Map<String, dynamic>))
              .toList();

          final int currentPage =
              int.tryParse(paginated['current_page'].toString()) ??
                  listingStateSearch.page;
          final int lastPage =
              int.tryParse(paginated['last_page'].toString()) ?? currentPage;

          listingStateSearch.lastPage = lastPage;
          listingStateSearch.page = currentPage;

          if (loadMore) {
            for (final item in parsedData) {
              if (!listingStateSearch.dedupeIds.contains(item.id)) {
                listingStateSearch.dedupeIds.add(item.id);
                listingStateSearch.items.add(item);
              }
            }
          } else {
            listingStateSearch.items
              ..clear()
              ..addAll(parsedData);

            listingStateSearch.dedupeIds
              ..clear()
              ..addAll(parsedData.map((e) => e.id));
          }

          _calculateDistanceForListings(
            listings: listingStateSearch.items,
            userLat: latitude,
            userLng: longitude,
          );

          log("Listing count: ${listingStateSearch.items.length}");
          responseModel = ResponseModel(
            true,
            response.body['message'] ??
                "success searchFetchCategoriesListingPagination",
          );
        } else {
          responseModel =
              ResponseModel(false, "Invalid listing response format");
        }
      } else {
        responseModel = ResponseModel(
          false,
          response.body is Map<String, dynamic>
              ? (response.body['message'] ??
                  "Error while searchFetchCategoriesListingPagination")
              : "Invalid server response",
        );
      }
    } catch (e) {
      log('ERROR AT searchFetchCategoriesListingPagination(): $e');
      responseModel = ResponseModel(
          false, "Error while searchFetchCategoriesListingPagination $e");
    }

    listingStateSearch.isInitialLoading = false;
    listingStateSearch.isMoreLoading = false;
    update();
    return responseModel;
  }

  ListingModel? selectListingModel;

  updateSelectListingModel({required ListingModel value}) async {
    selectListingModel = value;
    update();
  }

  Future<ResponseModel> fetchCategoriesListingById() async {
    log('-----------  fetchCategoriesListingById ----------');

    ResponseModel responseModel;
    isLoading = true;
    isListingLoading = true;
    update();

    try {
      final id = selectListingModel?.id ?? "";
      log('fetchCategoriesListingById: Fetching for ID: $id');
      Response response = await homeRepo.fetchCategoriesListingById(id: id);

      if (response.body['status'] == "success") {
        selectListingModel = ListingModel.fromJson(response.body['data']);

        responseModel = ResponseModel(true,
            response.body['message'] ?? "success fetchCategoriesListingById  ");
      } else {
        responseModel = ResponseModel(
            false,
            response.body['message'] ??
                "Error while fetchCategoriesListingById  ");
      }
    } catch (e) {
      log('ERROR AT fetchCategoriesListingById(): $e');
      responseModel =
          ResponseModel(false, "Error while fetchCategoriesListingById   $e");
    }

    isLoading = false;
    isListingLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> fetchBannerCategoriesListingById() async {
    log('-----------  fetchBannerCategoriesListingById ----------');

    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      log("Cate ${selectCategoryModel?.id ?? ""}");
      Response response = await homeRepo.fetchBannerCategoriesListingById(
          id: selectCategoryModel?.id ?? 0);

      if (response.body['status'] == "success") {
        // selectListingModel = ListingModel.fromJson(response.body['data']);

        responseModel = ResponseModel(
            true,
            response.body['message'] ??
                "success fetchBannerCategoriesListingById  ");
      } else {
        responseModel = ResponseModel(
            false,
            response.body['message'] ??
                "Error while fetchBannerCategoriesListingById  ");
      }
    } catch (e) {
      log('ERROR AT fetchBannerCategoriesListingById(): $e');
      responseModel = ResponseModel(
          false, "Error while fetchBannerCategoriesListingById   $e");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  List<FacilityModel> facilityList = [];

  Future<ResponseModel> fetchFacilitiesListingById() async {
    log('-----------  fetchFacilitiesListingById ----------');

    ResponseModel responseModel;
    isLoading = true;
    isFacilitiesLoading = true;
    update();

    try {
      Response response = await homeRepo.fetchFacilitiesListingById(
          id: selectListingModel?.id ?? "");

      if (response.body['status'] == "success") {
        facilityList = (response.body['data'] as List)
            .map((e) => FacilityModel.fromJson(e))
            .toList();
        responseModel = ResponseModel(true,
            response.body['message'] ?? "success fetchFacilitiesListingById  ");
      } else {
        responseModel = ResponseModel(
            false,
            response.body['message'] ??
                "Error while fetchFacilitiesListingById  ");
      }
    } catch (e) {
      log('ERROR AT fetchFacilitiesListingById(): $e');
      responseModel =
          ResponseModel(false, "Error while fetchFacilitiesListingById   $e");
    }

    isLoading = false;
    isFacilitiesLoading = false;
    update();
    return responseModel;
  }

  List<StaffModel> staffList = [];
  StaffModel? selectedStaffProfile;

  Future<ResponseModel> fetchStaffProfileById({
    required String? id,
    required String? staffId,
  }) async {
    log('-----------  fetchStaffProfileById ----------');

    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Response response = await homeRepo.fetchStaffProfileById(
        id: id ?? "",
        staffId: staffId ?? "",
      );

      if (response.body != null && response.body['status'] == "success") {
        var data = response.body['data'];
        if (data is List && data.isNotEmpty) {
          if (data[0] is Map) {
            selectedStaffProfile =
                StaffModel.fromJson(Map<String, dynamic>.from(data[0]));
          } else {
            selectedStaffProfile = null;
          }
        } else if (data is Map && data.isNotEmpty) {
          if (data.containsKey('id')) {
            selectedStaffProfile =
                StaffModel.fromJson(Map<String, dynamic>.from(data));
          } else {
            // Handle map with numeric keys like {"1": {...}}
            var firstValue = data.values.first;
            var finalData = firstValue is List
                ? (firstValue.isNotEmpty ? firstValue[0] : null)
                : firstValue;
            if (finalData is Map) {
              selectedStaffProfile =
                  StaffModel.fromJson(Map<String, dynamic>.from(finalData));
            } else {
              selectedStaffProfile = null;
            }
          }
        } else {
          selectedStaffProfile = null;
        }

        responseModel = ResponseModel(true,
            response.body['message'] ?? "success fetchStaffProfileById  ");
      } else {
        selectedStaffProfile = null;
        responseModel = ResponseModel(false,
            response.body?['message'] ?? "Error while fetchStaffProfileById  ");
      }
    } catch (e) {
      selectedStaffProfile = null;
      log('ERROR AT fetchStaffProfileById(): $e');
      responseModel =
          ResponseModel(false, "Error while fetchStaffProfileById   $e");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> fetchStaffListingById() async {
    log('-----------  fetchStaffListingById ----------');

    ResponseModel responseModel;
    isLoading = true;
    isStaffLoading = true;
    update();

    try {
      Response response = await homeRepo.fetchStaffListingById(
          id: selectListingModel?.id ?? "");

      if (response.body != null && response.body['status'] == "success") {
        var data = response.body['data'];
        if (data is List) {
          staffList = data.map((e) => StaffModel.fromJson(e)).toList();
        } else if (data is Map && data['data'] is List) {
          staffList = (data['data'] as List)
              .map((e) => StaffModel.fromJson(e))
              .toList();
        } else {
          staffList = [];
        }

        responseModel = ResponseModel(true,
            response.body['message'] ?? "success fetchStaffListingById  ");
      } else {
        staffList = [];
        responseModel = ResponseModel(false,
            response.body?['message'] ?? "Error while fetchStaffListingById  ");
      }
    } catch (e) {
      staffList = [];
      log('ERROR AT fetchStaffListingById(): $e');
      responseModel =
          ResponseModel(false, "Error while fetchStaffListingById   $e");
    }

    isLoading = false;
    isStaffLoading = false;
    update();
    return responseModel;
  }

  List<dynamic> otherBrandedList = [];
//! NO Data is add
  Future<ResponseModel> fetchBranchesListingById() async {
    log('-----------  fetchBranchesListingById ----------');

    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      log("Id banner ${selectCategoryModel?.id}");
      Response response = await homeRepo.fetchBranchesListingById(
          id: selectCategoryModel?.id ?? 0);

      if (response.body['status'] == "success") {
        // staffList = (response.body['data'] as List)
        //     .map((e) => StaffModel.fromJson(e))
        //     .toList();
        responseModel = ResponseModel(true,
            response.body['message'] ?? "success fetchBranchesListingById  ");
      } else {
        responseModel = ResponseModel(
            false,
            response.body['message'] ??
                "Error while fetchBranchesListingById  ");
      }
    } catch (e) {
      log('ERROR AT fetchBranchesListingById(): $e');
      responseModel =
          ResponseModel(false, "Error while fetchBranchesListingById   $e");
    }

    isLoading = false;
    update();
    return responseModel;
  }
}
