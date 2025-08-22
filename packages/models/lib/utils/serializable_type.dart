/// This mixin is used to serialize the object to JSON
/// and deserialize the object from JSON.
///
/// Mainly used for Firebase Firestore and other services.
mixin SerializeJson {
  Map<String, dynamic> toJson();
}
