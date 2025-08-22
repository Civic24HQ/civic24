import 'dart:math';
import 'package:faker/faker.dart';
import 'package:uuid/uuid.dart';

final rand = Random();

enum Gender { male, female }

List<String> fakeContent = [
  'A major issue has been reported in this area, affecting daily life and putting people at risk. Community support is needed to draw urgent attention. If this concerns you too, vote to support this report.',
  'This report highlights an ongoing challenge that affects the quality of life here. With enough support, it can reach those who have the power to resolve it. Vote if you believe change is needed',
  'This situation continues to disrupt residents, businesses, and commuters in the community. It requires prompt action from the relevant authorities.',
  'What happens here affects the wider community safety, movement, and wellbeing are at stake. Voting for this report strengthens the case for urgent intervention.',
  'This issue doesn’t just inconvenience a few; it impacts everyone around. Collective action starts with awareness. If this matters to you too, kindly add a comment and vote to support this report.',
];

List<String> fakeComment = [
  'This has been a long-standing problem, thanks for bringing it up',
  'We really need the authorities to step in and fix this soon',
  'I’ve been affected by this too, it’s getting worse every day.',
  'Glad someone finally reported this—many people are tired of it.',
  'This is something our community can’t keep ignoring.',
];

List<String> fakeMedia = [
  'https://i.imghippo.com/files/kVud2761dtM.jpeg',
  'https://i.imghippo.com/files/TxM1158HiY.jpg',
  'https://i.imghippo.com/files/gkG1737BQ.jpg',
  'https://i.imghippo.com/files/Yf7041g.jpg',
  'https://i.imghippo.com/files/hNi2540CE.jpg',
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
