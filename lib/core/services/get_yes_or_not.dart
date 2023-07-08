import 'package:dio/dio.dart';
import 'package:flutter_tutorial/modules/chat/models/message_model_old.dart';

class GetYesOrNot {
  final _dio = Dio();
  Future<Message> getYesOrNot() async {
    final response = await _dio.get('https://yesno.wtf/api');
    if (response.statusCode == 200) {
      return Message(
          text: response.data['answer'],
          type: MessageType.receiver,
          image: response.data['image']);
    }

    return Message(text: 'Yes', type: MessageType.sender);
  }
}
