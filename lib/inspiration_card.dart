import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patta/data_model/inspiration_card.dart';

class InspirationCard extends StatelessWidget {
  final InspirationCardModel data;

  InspirationCard({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 12.0,
            ),
            child: Card(
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  8.0,
                ),
              ),
              child: ClipPath(
                clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      8.0,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 12.0,
                      ),
                      child: Text(
                        'Inspiration of the day'.toUpperCase(),
                        style: TextStyle(
                          inherit: true,
                          fontSize: 14.0,
                          color: Color(0xff999999),
                        ),
                      ),
                    ),
                    CachedNetworkImage(
                      placeholder: (context, url) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Icon(
                            Icons.error,
                            color: Color(0xff6d695f),
                          ),
                        ),
                      ),
                      imageUrl: data.imageUrl,
                      imageBuilder: (context, imageProvider) {
                        return Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                              child: Image(
                                image: imageProvider,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        data.text,
                        style: TextStyle(
                          inherit: true,
                          fontSize: 20.0,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Container(
                      color: Color(0xffdcd3c0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            child: MaterialButton(
                              padding: EdgeInsets.zero,
                              child: Icon(
                                Icons.bookmark,
                                color: Color(0xff6d695f),
                              ),
                              onPressed: () {},
                            ),
                          ),
                          Expanded(
                            child: MaterialButton(
                              padding: EdgeInsets.zero,
                              child: Icon(
                                CupertinoIcons.share_solid,
                                color: Color(0xff6d695f),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
