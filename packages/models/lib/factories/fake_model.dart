import 'dart:math';
import 'package:faker/faker.dart';
import 'package:uuid/uuid.dart';

final rand = Random();

enum Gender { male, female }

List<String> fakeContent = [
  'A recurring issue in this area has been reported, disrupting daily routines and creating risks for residents and commuters alike. This situation cannot be ignored any longer. Add your support to ensure it gets the urgent attention it deserves.',
  'This challenge has lingered for months, gradually affecting families, workers, and local businesses. Without intervention, the community will continue to bear the cost. Voting for this report shows how critical it is for change to happen now.',
  'Residents continue to face obstacles because of this unresolved problem, which impacts movement, safety, and peace of mind. By supporting this report, you help amplify the community’s call for prompt and lasting solutions.',
  'What happens here ripples far beyond this street—safety, livelihoods, and community wellbeing are being put at stake. This report gives everyone a chance to stand together. Your vote will strengthen the case for immediate intervention.',
  'This isn’t just a minor inconvenience; it has become a persistent issue that touches everyone in one way or another. Supporting this report highlights that it matters to the entire community, not just a few individuals.',
  'For too long this matter has been overlooked, leaving residents frustrated and exposed to risks. We believe collective action can make a difference. Join in by voting so this issue gets the visibility it demands.',
  'Everyday life from commuting to running a business is being disrupted by this ongoing situation. If more people lend their voice, it will be harder for those in power to ignore. Cast your vote today to push for urgent action.',
  'This report draws attention to a challenge that undermines both safety and progress in the community. The more support it gathers, the stronger the push for authorities to prioritize it. Add your voice to this call for change.',
  'Residents have shown patience, but this problem has persisted far too long. It not only slows growth but puts lives at risk. Supporting this report demonstrates that the community stands united in demanding immediate solutions.',
  'We cannot keep treating this issue as background noise. It is a serious problem that affects present wellbeing and the future of the neighborhood. By voting, you help emphasize its urgency and push it higher on the agenda.',
  'Businesses are losing customers, children are exposed to hazards, and families are inconvenienced daily because of this ongoing challenge. With enough support, this report can draw the attention of the people who can fix it.',
  'This is more than a one off incident; it’s a recurring breakdown that threatens the community’s stability. Every additional vote proves that residents care deeply about resolving it. Together, we can make our concerns impossible to ignore.',
  'Ignoring this issue will only allow it to worsen, costing more time, money, and safety in the long run. Supporting this report is the first step toward accountability and tangible solutions that benefit everyone.',
  'This situation has turned into a visible sign of neglect, frustrating everyone who passes through this area. It’s time for action. Add your support and help bring this report to the forefront of community priorities.',
  'Community wellbeing depends on addressing issues like this quickly and effectively. With enough collective backing, the problem can no longer be sidelined. Vote now to show that urgent action is not just requested but required.',
];

List<String> fakeComment = [
  'This has been a long standing problem',
  'We really need the authorities to step in and fix this soon',
  'I’ve been affected by this too 🥲',
  'Glad someone finally reported this',
  'This is something we can’t keep ignoring.',
  'I see this issue every day on my way to work',
  'Honestly, this needs urgent attention',
  'Can’t believe nothing has been done yet',
  'Thanks for bringing this up 🙏',
  'It’s getting worse by the day',
  'So many people are affected by this',
  'We deserve better than this situation',
  'It’s about time this was fixed',
  'I hope this gets resolved quickly',
  'This shouldn’t be happening in 2025',
  'The community has been patient enough',
  'Really frustrating to keep seeing this',
  'This is putting everyone at risk',
  'It’s costing people more than they realize',
  'Something must change soon ⚠️',
];

List<String> fakeMedia = [
  'https://i.imghippo.com/files/kVud2761dtM.jpeg',
  'https://i.imghippo.com/files/TxM1158HiY.jpg',
  'https://i.imghippo.com/files/gkG1737BQ.jpg',
  'https://i.imghippo.com/files/Yf7041g.jpg',
  'https://i.imghippo.com/files/hNi2540CE.jpg',
  'https://i.imghippo.com/files/Xd4722FQ.jpg',
  'https://i.imghippo.com/files/eIv6463Sc.jpeg',
  'https://i.imghippo.com/files/ay1655RTE.jpg',
  'https://i.imghippo.com/files/bAXP3405rp.jpg',
  'https://i.imghippo.com/files/GJvD3698RM.jpg',
];

