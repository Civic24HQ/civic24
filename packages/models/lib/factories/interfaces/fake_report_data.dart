import 'dart:math';

import 'package:constants/constants.dart';
import 'package:models/factories/fake_model.dart';
import 'package:models/models.dart';

class FakeReportData extends FakeModel<ReportData> {
  @override
  ReportData generateFake() {
    final country = countryStates.keys.elementAt(Random().nextInt(countryStates.length));
    final states = countryStates[country]!;
    final state = states[Random().nextInt(states.length)];

    final imageUrl = takeUniqueImageUrl();
    final content = takeUniqueContent();
    final media = takeUniqueMedia();
    final g = genderFromUrl(imageUrl);

    final firstName = pickFirstName(g);
    final lastName = pickLastName();

    final createdAt2 = faker.date.dateTimeBetween(DateTime(2025), DateTime.now());
    final updatedAt2 = faker.date.dateTimeBetween(createdAt2, DateTime.now());

    return ReportData(
      reportId: fakeUuid,
      firstName: firstName,
      lastName: lastName,
      country: country,
      state: state,
      // country: faker.address.country(),
      // state: faker.address.state(),
      content: content,
      type: CategoryType.values[Random().nextInt(CategoryType.values.length)],
      likeCount: faker.randomGenerator.integer(100),
      dislikeCount: faker.randomGenerator.integer(100),
      commentCount: faker.randomGenerator.integer(100),
      bookmarkCount: faker.randomGenerator.integer(100),
      createdAt: createdAt2,
      updatedAt: updatedAt2,
      media: media,
      userId: fakeUuid,
      userImageUrl: imageUrl,
      path: 'reports/$fakeUuid',
    );
  }

  @override
  List<ReportData> generateFakeList({required int length}) {
    return List.generate(length, (index) => generateFake());
  }
}

// Returns a list of fake report data
List<ReportData> fakeReportDataList = FakeReportData().generateFakeList(length: 10)
  ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

// Returns a list of fake report data descending by likeCount with the tie-break by commentCount and then most recent
final List<ReportData> fakeReportDataTrendingList = [...fakeReportDataList]
  ..sort((a, b) {
    final byLikes = b.likeCount.compareTo(a.likeCount);
    if (byLikes != 0) return byLikes;
    final byComments = b.commentCount.compareTo(a.commentCount);
    if (byComments != 0) return byComments;
    return b.updatedAt.compareTo(a.updatedAt);
  });

List<ReportData> sortByTrending(List<ReportData> list) => [...list]
  ..sort((a, b) {
    final byLikes = b.likeCount.compareTo(a.likeCount);
    if (byLikes != 0) return byLikes;
    final byComments = b.commentCount.compareTo(a.commentCount);
    if (byComments != 0) return byComments;
    return b.updatedAt.compareTo(a.updatedAt);
  });

List<ReportData> byCategory(CategoryType type, List<ReportData> list) =>
    list.where((r) => r.type == type).toList()..sort((a, b) => b.createdAt.compareTo(a.createdAt));
