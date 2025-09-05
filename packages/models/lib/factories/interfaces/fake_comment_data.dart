import 'dart:math';

import 'package:models/factories/fake_model.dart';
import 'package:models/models.dart';

class FakeCommentData extends FakeModel<CommentData> {
  @override
  CommentData generateFake() {
    final imageUrl = takeUniqueImageUrl();
    final g = genderFromUrl(imageUrl);

    final firstName = pickFirstName(g);
    final lastName = pickLastName();

    final createdAt = faker.date.dateTimeBetween(DateTime(2025), DateTime.now());
    final updatedAt = faker.date.dateTimeBetween(createdAt, DateTime.now());

    return CommentData(
      commentId: fakeUuid,
      reportId: fakeUuid,
      firstName: firstName,
      lastName: lastName,
      comment: fakeComment[Random().nextInt(fakeComment.length)],
      likeCount: faker.randomGenerator.integer(100),
      createdAt: createdAt,
      updatedAt: updatedAt,
      userId: fakeUuid,
      userImageUrl: imageUrl,
      path: 'comments/$fakeUuid',
    );
  }

  @override
  List<CommentData> generateFakeList({required int length}) {
    return List.generate(length, (index) => generateFake());
  }
}

List<CommentData> fakeCommentDataList = FakeCommentData().generateFakeList(length: 10)
  ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
