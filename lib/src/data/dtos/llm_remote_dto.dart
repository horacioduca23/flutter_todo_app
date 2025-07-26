final class LlmRemoteDto {
  const LlmRemoteDto({required this.choices});

  factory LlmRemoteDto.fromJson(Map<String, dynamic> json) {
    final List<ChoiceDto> choices = (json['choices'] as List<dynamic>)
        .map((e) => ChoiceDto.fromJson(e as Map<String, dynamic>))
        .toList();

    return LlmRemoteDto(choices: choices);
  }

  final List<ChoiceDto> choices;

  MessageDto get firstMessage => choices.first.message;

  String get content => firstMessage.content;
}

final class ChoiceDto {
  const ChoiceDto({required this.message});

  factory ChoiceDto.fromJson(Map<String, dynamic> json) {
    return ChoiceDto(
      message: MessageDto.fromJson(json['message'] as Map<String, dynamic>),
    );
  }

  final MessageDto message;
}

final class MessageDto {
  const MessageDto({required this.content});

  factory MessageDto.fromJson(Map<String, dynamic> json) {
    return MessageDto(content: json['content'] as String);
  }

  final String content;
}
