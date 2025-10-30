import 'dart:math';

import 'package:constants/constants.dart';
import 'package:models/factories/fake_model.dart';
import 'package:models/models.dart';

class FakeReportData extends FakeModel<ReportWithUserState> {
  final Random rand = Random();

  @override
  ReportWithUserState generateFake() {
    final country = countryStates.keys.elementAt(rand.nextInt(countryStates.length));
    final states = countryStates[country]!;
    final state = states[rand.nextInt(states.length)];

    final imageUrl = takeUniqueImageUrl();
    final content = takeUniqueContent();
    final media = takeUniqueMedia();
    final g = genderFromUrl(imageUrl);

    final firstName = pickFirstName(g);
    final lastName = pickLastName();

    final createdAt2 = faker.date.dateTimeBetween(DateTime(2025), DateTime.now());
    final updatedAt2 = faker.date.dateTimeBetween(createdAt2, DateTime.now());

    final likeCount = faker.randomGenerator.integer(100);
    final dislikeCount = faker.randomGenerator.integer(100);
    final commentCount = faker.randomGenerator.integer(100);
    final bookmarkCount = faker.randomGenerator.integer(100);

    final reportData = ReportData(
      reportId: fakeUuid,
      firstName: firstName,
      lastName: lastName,
      country: country,
      state: state,
      content: content,
      categoryTypes: [CategoryType.values[rand.nextInt(CategoryType.values.length)]],
      likeCount: likeCount,
      dislikeCount: dislikeCount,
      commentCount: commentCount,
      bookmarkCount: bookmarkCount,
      createdAt: createdAt2,
      updatedAt: updatedAt2,
      media: media,
      userId: fakeUuid,
      userImageUrl: imageUrl,
      path: 'reports/$fakeUuid',
      // firstName: faker.person.firstName(),
      // lastName: faker.person.lastName(),
      // country: faker.address.country(),
      // state: faker.address.state(),
      // content: fakeContent[Random().nextInt(fakeContent.length)],
      // createdAt: createdAt1,
      // updatedAt: updatedAt1,
      // createdAt: faker.date.dateTime(minYear: 2025, maxYear: 2025).subtract(Duration(days: Random().nextInt(300) + 5)),
      // updatedAt: faker.date.dateTime(minYear: 2025, maxYear: 2025).subtract(Duration(days: Random().nextInt(300) + 5)),
    );

    // Randomly decide if this user liked, disliked or bookmarked the report.
    bool weightedBool([double trueProbability = 0.3]) => rand.nextDouble() < trueProbability;

    return ReportWithUserState(
      report: reportData,
      hasLiked: weightedBool(0.5),
      hasDisliked: weightedBool(0.6),
      hasBookmarked: weightedBool(),
    );
  }

  @override
  List<ReportWithUserState> generateFakeList({required int length}) {
    return List.generate(length, (index) => generateFake());
  }
}

// All fake reports sorted by creation date in a descending order
List<ReportWithUserState> fakeReportDataList = [];
// FakeReportData().generateFakeList(length: 10)
//   ..sort((a, b) => b.report.createdAt.compareTo(a.report.createdAt));

// Trending list considers user's likes, comments and bookmarks
final List<ReportWithUserState> fakeReportDataTrendingList = [];
// fakeReportDataList
//   ..sort((a, b) {
//     // Calculate a weighted score for trending based on the total likes, comments, bookmarks and whether the current user has interacted
//     int score(ReportWithUserState r) =>
//         r.report.likeCount +
//         r.report.commentCount +
//         r.report.bookmarkCount +
//         (r.hasLiked ? 5 : 0) +
//         (r.hasBookmarked ? 3 : 0);

//     return score(b).compareTo(score(a));
//   });

// Sort by trending reports
List<ReportWithUserState> sortByTrending(List<ReportWithUserState> list) => list
  ..sort((a, b) {
    int score(ReportWithUserState r) =>
        r.report.likeCount +
        r.report.commentCount +
        r.report.bookmarkCount +
        (r.hasLiked ? 5 : 0) +
        (r.hasBookmarked ? 3 : 0);

    return score(b).compareTo(score(a));
  });

// Filter reports by category sorted by creation date in a descending order
List<ReportWithUserState> byCategory(CategoryType type, List<ReportWithUserState> list) =>
    list.where((r) => r.report.categoryTypes.contains(type)).toList()
      ..sort((a, b) => b.report.createdAt.compareTo(a.report.createdAt));

// Filter reports by bookmark sorted by creation date in a descending order
List<ReportWithUserState> fakeReportDataBookmarkList = fakeReportDataList.where((r) => r.hasBookmarked).toList()
  ..sort((a, b) => b.report.createdAt.compareTo(a.report.createdAt));

// Filter reports by a user sorted by creation date in a descending order
List<ReportWithUserState> fakeReportDataUserList = fakeReportDataList.take(1).toList();
