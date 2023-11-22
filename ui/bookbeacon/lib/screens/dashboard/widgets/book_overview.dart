import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/models/book_model.dart';
import '../../../utils/globals.dart';
import '../index.dart';
import 'book_thumbnail.dart';

class BookOverview extends GetView<DashBoardController> {
  const BookOverview({
    super.key,
    required this.book,
  });
  final BookModel book;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500),
              decoration: BoxDecoration(
                color: Globals.colorScheme.surface,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  ///
                  /// Top
                  ///
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    height: 4,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Globals.colorScheme.primary),
                  ),
    
                  ///
                  ///
                  /// BottomSheet Body
                  ///
                  ///
                  Expanded(
                      child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  /// Title
                                  ///
                                  Text(
                                    book.title,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
    
                                  Text(
                                    book.subtitle,
                                  ),
    
                                  const SizedBox(
                                    height: 10,
                                  ),
    
                                  /// Author
                                  ///
                                  Text.rich(
                                    TextSpan(text: 'Authors:  ', children: [
                                      TextSpan(
                                        text: book.authors,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ]),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
    
                                  /// Category
                                  ///
                                  Text.rich(
                                    TextSpan(text: 'Genre:  ', children: [
                                      TextSpan(
                                        text: book.categories,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ]),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
    
                                  ///
                                  /// Published Year
                                  ///
                                  Text.rich(
                                    TextSpan(
                                        text: 'Published year:  ',
                                        children: [
                                          TextSpan(
                                            text: book.publishedYear,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ]),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
    
                                  ///
                                  /// Number of pages
                                  ///
                                  Text.rich(
                                    TextSpan(
                                        text: 'Number of pages:  ',
                                        children: [
                                          TextSpan(
                                            text: book.numPages,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ]),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
    
                                  ///
                                  /// Rating
                                  ///
                                  /// Category
                                  ///
                                  Text.rich(
                                    TextSpan(text: 'Rating: ', children: [
                                      const TextSpan(
                                        text: ' ⭐️ ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text:
                                            '${book.averageRating}/${book.ratingsCount}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ]),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                              const SizedBox(
                                width: 20,
                              ),
                              BookThumbnail(thumbnailUrl: book.thumbnail, dimension: const Size(130, 166),),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            child: Text(
                              book.description,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
    
                  ///
                  ///
                  /// Bottom
                  ///
                  ///
                  Container(
                    margin:
                        const EdgeInsets.only(left: 30, right: 30, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Card(
                          elevation: 10,
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => controller.appCTRL.showSnackbar('Feature coming soon', position: SnackPosition.BOTTOM),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                constraints: const BoxConstraints(
                                    minHeight: 36, minWidth: 88),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                    color: Globals.colorScheme.primary,
                                    image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/icon/download-from-bookbeacon.png'),
                                        fit: BoxFit.fill)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Card(
                          color: Colors.transparent,
                          elevation: 10,
                          child: InkWell(
                            onTap: () => controller.appCTRL.launchExtUrl('https://www.amazon.com/s?k=${book.isbn10}'),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                constraints: const BoxConstraints(
                                    minHeight: 36, minWidth: 88),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                    color: Globals.colorScheme.primary,
                                    image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/icon/buy-on-amazon.png'),
                                        fit: BoxFit.fill)),
                              ),
                            ),
                          ),
                        )
                      
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
    );
  }
}
