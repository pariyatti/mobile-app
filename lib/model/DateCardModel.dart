import 'package:patta/model/HumanDate.dart';

import 'package:patta/model/CardModel.dart';

class DateCardModel extends CardModel {

  DateCardModel({
    required String id,
    required String url,
    required DateTime publishedDate,
    required DateTime publishedAt,
    required bool isBookmarkable,
    required bool isShareable,
  }) : super(id, url, publishedDate, publishedAt, isBookmarkable, isShareable);

  @override
  List<Object?> get props => [id, url, publishedDate, publishedAt, isBookmarkable, isShareable];

  get humanDate => HumanDate(publishedAt).toString();
}
