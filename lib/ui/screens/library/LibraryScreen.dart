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

  @override
  void initState() {
    super.initState();
  }

  void _onTabTapped(int index) {
    setState(() {
      selectedTab = index;
    });
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
            return _buildError(context, new Exception("No Videos Found."), IconName.book);
          }
          return buildTabController(context, snapshot.data!);
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
            Divider(color: Theme.of(context).colorScheme.onBackground, thickness: 1, height: 1, indent: 0, endIndent: 0),
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

  ListView buildVideoListView(List<Video> videos, double screenWidth) {
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
              child: Text(
                video.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
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

