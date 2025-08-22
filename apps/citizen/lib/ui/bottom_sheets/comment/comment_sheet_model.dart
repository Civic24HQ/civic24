import 'package:models/models.dart';
import 'package:stacked/stacked.dart';

class CommentSheetModel extends BaseViewModel {
  CommentSheetModel(List<CommentData> comments) {
    _comments = comments;
  }

  List<CommentData> _comments = [];
  List<CommentData> get comments => _comments;
}
