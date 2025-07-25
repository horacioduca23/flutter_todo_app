import 'choice.dart';
import 'message.dart';

final class LlmRemote {
  const LlmRemote({required this.choices});

  final List<Choice> choices;

  Message get firstMessage => choices.first.message;

  String get content => firstMessage.content;
}
