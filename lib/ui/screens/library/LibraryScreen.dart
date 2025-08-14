
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:patta/api/kosa_api.dart';
import 'package:patta/model/Video.dart';
import 'package:patta/ui/common/pariyatti_icons.dart';
import 'package:patta/ui/screens/library/VimeoPlayerScreen.dart';
import 'package:patta/app/I18n.dart';
import 'package:provider/provider.dart';

class LibraryScreen extends StatefulWidget {
  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  // TODO: separate VideoScreen and LibraryScreen
  // TODO: ultimately, state like `selectedTab` should all be on-disk, we should avoid StatefulWidget
  int selectedTab = 0;
  bool switch_AZ = true;
  List<Video> sortedVideoList = [];
  TextEditingController _searchController = TextEditingController();
  List<Video> allVideos = [];
  String is_selectedButton = 'All';



  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchTextChanged);
  }

  void _onTabTapped(int index) {
    setState(() {
      selectedTab = index;
    });
  }
  void _onSearchTextChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        sortedVideoList = List.from(allVideos);
      } else {
        sortedVideoList = allVideos.where((video) {
          return video.title.toLowerCase().startsWith(query);
        }).toList();
      }
    });
  }
  TextSpan _buildHighlightedText(String title, String query, Color baseColor) {
    if (query.isEmpty) {
      return TextSpan(text: title, style: TextStyle(color: baseColor));
    }

    final lowerTitle = title.toLowerCase();
    final lowerQuery = query.toLowerCase();

    final startIndex = lowerTitle.indexOf(lowerQuery);
    if (startIndex == -1) {
      return TextSpan(text: title, style: TextStyle(color: baseColor));
    }

    final beforeMatch = title.substring(0, startIndex);
    final matchText = title.substring(startIndex, startIndex + query.length);
    final afterMatch = title.substring(startIndex + query.length);

    return TextSpan(
      children: [
        TextSpan(text: beforeMatch, style: TextStyle(color: baseColor)),
        TextSpan(
          text: matchText,
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(text: afterMatch, style: TextStyle(color: baseColor)),
      ],
    );
  }



  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<Video>>(
      future: Provider.of<KosaApi>(context).fetchVideos(),
      builder: (
          BuildContext context,
          AsyncSnapshot<List<Video>> snapshot,
          ) {
        if (snapshot.hasData && snapshot.data != null) {
          if (snapshot.data == null || snapshot.data?.length == 0) {
            return _buildError(context, new Exception(I18n.get("No Videos Found.")), IconName.book);
          }

          if (allVideos.isEmpty) {
            allVideos = List.from(snapshot.data!);
            sortedVideoList = List.from(allVideos);
          }

          return buildTabController(context, sortedVideoList);
        } else if (snapshot.hasError) {
          //  TODO: Log the error
          log("Data from snapshot: ${snapshot.data.toString()}");
          return _buildError(context, snapshot.error!, IconName.error);
        } else {
          return _buildLoadingIndicator();
        }
      },
    );
  }

  DefaultTabController buildTabController(BuildContext context, List<Video> videoList) {
    final screenWidth = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 1,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        // appBar: AppBar(
        //   backgroundColor: Theme.of(context).colorScheme.background,
        //
        //   // title: Column(
        //   //   children: [
        //   //     // Row(
        //   //     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   //     //   children: [
        //   //     //     // InkWell(
        //   //     //     //   child: Text(I18n.get(
        //   //     //     //     "old_student"),
        //   //     //     //     style: TextStyle(color: Colors.red, fontSize: 19),
        //   //     //     //   ),
        //   //     //     // ),
        //   //     //     Text(I18n.get("library"),
        //   //     //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
        //   //     //     ),
        //   //     //     // IconButton(
        //   //     //     //   onPressed: () {},
        //   //     //     //   icon: Icon(
        //   //     //     //     Icons.search,
        //   //     //     //     color: Colors.brown.shade300,
        //   //     //     //     size: 25,
        //   //     //     //   ),
        //   //     //     // ),
        //   //     //   ],
        //   //     // ),
        //   //     Divider(color: Theme.of(context).colorScheme.onBackground, thickness: 1, height: 1, indent: 0, endIndent: 0)
        //   //   ],
        //   // ),
        //   bottom:
        // ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double totalWidth = constraints.maxWidth;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: totalWidth * 0.80,
                        child: Container(
                          // height: 40,
                          child: TextField(
                            controller: _searchController,
                            style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onPrimary),
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: I18n.get('Search video here..'),
                              hintStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                              prefixIcon: Icon(Icons.search, size: 20,color: Theme.of(context).colorScheme.onPrimary,),
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // 0.5% gap
                      SizedBox(width: totalWidth * 0.03),

                      // 9.5% width for Switch Button
                      SizedBox(
                        width: totalWidth * 0.17,
                        // height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              switch_AZ = !switch_AZ;
                              sortedVideoList.sort((a, b) {
                                final titleA = a.title.toLowerCase();
                                final titleB = b.title.toLowerCase();
                                return switch_AZ ? titleA.compareTo(titleB) : titleB.compareTo(titleA);
                              });
                              // is_selectedContainer = 'true';
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: Theme.of(context).colorScheme.primaryFixed,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              // side: BorderSide(color: Theme.of(context).colorScheme.onPrimary)

                            ),
                          ),
                          child: FittedBox(
                            child: Text(switch_AZ ? I18n.get('a-z') : I18n.get('z-a'),
                                style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.onPrimary)),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),


            SizedBox(height: 12,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Wrap(
                spacing: 6, // only between items
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        sortedVideoList.shuffle();
                        is_selectedButton = 'All';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      backgroundColor: is_selectedButton == I18n.get('All')
                          ?   Theme.of(context).colorScheme.inversePrimary : Theme.of(context).colorScheme.onBackground,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 1, // Optional: flat button look
                    ),
                    child: Text(I18n.get('All'),style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.onPrimary),),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      setState(() {
                        is_selectedButton = I18n.get('Pali');

                      });
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      backgroundColor: is_selectedButton == I18n.get('Pali') ?  Theme.of(context).colorScheme.inversePrimary : Theme.of(context).colorScheme.onBackground,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 1, // Optional: flat button look
                    ),
                    child: Text(I18n.get('Pali'),style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.onPrimary),),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      setState(() {
                        is_selectedButton = I18n.get('Vipassana');
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      backgroundColor:is_selectedButton == I18n.get('Vipassana')?  Theme.of(context).colorScheme.inversePrimary : Theme.of(context).colorScheme.onBackground,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 1, // Optional: flat button look
                    ),
                    child: Text(I18n.get('Vipassana'),style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.onPrimary),),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        sortedVideoList.sort((a, b) =>
                            DateTime.parse(b.createdAt).compareTo(DateTime.parse(a.createdAt)));
                        is_selectedButton = I18n.get('Newest');
                      });

                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      backgroundColor: is_selectedButton == I18n.get('Newest')?  Theme.of(context).colorScheme.inversePrimary : Theme.of(context).colorScheme.onBackground,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 1, // Optional: flat button look
                    ),
                    child: Text(I18n.get('Newest'),style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.onPrimary),),
                  ),
                ],
              ),
            ),

            TabBar(
              labelColor: Theme.of(context).colorScheme.onPrimary,
              unselectedLabelColor: Colors.black54,
              indicatorColor: Colors.red,
              splashFactory: NoSplash.splashFactory,
              tabs: [
                Tab(text: I18n.get("videos").toUpperCase())
              ],
              onTap: _onTabTapped,
            ),
            Expanded(
                child: buildVideoListView(videoList, screenWidth)
            ),
          ],
        ),
      ),
    );
  }

  void prefixVideoCategories(List<Video> videos) {
    if (videos[0] != Video.RECOMMENDED) {
      videos.insert(0, Video.RECOMMENDED);
    }
  }

  Widget buildVideoListView(List<Video> videos, double screenWidth) {
    if (videos.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Text(
            I18n.get('Not found'),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: videos.length,
      itemBuilder: (context, index) {
        final video = videos[index];

        return video == Video.RECOMMENDED
            ? buildCategory(video, context)
            : buildClickableVimeoPlayer(context, video, screenWidth);
      },
    );
  }

  Widget buildCategory(Video category, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(I18n.get(category.title),
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }

  GestureDetector buildClickableVimeoPlayer(BuildContext context, Video video, double screenWidth) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VimeoPlayerScreen(videoId: video.id),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        // width: screenWidth * 0.6, // 60% of screen width
        child: Column(
          children: [
            Container(
              // height: 150, // pairs with `screenWidth * 0.6`
                child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child:
                    ClipPath(
                        clipper: ShapeBorderClipper(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)
                          ),
                        ),
                        child: Image(
                            image: NetworkImage(video.thumbnailUrl),
                            fit: BoxFit.fill
                        )
                    )
                )
            ),

            Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 32.0),
                child: Text.rich(
                  _buildHighlightedText(
                    video.title,
                    _searchController.text,
                    Theme.of(context).colorScheme.onPrimary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                )
            ),
          ],
        ),
      ),
    );
  }

  // TODO: remove duplication from TodayScreen
  Widget _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  // TODO: remove duplication from TodayScreen
  Widget _buildError(BuildContext context, Object error, IconName iconName) {
    var errorMessage = I18n.get("try_again_later")
        + "\n\nError:\n"
        + error.toString()
        + "\n\nException Details:\n"
        + exceptionToString(error);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              PariyattiIcons.get(iconName),
              color: Theme.of(context).colorScheme.error,
            ),
          ),
          Text(
            errorMessage,
            style: TextStyle(
              inherit: true,
              color: Theme.of(context).colorScheme.onError,
              fontSize: 16.0,
            ),
          )
        ],
      ),
    );
  }

  String exceptionToString(Object error) {
    if (error is NoSuchMethodError) {
      return error.toString();
    }
    var exception = (error as Exception);
    if (exception.runtimeType is MissingRequiredKeysException)
    {
      var mrke = (exception as MissingRequiredKeysException);
      var s = mrke.missingKeys.toString() + " from "
          + mrke.message;
      return s;
    } else {
      return exception.toString();
    }
  }
}
