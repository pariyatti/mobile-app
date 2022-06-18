import 'package:patta/ui/model/CardModel.dart';

class NetworkErrorCardModel extends CardModel {
  final String? errorMsg;

  NetworkErrorCardModel({
    required String id,
    required String url,
    required bool isBookmarkable,
    required bool isShareable,
    this.errorMsg
  }) : super(id, url, isBookmarkable, isShareable);

  @override
  List<Object?> get props => [id, url, isBookmarkable, isShareable, errorMsg];

  static NetworkErrorCardModel create(errorMsg) {
    return NetworkErrorCardModel(id: "ERROR", url: "ERROR", isBookmarkable: false, isShareable: false, errorMsg: errorMsg);
  }
}
