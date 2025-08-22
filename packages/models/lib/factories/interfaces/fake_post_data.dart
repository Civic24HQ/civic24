import 'dart:math';

import 'package:models/factories/fake_model.dart';
import 'package:models/models.dart';

class FakePostData extends FakeModel<PostData> {
  @override
  PostData generateFake() {
    final country = countryStates.keys.elementAt(Random().nextInt(countryStates.length));
    final states = countryStates[country]!;
    final state = states[Random().nextInt(states.length)];

    // final createdAt1 = randomDateTime();
    // final updated = createdAt1.add(Duration(minutes: rand.nextInt(240)));
    // final updatedAt1 = updated.isAfter(DateTime.now()) ? DateTime.now() : updated;

    final imageUrl = takeUniqueImageUrl();
    final g = genderFromUrl(imageUrl);

    final firstName = pickFirstName(g);
    final lastName = pickLastName();

    final createdAt2 = faker.date.dateTimeBetween(DateTime(2025), DateTime.now());
    final updatedAt2 = faker.date.dateTimeBetween(createdAt2, DateTime.now());

    return PostData(
      id: fakeUuid,
      firstName: firstName,
      lastName: lastName,
      // firstName: faker.person.firstName(),
      // lastName: faker.person.lastName(),
      country: country,
      state: state,
      // country: faker.address.country(),
      // state: faker.address.state(),
      content: fakeContent[Random().nextInt(fakeContent.length)],
      likeCount: faker.randomGenerator.integer(100),
      dislikeCount: faker.randomGenerator.integer(100),
      commentCount: faker.randomGenerator.integer(100),
      bookmarkCount: faker.randomGenerator.integer(100),
      // createdAt: createdAt1,
      // updatedAt: updatedAt1,
      // createdAt: faker.date.dateTime(minYear: 2025, maxYear: 2025).subtract(Duration(days: Random().nextInt(300) + 5)),
      // updatedAt: faker.date.dateTime(minYear: 2025, maxYear: 2025).subtract(Duration(days: Random().nextInt(300) + 5)),
      createdAt: createdAt2,
      updatedAt: updatedAt2,
      media: fakeMedia.take(4).toList()..shuffle(),
      userId: fakeUuid,
      userImageUrl: imageUrl,
      // userImageUrl: faker.image.loremPicsum(),
      path: 'posts/$fakeUuid',
    );
  }

  @override
  List<PostData> generateFakeList({required int length}) {
    return List.generate(length, (index) => generateFake());
  }
}

List<PostData> fakePostDataList = FakePostData().generateFakeList(length: 10)
  ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
