import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../app/app_themes.dart';
import '../../../app/preferences.dart';
import '../../../app/theme_provider.dart';

class ResourcesScreen extends StatefulWidget {
  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  late ThemeProvider themeProvider;
  int selectedIndex = 0;
  final PageController _pageController = PageController();


  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  void _loadTheme() async {
    setState(() {
      themeProvider.setThemeByString(Preferences.getString(AppThemes.SETTINGS_KEY));
    });
  }

  void _onTabTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return
       DefaultTabController(
          length: 4,
          child: Scaffold(
              // backgroundColor: Colors.grey.shade200,
            backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.grey : Colors.grey.shade200,
              // backgroundColor: Theme.of(context).colorScheme.secondary,

              appBar: AppBar(
                title: Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              child: Text("Old students?",
                                  style: TextStyle(color: Colors.red,fontSize: 19))),
                          Text("Resources",
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19)),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.search, color: Colors.brown.shade300,size: 25,),
                          ),
                        ],
                      ),
                      Divider(color: Colors.black12, thickness: 2),                 ],
                  ),
                ),
                bottom: TabBar(
                  dividerColor: Colors.black12,
                  labelColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                  unselectedLabelColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                  indicatorColor: Colors.red,
                  splashFactory: NoSplash.splashFactory,
                  labelStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  unselectedLabelStyle: TextStyle(fontSize: 18.0),

                  tabs: [
                    Tab(text: 'ALL',),
                    Tab(text: 'AUDIOS'),
                    Tab(text: 'BOOKS'),
                    Tab(text: 'VIDEOS'),
                  ],
                  onTap: _onTabTapped,
                ),
              ),
              body: Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          // color: Colors.white,
                          color: Theme.of(context).colorScheme.surface,
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.black12,
                                  width: 1.0
                              )
                          )),
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 28.0,
                          ),
                          child: SizedBox(
                            height: screenHeight * 0.30,
                            child: PageView.builder(
                              controller: _pageController,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: screenWidth * 0.5,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.025),
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),

                                  child: Center(
                                    child: Text('First List - Item $index',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                          child: SmoothPageIndicator(
                            controller: _pageController,
                            count: 5,
                            effect: ScrollingDotsEffect(
                                dotHeight: 8,
                                dotWidth: 8,
                                activeDotColor: Colors.red,
                                activeDotScale: 1.0,
                                dotColor: Colors.grey,
                                spacing: 8.0),
                          ),
                        ),
                      ])),

                  Expanded(
                    child: TabBarView(
                      children: [
                        buildTabContent(screenWidth, screenHeight,
                            showSecondList: true, showThirdList: true), // All Tab
                        buildTabContent(
                          screenWidth,
                          screenHeight,
                        ), // Audios Tab
                        buildTabContent(screenWidth, screenHeight), // Books Tab
                        buildTabContent(screenWidth, screenHeight), // Videos Tab
                      ],
                    ),
                  ),
                ],
              )));

  }

  Widget buildTabContent(double screenWidth, double screenHeight,
      {bool showSecondList = false, bool showThirdList = false}) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showSecondList) ...[
            SizedBox(height: screenHeight * 0.02),
            sectionHeader(screenWidth, "Popular Collection"),
            SizedBox(
              height: screenHeight * 0.11,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    width: screenWidth * 0.4,
                    margin:
                    EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child: Text("Second List - Item $index")),
                  );
                },
              ),
            ),
          ],
          if (showThirdList) ...[
            SizedBox(height: screenHeight * 0.02),
            sectionHeader(screenWidth, "On the Topic of"),
            SizedBox(
              height: screenHeight * 0.11,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    width: screenWidth * 0.4,
                    margin:
                    EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child: Text("Third List - Topic $index")),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget sectionHeader(double screenWidth, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.045,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text("See All", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}








////////////////////////////////////////////////////////////////////

// import 'package:flutter/material.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
//
// class ResourcesScreen extends StatefulWidget {
//   @override
//   State<ResourcesScreen> createState() => _ResourcesScreenState();
// }
//
// class _ResourcesScreenState extends State<ResourcesScreen> {
//   int selectedIndex = 0;
//   final PageController _pageController = PageController();
//
//   void _onTabTapped(int index) {
//     setState(() {
//       selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//
//     return DefaultTabController(
//         length: 4,
//         child: Scaffold(
//             backgroundColor: Colors.grey.shade200,
//             appBar: AppBar(
//               title: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       InkWell(
//                           child: Text("Old students?",
//                               style: TextStyle(color: Colors.red))),
//                       Text("Resources",
//                           style: TextStyle(fontWeight: FontWeight.bold)),
//                       IconButton(
//                         onPressed: () {},
//                         icon: Icon(Icons.search, color: Colors.brown.shade300),
//                       ),
//                     ],
//                   ),
//                   Container(
//                     width: double.infinity,
//                       // margin: EdgeInsets.zero,
//                   child: Divider(color: Colors.red)),
//                 ],
//               ),
//               bottom: TabBar(
//
//                 labelColor: Colors.black,
//                 unselectedLabelColor: Colors.black54,
//                 indicatorColor: Colors.red,
//                 splashFactory: NoSplash.splashFactory,
//                 tabs: [
//                   Tab(text: 'ALL'),
//                   Tab(text: 'AUDIOS'),
//                   Tab(text: 'BOOKS'),
//                   Tab(text: 'VIDEOS'),
//                 ],
//                 onTap: _onTabTapped,
//               ),
//             ),
//             body: Column(
//               children: [
//                 // First ListView - Fixed at the top
//                 Container(
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         border: Border(
//                           bottom: BorderSide(
//                               color: Colors.black12,
//                             width: 1.0
//                           )
//                         )),
//                     // margin: EdgeInsets.all(16.0),
//                     // padding: EdgeInsets.symmetric(vertical:10.0,horizontal: 16.0),
//                     child: Column(children: [
//                       Padding(
//                         padding: const EdgeInsets.only(
//                           top: 28.0,
//                         ),
//                         child: SizedBox(
//                           // width: screenWidth * 0.8,
//                           height: screenHeight * 0.30,
//                           child: PageView.builder(
//                             controller: _pageController,
//                             // scrollDirection: Axis.horizontal,
//                             itemCount: 5,
//                             itemBuilder: (context, index) {
//                               return Container(
//                                 width: screenWidth * 0.5,
//                                 margin: EdgeInsets.symmetric(
//                                     horizontal: screenWidth * 0.025),
//                                 // width: screenWidth * 1.0,
//                                 decoration: BoxDecoration(
//                                   color: Colors.blueAccent,
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 // width: screenWidth * 0.6,
//                                 // margin: EdgeInsets.all( 10.0),
//                                 child: Center(
//                                   child: Text('First List - Item $index',
//                                       style: TextStyle(color: Colors.white)),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//
//                       // TabBarView - Scrollable content for each tab
//                       Padding(
//                         padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
//                         child: SmoothPageIndicator(
//                           controller: _pageController,
//                           count: 5,
//                           effect: ScrollingDotsEffect(
//                               dotHeight: 8,
//                               dotWidth: 8,
//                               activeDotColor: Colors.red,
//                               activeDotScale: 1.0,
//                               dotColor: Colors.grey,
//                               spacing: 8.0),
//                         ),
//                       ),
//                     ])),
//
//                 // Divider(color: Colors.black12),
//                 Expanded(
//                   child: TabBarView(
//                     children: [
//                       buildTabContent(screenWidth, screenHeight,
//                           showSecondList: true, showThirdList: true), // All Tab
//                       buildTabContent(
//                         screenWidth,
//                         screenHeight,
//                       ), // Audios Tab
//                       buildTabContent(screenWidth, screenHeight), // Books Tab
//                       buildTabContent(screenWidth, screenHeight), // Videos Tab
//                     ],
//                   ),
//                 ),
//               ],
//             )));
//   }
//
//   Widget buildTabContent(double screenWidth, double screenHeight,
//       {bool showSecondList = false, bool showThirdList = false}) {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (showSecondList) ...[
//             SizedBox(height: screenHeight * 0.02),
//             sectionHeader(screenWidth, "Popular Collection"),
//             SizedBox(
//               height: screenHeight * 0.11,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: 5,
//                 itemBuilder: (context, index) {
//                   return Container(
//                     // color: Colors.grey.shade200,
//                     width: screenWidth * 0.4,
//                     margin:
//                         EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
//                     decoration: BoxDecoration(
//                       color: Colors.green,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Center(child: Text("Second List - Item $index")),
//                   );
//                 },
//               ),
//             ),
//           ],
//           if (showThirdList) ...[
//             SizedBox(height: screenHeight * 0.02),
//             sectionHeader(screenWidth, "On the Topic of"),
//             SizedBox(
//               height: screenHeight * 0.11,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: 5,
//                 itemBuilder: (context, index) {
//                   return Container(
//                     width: screenWidth * 0.4,
//                     margin:
//                         EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
//                     decoration: BoxDecoration(
//                       color: Colors.yellow,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Center(child: Text("Third List - Topic $index")),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
//
//   Widget sectionHeader(double screenWidth, String title) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: screenWidth * 0.045,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           TextButton(
//             onPressed: () {},
//             child: Text("See All", style: TextStyle(color: Colors.red)),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // import 'package:flutter/material.dart';
// // import 'package:patta/app/I18n.dart';
// // import 'package:patta/ui/screens/resources/tabBar_screen.dart';
// // import 'package:patta/ui/screens/resources/tabbar_all_screen.dart';
// // import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// //
// //
// // class ResourcesScreen extends StatefulWidget {
// //   @override
// //   State<ResourcesScreen> createState() => _ResourcesScreenState();
// // }
// //
// // class _ResourcesScreenState extends State<ResourcesScreen> {
// //   // final ScrollController _scrollController = ScrollController();
// //   // double currentPage = 0;
// //   int selectedIndex = 0;
// //   // final List<Widget> _screen = [
// //   //   TabbarAllScreen(),
// //   //   tabBarScreen(),
// //   //   tabBarScreen(),
// //   //   tabBarScreen()
// //   //
// //   // ];
// //
// //   void _onTabTapped(int index) {
// //     setState(() {
// //       selectedIndex = index;
// //     });
// //     // if (index==0){
// //     //   Navigator.push(context, MaterialPageRoute(builder: (context) => TabbarAllScreen()));
// //     // } else {
// //     //   Navigator.push(
// //     //     context,
// //     //     MaterialPageRoute(builder: (context) => _screen[index]),
// //     //   );
// //     // }
// //   }
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //
// //     final screenWidth = MediaQuery.of(context).size.width;
// //     final screenHeight = MediaQuery.of(context).size.height;
// //     return DefaultTabController(
// //       length: 4,
// //       child: Scaffold(
// //         appBar: AppBar(
// //           title: Column(
// //             children: [
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   InkWell(child: Text("Old students?",style: TextStyle(color: Colors.red),)),
// //                   Text("Resources",style: TextStyle(fontWeight: FontWeight.bold),),
// //                   IconButton(onPressed: (){},
// //                       icon: Icon(Icons.search,color: Colors.brown.shade300,))
// //                 ],
// //               ),
// //
// //               Divider(
// //                 color: Colors.black12,
// //               indent: 0,
// //               endIndent: 0,),
// //
// //
// //             ],
// //           ),
// //             bottom: TabBar(
// //               labelColor: Colors.black,
// //                 unselectedLabelColor: Colors.black54,
// //                 indicatorColor: Colors.red,
// //                 splashFactory: NoSplash.splashFactory,
// //
// //                 tabs: [
// //               Tab(text: 'ALL'),
// //               Tab(text: 'AUDIOS'),
// //               Tab(text: 'BOOKS'),
// //               Tab(text: 'VIDEOS')
// //             ],
// //               onTap: _onTabTapped,
// //             ),
// //         ),
// //
// //         body: TabBarView(
// //           children: [
// //             buildTabContent(screenWidth, screenHeight, showSecondList: true, showThirdList: true), // All Tab
// //             buildTabContent(screenWidth, screenHeight, showSecondList: true), // Audios Tab
// //             buildTabContent(screenWidth, screenHeight), // Books Tab
// //             buildTabContent(screenWidth, screenHeight), // Videos Tab
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget buildTabContent(double screenWidth, double screenHeight, {bool showSecondList = false, bool showThirdList = false}) {
// //     return SingleChildScrollView(
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Padding(
// //             padding: const EdgeInsets.only(top: 30.0),
// //             child: SizedBox(
// //               height: 150,
// //               child: ListView.builder(
// //                 scrollDirection: Axis.horizontal,
// //                 itemCount: 10,
// //                 itemBuilder: (context, index) {
// //                   return Container(
// //                     decoration: BoxDecoration(
// //                       color: Colors.blueAccent,
// //                       borderRadius: BorderRadius.circular(10),
// //                     ),
// //                     width: screenWidth * 0.8,
// //                     margin: EdgeInsets.only(right: 10.0),
// //                     child: Center(
// //                       child: Text('First List - Item $index', style: TextStyle(color: Colors.white)),
// //                     ),
// //                   );
// //                 },
// //               ),
// //             ),
// //           ),
// //           if (showSecondList) ...[
// //             SizedBox(height: screenHeight * 0.02),
// //             sectionHeader(screenWidth, "Popular Collection"),
// //             SizedBox(
// //               height: screenHeight * 0.13,
// //               child: ListView.builder(
// //                 scrollDirection: Axis.horizontal,
// //                 itemCount: 5,
// //                 itemBuilder: (context, index) {
// //                   return Container(
// //                     width: screenWidth * 0.5,
// //                     margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
// //                     decoration: BoxDecoration(
// //                       color: Colors.green,
// //                       borderRadius: BorderRadius.circular(10),
// //                     ),
// //                     child: Center(child: Text("Second List - Item $index")),
// //                   );
// //                 },
// //               ),
// //             ),
// //           ],
// //           if (showThirdList) ...[
// //             SizedBox(height: screenHeight * 0.02),
// //             sectionHeader(screenWidth, "On the Topic of"),
// //             SizedBox(
// //               height: screenHeight * 0.13,
// //               child: ListView.builder(
// //                 scrollDirection: Axis.horizontal,
// //                 itemCount: 5,
// //                 itemBuilder: (context, index) {
// //                   return Container(
// //                     width: screenWidth * 0.5,
// //                     margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
// //                     decoration: BoxDecoration(
// //                       color: Colors.yellow,
// //                       borderRadius: BorderRadius.circular(10),
// //                     ),
// //                     child: Center(child: Text("Third List - Topic $index")),
// //                   );
// //                 },
// //               ),
// //             ),
// //           ],
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget sectionHeader(double screenWidth, String title) {
// //     return Padding(
// //       padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         children: [
// //           Text(
// //             title,
// //             style: TextStyle(
// //               fontSize: screenWidth * 0.045,
// //               fontWeight: FontWeight.bold,
// //             ),
// //           ),
// //           TextButton(
// //             onPressed: () {},
// //             child: Text("See All", style: TextStyle(color: Colors.red)),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
// //
// // //         body:
// // //         SingleChildScrollView(
// // //           child: Column(
// // //             crossAxisAlignment: CrossAxisAlignment.start,
// // //             children: [
// // //               Padding(
// // //                 padding: const EdgeInsets.only(top: 30.0),
// // //                 child: SizedBox(
// // //                   height: 150,
// // //
// // //                   child: ListView.builder(
// // //                     // controller: _scrollController,
// // //                       scrollDirection: Axis.horizontal,
// // //                       // reverse: true,
// // //                       itemCount: 10,
// // //                       itemBuilder: (context, index) {
// // //                         return Container(
// // //                             decoration: BoxDecoration(
// // //                               color: Colors.blueAccent,
// // //                               borderRadius: BorderRadius.circular(10),
// // //                             ),
// // //
// // //                             // height: 50,
// // //                             width: MediaQuery.of(context).size.width * 0.8, // Set width to 80% of the screen width
// // //                             margin: EdgeInsets.only(right: 10.0), // Space between items
// // //                             // color: Colors.blueAccent, // Change as needed
// // //                             child: Center(child: Text('Item $index', style: TextStyle(color: Colors.white)))
// // //                         );
// // //                       }),
// // //                 ),
// // //               ),
// // //               // _screen[selectedIndex]
// // //
// // //               SizedBox(height: screenHeight * 0.02),
// // //               Padding(
// // //                 padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04), // 4% of screen width
// // //                 child: Row(
// // //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                   children: [
// // //                     Text(
// // //                       "Popular Collection",
// // //                       style: TextStyle(
// // //                         fontSize: screenWidth * 0.045, // Responsive font size
// // //                         fontWeight: FontWeight.bold,
// // //                       ),
// // //                     ),
// // //                     TextButton(onPressed: () {}, child: Text("See All",style: TextStyle(color: Colors.red),)),
// // //                   ],
// // //                 ),
// // //               ),
// // //
// // //               SizedBox(
// // //                 height: screenHeight * 0.13, // 18% of screen height
// // //                 child: ListView.builder(
// // //                   scrollDirection: Axis.horizontal,
// // //                   itemCount: 5,
// // //                   itemBuilder: (context, index) {
// // //                     return Container(
// // //                       width: screenWidth * 0.5, // 30% of screen width
// // //                       margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.025), // 2.5% of screen width
// // //                       decoration: BoxDecoration(
// // //                         color: Colors.green,
// // //                         borderRadius: BorderRadius.circular(10),
// // //                       ),
// // //                       child: Center(child: Text("Item $index")),
// // //                     );
// // //                   },
// // //                 ),
// // //               ),
// // //               SizedBox(height: screenHeight * 0.02),
// // //
// // //               Padding(
// // //                 padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04), // 4% of screen width
// // //                 child: Row(
// // //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                   children: [
// // //                     Text(
// // //                       "On the Topic of",
// // //                       style: TextStyle(
// // //                         fontSize: screenWidth * 0.045, // Responsive font size
// // //                         fontWeight: FontWeight.bold,
// // //                       ),
// // //                     ),
// // //                     TextButton(onPressed: () {}, child: Text("See All",style: TextStyle(color: Colors.red),)),
// // //                   ],
// // //                 ),
// // //               ),
// // //
// // //               SizedBox(
// // //                 height: screenHeight * 0.13, // 18% of screen height
// // //                 child: ListView.builder(
// // //                   scrollDirection: Axis.horizontal,
// // //                   itemCount: 5,
// // //                   itemBuilder: (context, index) {
// // //                     return Container(
// // //                       width: screenWidth * 0.5, // 30% of screen width
// // //                       margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.025), // 2.5% of screen width
// // //                       decoration: BoxDecoration(
// // //                         color: Colors.yellow,
// // //                         borderRadius: BorderRadius.circular(10),
// // //                       ),                    child: Center(child: Text("Topic $index")),
// // //                     );
// // //                   },
// // //                 ),
// // //               ),
// // //
// // //             ],
// // //           ),
// // //         ),
// // //
// // //
// // //
// // //
// // //       ),
// // //     );
// // //   }
// // // }
// // //
// // //
