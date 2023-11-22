import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/globals.dart';
import 'controller.dart';

class DashBoardScreen extends GetView<DashBoardController> {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Get.focusScope?.unfocus,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Globals.colorScheme.primary,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const Text('Welcome'),
          titleTextStyle:
              Globals.theme.textTheme.displaySmall!.copyWith(fontSize: 16),
          titleSpacing: 4,
          leading: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: InkWell(
                onTap: () {},
                child: const CircleAvatar(
                  child: Icon(Icons.person),
                )),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        body: PageView(
          controller: controller.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
              controller.pages.length, (index) => controller.pages[index]).toList(),
        ),
        extendBody: true,
        bottomNavigationBar:
            (controller.pages.length <= controller.pagesMaxCount)
                ? AnimatedNotchBottomBar(
                    notchBottomBarController: controller.notchController,
                    color: Globals.colorScheme.surface,
                    showLabel: false,
                    notchColor: Globals.colorScheme.primary,
                    removeMargins: false,
                    bottomBarWidth: 500,
                    durationInMilliSeconds: 300,
                    bottomBarItems: [
                      BottomBarItem(
                        inActiveItem: Icon(
                          Icons.search_outlined,
                          color: Globals.colorScheme.onSurface,
                        ),
                        activeItem: Icon(
                          Icons.search_sharp,
                          color: Globals.colorScheme.onPrimary,
                        ),
                        itemLabel: 'Search',
                      ),
                      
                      BottomBarItem(
                        inActiveItem: Icon(
                          Icons.bookmarks_outlined,
                          color: Globals.colorScheme.onSurface,
                        ),
                        activeItem: Icon(
                          Icons.bookmark,
                          color: Globals.colorScheme.onPrimary,
                        ),
                        itemLabel: 'Bookmark',
                      ),

                      BottomBarItem(
                        inActiveItem: Icon(
                          Icons.home_outlined,
                          color: Globals.colorScheme.onSurface,
                        ),
                        activeItem: Icon(
                          Icons.home_filled,
                          color: Globals.colorScheme.onPrimary,
                        ),
                        itemLabel: 'Home',
                      ),

                      BottomBarItem(
                        inActiveItem: Icon(
                          Icons.analytics_outlined,
                          color: Globals.colorScheme.onSurface,
                        ),
                        activeItem: Icon(
                          Icons.analytics_sharp,
                          color: Globals.colorScheme.onPrimary,
                        ),
                        itemLabel: 'Progress',
                      ),


                      BottomBarItem(
                        inActiveItem: Icon(
                          Icons.settings_outlined,
                          color: Globals.colorScheme.onSurface,
                        ),
                        activeItem: Icon(
                          Icons.settings,
                          color: Globals.colorScheme.onPrimary,
                        ),
                        itemLabel: 'Settings',
                      ),
                    ],
                    onTap: (index) {
                      controller.pageController.jumpToPage(index);
                    },
                  )
                : null,
      ),
    );
  }
}
