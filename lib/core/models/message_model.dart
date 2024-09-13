
class MessageModel {
  String id;
  String title;
  String message;
  String timeStamp;
  String package;

  MessageModel({
    required this.id,
    required this.title,
    required this.message,
    required this.timeStamp,
    required this.package,
  });

  // Factory constructor for creating an instance from a map
  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id']??'',
      title: map['title']??'',
      message: map['message']??'',
      timeStamp: map['timeStamp']??'',
      package: map['package']??'',
    );
  }

  // Convert the model instance to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'timeStamp': timeStamp,
      'package': package,
    };
  }
}
