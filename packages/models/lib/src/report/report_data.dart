import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:constants/constants.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:models/utils/serializable_type.dart';
import 'package:models/utils/timestamp_converter.dart';

part 'report_data.freezed.dart';
part 'report_data.g.dart';

/// Represents a users report with various attributes.
@freezed
class ReportData with _$ReportData, SerializeJson {
  @JsonSerializable()
  const factory ReportData({
    /// Unique identifier for the report.
    required String reportId,

    /// FirstName of the user who created the report.
    required String firstName,

    /// LastName of the user who created the report.
    required String lastName,

    /// Country where the report was created.
    required String country,

    /// State where the report was created.
    required String state,

    /// The content of the report.
    required String content,

    /// Number of likes the report has received (aggregate).
    required int likeCount,

    /// Number of dislikes on the report (aggregate).
    required int dislikeCount,

    /// Number of comments on the report (aggregate).
    required int commentCount,

    /// Number of bookmarks for the report (aggregate).
    required int bookmarkCount,

    /// The date when the report was created.
    @TimestampConverter() required DateTime createdAt,

    /// The date when the report was last updated.
    @TimestampConverter() required DateTime updatedAt,

    /// The URL of the images or videos associated with the report.
    @Default([]) List<String>? media,

    /// The id of the user who created the report.
    String? userId,

    /// The image URL of the user who created the report.
    String? userImageUrl,

    /// The user’s preferred category types.
    /// Example: [CategoryType.waste, CategoryType.road].
    @Default([]) List<CategoryType> categoryTypes,

    /// The document reference path, only parsed
    /// when converted from Firestore.
    String? path,
  }) = _ReportData;
  const ReportData._();

  factory ReportData.fromJson(Map<String, dynamic> json) => _$ReportDataFromJson(json);

  /// Creates an unknown report instance.
  factory ReportData.unknown() => ReportData(
    reportId: '0',
    firstName: 'N/A',
    lastName: 'N/A',
    country: 'Location unknown',
    state: 'Region unknown',
    content: 'No content available',
    categoryTypes: [],
    likeCount: 0,
    dislikeCount: 0,
    commentCount: 0,
    bookmarkCount: 0,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  factory ReportData.empty() => ReportData(
    reportId: '',
    firstName: '',
    lastName: '',
    country: '',
    state: '',
    content: '',
    categoryTypes: [],
    likeCount: 0,
    dislikeCount: 0,
    commentCount: 0,
    bookmarkCount: 0,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  bool get basicInfoIsNotEmpty {
    return firstName.isNotEmpty && lastName.isNotEmpty && state.isNotEmpty && country.isNotEmpty;
  }

  String get fullName => '$firstName $lastName';

  String get location => '$state, $country';
}

/// Wraps a [ReportData] with the current user’s interaction state.
class ReportWithUserState {
  ReportWithUserState({
    required this.report,
    required this.hasLiked,
    required this.hasDisliked,
    required this.hasBookmarked,
  });
  final ReportData report;

  /// Whether the current user has liked this report.
  final bool hasLiked;

  /// Whether the current user has disliked this report.
  final bool hasDisliked;

  /// Whether the current user has bookmarked this report.
  final bool hasBookmarked;
}

extension ReportDataX on ReportData {
  /// Returns true if the report was created by a user.
  bool get isUserReportValid => userId != null;
}
