import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:patta/api/converter/today_converter.dart' as today_converter;
import 'package:patta/model/OverlayInspirationCardModel.dart';
import 'package:patta/model/PaliWordCardModel.dart';
import 'package:patta/model/StackedInspirationCardModel.dart';
import 'package:patta/model/Translations.dart';

void main() {
  test('Test whether sample today api is parsed correctly or not', () {
    // setup
    const baseUrl = 'https://localhost:3000';

    //workaround for https://github.com/flutter/flutter/issues/20907
    String getContents(String filePath) {
      var dir = Directory.current.path;
      if (dir.endsWith('${Platform.pathSeparator}test')) {
        return File('$dir/$filePath').readAsStringSync();
      }
      return File('$dir/test/$filePath').readAsStringSync();
    }

    //get the contents from the file
    final responseJson = getContents('responseJson.json');

    // method to be tested
    final cardModels = today_converter.convertJsonToCardModels(
        jsonDecode(responseJson), baseUrl);

    // check the results to be the models that we expect them to be
    expect(
      cardModels[0],
      PaliWordCardModel(
        id: '98955ba9-3819-4662-bd7c-6bff3d035d6e',
        url: '$baseUrl/api/v1/today/pali-words/98955ba9-3819-4662-bd7c-6bff3d035d6e.json',
        publishedDate: DateTime(2020, 4, 27),
        publishedAt: DateTime.parse("2020-04-27T00:00:00.000Z"),
        isBookmarkable: true,
        isShareable: true,
        header: 'Pāli Word of the Day',
        pali: 'kosa',
        audioUrl:
            '$baseUrl/uploads/cards/pali_word_card/audio/98955ba9-3819-4662-bd7c-6bff3d035d6e',
        translation: 'storehouse',
        translations: Translations({"eng": "storehouse"}),
      ),
    );

    expect(
      cardModels[1],
      StackedInspirationCardModel(
        id: 'b4285e6a-ea3c-4fc1-a7f4-4de3f1ed8ca4',
        url: '$baseUrl/api/v1/today/stacked-inspirations/b4285e6a-ea3c-4fc1-a7f4-4de3f1ed8ca4.json',
        publishedDate: DateTime(2020, 4, 27),
        publishedAt: DateTime.parse("2020-04-27T00:00:00.000Z"),
        isBookmarkable: true,
        isShareable: true,
        header: 'Inspiration of the Day',
        text:
            """ Enjoy some beautiful red flowers on the ground did you know you can also turn them into jam but you have to dry them on your rootop first which maybe you don't have the time for and you'd rather buy jam from a store.""",
        imageUrl:
            '$baseUrl/uploads/cards/stacked_inspiration_card/image/b4285e6a-ea3c-4fc1-a7f4-4de3f1ed8ca4/bluesky.png',
      ),
    );

    expect(
      cardModels[2],
      OverlayInspirationCardModel(
        id: 'f9a2cc0f-915f-4a9a-a049-77bbb9be1fc7',
        url: '$baseUrl/api/v1/today/overlay-inspirations/f9a2cc0f-915f-4a9a-a049-77bbb9be1fc7.json',
        publishedDate: DateTime(2020, 5, 2),
        publishedAt: DateTime.parse("2020-05-02T00:00:00.000Z"),
        isBookmarkable: true,
        isShareable: true,
        header: 'Inspiration of the Day',
        textColor: '#FFFFFF',
        text:
            """This card has a Peepal leaf on it because if there's one thing we know about meditation it's that it involves a lot of Peepal leaves, right?""",
        imageUrl:
            '$baseUrl/uploads/cards/overlay_inspiration_card/image/f9a2cc0f-915f-4a9a-a049-77bbb9be1fc7/leaf.jpg',
      ),
    );
  });
}
