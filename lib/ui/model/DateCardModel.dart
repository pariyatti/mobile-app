import 'package:patta/model/HumanDate.dart';

import 'CardModel.dart';

class DateCardModel extends CardModel {

  DateCardModel({
    required String id,
    required String url,
    required DateTime publishedAt,
    required bool isBookmarkable,
    required bool isShareable,
  }) : super(id, url, publishedAt, isBookmarkable, isShareable);

  @override
  List<Object?> get props => [id, url, publishedAt, isBookmarkable, isShareable];

  get humanDate => HumanDate(publishedAt).toString();
}