List<String> fakeNotificationTitle = [
  '🎉 Report Submitted',
  '🔔 What Do You Think?',
  '📍 Spot Something? Say Something',
  '🔔 What Do You Think?',
  '🎉 Report Submitted',
  '📍 Spot Something? Say Something',
  '🎉 Report Submitted',
  '🔔 What Do You Think?',
  '📍 Spot Something? Say Something',
  '🔔 What Do You Think?',
];

List<String> fakeNotificationDesc = [
  'You’ve just made your fist civic impact! Your report is now live and visible to the community',
  'New reports need your voice! Give a thumbs up or down to support or highlight pressing issues',
  'Haven’t reported anything lately? Help your community by flagging issues you notice around you',
  'New reports need your voice! Give a thumbs up or down to support or highlight pressing issues',
  'You’ve just made your fist civic impact! Your report is now live and visible to the community',
  'Haven’t reported anything lately? Help your community by flagging issues you notice around you',
  'You’ve just made your fist civic impact! Your report is now live and visible to the community',
  'New reports need your voice! Give a thumbs up or down to support or highlight pressing issues',
  'Haven’t reported anything lately? Help your community by flagging issues you notice around you',
  'New reports need your voice! Give a thumbs up or down to support or highlight pressing issues',
];

final Map<String, List<String>> countryStates = {
  'United States': [
    'Alabama',
    'Alaska',
    'Arizona',
    'Arkansas',
    'California',
    'Colorado',
    'Connecticut',
    'Delaware',
    'Florida',
    'Georgia',
    'Hawaii',
    'Idaho',
    'Illinois',
    'Indiana',
    'Iowa',
    'Kansas',
    'Kentucky',
    'Louisiana',
    'Maine',
    'Maryland',
    'Massachusetts',
    'Michigan',
    'Minnesota',
    'Mississippi',
    'Missouri',
    'Montana',
    'Nebraska',
    'Nevada',
    'New Hampshire',
    'New Jersey',
    'New Mexico',
    'New York',
    'North Carolina',
    'North Dakota',
    'Ohio',
    'Oklahoma',
    'Oregon',
    'Pennsylvania',
    'Rhode Island',
    'South Carolina',
    'South Dakota',
    'Tennessee',
    'Texas',
    'Utah',
    'Vermont',
    'Virginia',
    'Washington',
    'West Virginia',
    'Wisconsin',
    'Wyoming',
    'District of Columbia',
  ],

  'United Kingdom': [
    'England',
    'Scotland',
    'Wales',
    'Northern Ireland',
    'Greater London',
    'South East',
    'South West',
    'North West',
    'North East',
    'West Midlands',
    'East Midlands',
    'Yorkshire and the Humber',
    'East of England',
  ],

  'Canada': [
    'Alberta',
    'British Columbia',
    'Manitoba',
    'New Brunswick',
    'Newfoundland and Labrador',
    'Nova Scotia',
    'Ontario',
    'Prince Edward Island',
    'Quebec',
    'Saskatchewan',
    'Northwest Territories',
    'Nunavut',
    'Yukon',
  ],
  'Nigeria': [
    'Abia',
    'Adamawa',
    'Akwa Ibom',
    'Anambra',
    'Bauchi',
    'Bayelsa',
    'Benue',
    'Borno',
    'Cross River',
    'Delta',
    'Ebonyi',
    'Edo',
    'Ekiti',
    'Enugu',
    'Gombe',
    'Imo',
    'Jigawa',
    'Kaduna',
    'Kano',
    'Katsina',
    'Kebbi',
    'Kogi',
    'Kwara',
    'Lagos',
    'Nasarawa',
    'Niger',
    'Ogun',
    'Ondo',
    'Osun',
    'Oyo',
    'Plateau',
    'Rivers',
    'Sokoto',
    'Taraba',
    'Yobe',
    'Zamfara',
    'Federal Capital Territory',
  ],
};

