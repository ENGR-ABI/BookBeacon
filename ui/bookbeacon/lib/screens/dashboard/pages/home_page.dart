import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../app/layout/index.dart';
import '../../../utils/globals.dart';
import '../index.dart';
import '../widgets/book_thumbnail.dart';

class HomePage extends GetView<DashBoardController> {
  const HomePage({
    super.key,
  });

  get _inputBorder => OutlineInputBorder(
      borderSide: BorderSide(
        color: Globals.colorScheme.onPrimary,
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(14),
      ));

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil().screenHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            height: 220,
            width: ScreenUtil().screenWidth,
            decoration: BoxDecoration(
              color:
                  controller.appCTRL.themeCTRL.activeTheme.value.primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                // SEARCH BOOK ICON
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 170,
                    ),
                    height: 140,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/icon/book-search.png'),
                          fit: BoxFit.fill),
                    ),
                  ),
                ), // SEARCH FORM
                Align(
                    alignment: Alignment.centerLeft,
                    child: Form(
                      key: controller.searchRecomFormKey,
                      child: Container(
                        margin: const EdgeInsets.all(30),
                        constraints: const BoxConstraints(maxWidth: 400),
                        height: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'What would like to get recommendation on?',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Globals.colorScheme.onPrimary),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              controller: controller.bookSearchInput,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              style: TextStyle(
                                  color: Globals.colorScheme.onPrimary),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please, specify what you would like to read';
                                } else if (value.length < 3) {
                                  return 'Can you elaborate please';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  hintText: 'I\'d like to read...',
                                  prefixIcon: const Icon(Icons.book_online),
                                  prefixIconColor:
                                      Globals.colorScheme.onPrimary,
                                  errorStyle: const TextStyle(
                                      color: Colors.orangeAccent),
                                  border: _inputBorder,
                                  errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.orangeAccent,
                                    ),
                                  ),
                                  focusedBorder: _inputBorder,
                                  enabledBorder: _inputBorder,
                                  focusColor: Globals.colorScheme.secondary,
                                  labelStyle: TextStyle(
                                      color: Globals.colorScheme.onPrimary),
                                  hintStyle: TextStyle(
                                      color: Globals.colorScheme.onPrimary
                                          .withOpacity(.7))),
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            ElevatedButton(
                              onPressed: controller.getRecommendation,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Globals.colorScheme.surface,
                                foregroundColor: Globals.colorScheme.primary,
                              ),
                              child: const Icon(Icons.search),
                            )
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          ),
          Obx(
            () => Expanded(
              child: controller.recommendateBooks.isEmpty
                  ?  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                      child: const Text(
                          'Use input above to request for amazing books to read', textAlign: TextAlign.center,),
                    )
                  : LayoutRow(
                      items: List.generate(10, (index) {
                        final rBook = controller.recommendateBooks[index];
                        return LayoutItemModel(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 30),
                            // height: 156,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () => controller.showBookDetail(rBook),
                              child: Row(
                                children: [
                                  BookThumbnail(
                                    thumbnailUrl: rBook.thumbnail,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      /// Title
                                      ///
                                      Text(
                                        rBook.title,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),

                                      /// Author
                                      ///
                                      Text(rBook.authors),

                                      /// Rating
                                      ///
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: Colors.orange,
                                            ),
                                            Text(
                                              rBook.ratingsCount,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),

                                      /// Genre
                                      ///
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Globals.colorScheme.surfaceTint
                                              .withOpacity(.2),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 8),
                                        child: Text(rBook.categories),
                                      )
                                    ],
                                  )),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
            ),
          ),
          const SizedBox(
            height: 90,
          ),
        ],
      ),
    );
  }
}
