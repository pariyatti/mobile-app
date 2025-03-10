import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:patta/model/Video.dart';
import 'package:patta/ui/screens/library/VideoScreen.dart';
import 'package:patta/app/I18n.dart';


class LibraryScreen extends StatefulWidget {
  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  late Future<List<Video>> _videoList;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _videoList = fetchVideos();
  }

  Future<List<Video>> fetchVideos() async {
    final url = Uri.parse('https://kosa-staging.pariyatti.app/api/v1/library/videos.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map<Video>((video) => Video.fromJson(video)).toList();
    } else {
      throw Exception('Failed to load videos');
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              child: FutureBuilder<List<Video>>(
                future: _videoList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No videos available'));
                  }

                  final videos = snapshot.data!;
                  prefixVideoCategories(videos);
                  return buildVideoListView(videos, screenWidth);
                },
              ),
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
}