final List<String> femaleFirstNames = [
  'Amara',
  'Chidinma',
  'Fatima',
  'Grace',
  'Hannah',
  'Isabella',
  'Jade',
  'Kemi',
  'Linda',
  'Maya',
  'Naomi',
  'Olivia',
  'Precious',
  'Ruth',
  'Sophia',
];

final List<String> maleFirstNames = [
  'Abdul',
  'Benjamin',
  'Chinedu',
  'David',
  'Emeka',
  'Femi',
  'Gabriel',
  'Hassan',
  'Ibrahim',
  'Jason',
  'Kunle',
  'Leo',
  'Michael',
  'Nathan',
  'Samuel',
];

final List<String> lastNames = [
  'Adeyemi',
  'Bello',
  'Chukwu',
  'Daniels',
  'Eze',
  'Fowler',
  'Garcia',
  'Hughes',
  'Ike',
  'Johnson',
  'Khan',
  'Lopez',
  'Martins',
  'Okafor',
  'Smith',
];

final List<String> userImageUrls = [
  'https://randomuser.me/api/portraits/women/0.jpg',
  'https://randomuser.me/api/portraits/women/1.jpg',
  'https://randomuser.me/api/portraits/women/2.jpg',
  'https://randomuser.me/api/portraits/women/3.jpg',
  'https://randomuser.me/api/portraits/women/4.jpg',
  'https://randomuser.me/api/portraits/men/0.jpg',
  'https://randomuser.me/api/portraits/men/1.jpg',
  'https://randomuser.me/api/portraits/men/2.jpg',
  'https://randomuser.me/api/portraits/men/3.jpg',
  'https://randomuser.me/api/portraits/men/4.jpg',
];

// DateTime _randomDateTime({int maxMinutes = 60 * 24 * 90}) {
//   final minsAgo = _rand.nextInt(maxMinutes) + 1;
//   return DateTime.now().subtract(Duration(minutes: minsAgo));
// }

Gender genderFromUrl(String url) {
  if (url.contains('/women/')) return Gender.female;
  if (url.contains('/men/')) return Gender.male;
  return rand.nextBool() ? Gender.male : Gender.female;
}

String pickFirstName(Gender g) {
  final pool = g == Gender.female ? femaleFirstNames : maleFirstNames;
  return pool[rand.nextInt(pool.length)];
}

final _availableImages = List<String>.from(userImageUrls)..shuffle();
String takeUniqueImageUrl() {
  if (_availableImages.isEmpty) {
    _availableImages
      ..addAll(userImageUrls)
      ..shuffle();
  }
  return _availableImages.removeLast();
}

String takeUniqueContent() {
  if (fakeContent.isEmpty) {
    fakeContent
      ..addAll(fakeComment)
      ..shuffle();
  }
  return fakeContent.removeLast();
}

List<String> takeUniqueMedia() {
  if (fakeMedia.isEmpty) {
    fakeMedia
      ..addAll(fakeMedia)
      ..shuffle();
  }
  return [fakeMedia.removeLast()];
}

String takeUniqueNotificationTitle() {
  if (fakeNotificationTitle.isEmpty) {
    fakeNotificationTitle
      ..addAll(fakeNotificationTitle)
      ..shuffle();
  }
  return fakeNotificationTitle.removeLast();
}

String takeUniqueNotificationDesc() {
  if (fakeNotificationDesc.isEmpty) {
    fakeNotificationDesc
      ..addAll(fakeNotificationDesc)
      ..shuffle();
  }
  return fakeNotificationDesc.removeLast();
}

String pickLastName() => lastNames[rand.nextInt(lastNames.length)];

abstract class FakeModel<T> {
  Faker get faker => Faker();

  /// Creates a fake uuid.
  String get fakeUuid => const Uuid().v4();

  /// Generate fake list based on provided length.
  List<T> generateFakeList({required int length}) {
    return List.generate(length, (index) => generateFake());
  }

  /// Generate a single fake model.
  T generateFake();
}
