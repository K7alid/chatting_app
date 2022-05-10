class MessageModel {
  late String dateTime;
  late String senderId;
  late String receiverId;
  late String text;

  MessageModel({
    required this.dateTime,
    required this.senderId,
    required this.receiverId,
    required this.text,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    dateTime = json['dateTime'];
    senderId = json['senderId'];
    text = json['text'];
    receiverId = json['receiverId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime,
      'senderId': senderId,
      'text': text,
      'receiverId': receiverId,
    };
  }
}
