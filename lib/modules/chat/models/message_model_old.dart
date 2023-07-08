enum MessageType { sender, receiver }

class Message {
  final String? text;
  final String? image;
  final MessageType type;

  const Message({this.text, this.image, required this.type});
}
