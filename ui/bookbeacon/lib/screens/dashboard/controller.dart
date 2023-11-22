import 'dart:convert';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:bookbeacon/app/config/values.dart';
import 'package:bookbeacon/app/models/book_model.dart';
import 'package:bookbeacon/app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/controllers/app_controller.dart';
import '../../app/layout/layout_controller.dart';
import '../../app/models/country.dart';
import '../../utils/utills.dart';
import 'pages/home_page.dart';
import 'state.dart';
import 'widgets/book_overview.dart';

class DashBoardController extends GetxController {
  final state = DashBoardState();
  final layout = LayoutController.inst;
  final appCTRL = AppController.inst;
  final GlobalKey<FormState> searchRecomFormKey = GlobalKey<FormState>();
  final inputError = ''.obs;
  late Country _activeCountry;
  Country get activeCountry => _activeCountry;

  final pageController = PageController(initialPage: 0);

  /// Controller to handle bottom nav bar and also handles initial page
  final notchController = NotchBottomBarController(index: 0);

  int pagesMaxCount = 6;

  List<Widget> get pages => [
        const HomePage(),
        const HomePage(),
        const HomePage(),
        const HomePage(),
        const HomePage(),
        const HomePage(),
      ];

  final TextEditingController interestHobbiesInput = TextEditingController();

  final TextEditingController bookSearchInput = TextEditingController();

  final RxList<BookModel> recommendateBooks = RxList([]);

  @override
  void onInit() {
    _activeCountry = Country(
      name: 'India',
      code: 'IN',
      dialCode: '+91',
      flag: Utils.countryCodeToEmoji('IN'),
    );

    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void changeState() {
    if (state.index.value == pages.length - 1) {
      state.index--;
    } else {
      state.index++;
    }
  }

  Future<void> getRecommendation() async {
    if (searchRecomFormKey.currentState!.validate()) {
      final String searchQuery = bookSearchInput.text;
      appCTRL.showLoading(initialLoadingText: 'Searching...');
      final response = await ApiService.inst.post(SEARCH_ENDPOINT, {'query-text': searchQuery});
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        for (var res in decodedResponse) {
          recommendateBooks.add(BookModel.fromMap(res));
        }
        appCTRL.stopLoading();
      } else {
        appCTRL.showSnackbar(response.body, color: Colors.red);
        appCTRL.stopLoading();
      }
    }
  }

  showBookDetail(BookModel rBook) {
    Get.bottomSheet(
      BookOverview(book: rBook),
    );
  }
}

