import 'dart:math';

import 'package:models/factories/fake_model.dart';
import 'package:models/models.dart';

class FakeNotificationData extends FakeModel<NotificationData> {
  @override
  NotificationData generateFake() {
    final createdAt = faker.date.dateTimeBetween(DateTime(2025), DateTime.now());
    final updatedAt = faker.date.dateTimeBetween(createdAt, DateTime.now());

    return NotificationData(
      notificationId: '0',
      title: takeUniqueNotificationTitle(),
      hasBeenSeen: rand.nextBool(),
      description: fakeComment[Random().nextInt(fakeComment.length)],
      notificationIconData: takeUniqueNotificationDesc(),
      createdAt: createdAt,
      updatedAt: updatedAt,
      userId: fakeUuid,
      path: 'notification/$fakeUuid',
    );
  }

  @override
  List<NotificationData> generateFakeList({required int length}) {
    return List.generate(length, (index) => generateFake());
  }
}

List<NotificationData> fakeNotificationDataList = FakeNotificationData().generateFakeList(length: 10)
  ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
