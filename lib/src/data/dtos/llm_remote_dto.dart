// final class LlmRemoteDto {
//   const LlmRemoteDto({
//     required this.id,
//     required this.object,
//     required this.created,
//     required this.model,
//     required this.choices,
//     required this.usage,
//     required this.systemFingerprint,
//   });

//   factory LlmRemoteDto.fromJson(Map<String, dynamic> json) {
//     return LlmRemoteDto(
//       id: json['id'] as String,
//       object: json['object'] as String,
//       created: json['created'] as int,
//       model: json['model'] as String,
//       choices: (json['choices'] as List<dynamic>)
//           .map((e) => ChoiceDto.fromJson(e as Map<String, dynamic>))
//           .toList(),
//       usage: UsageDto.fromJson(json['usage'] as Map<String, dynamic>),
//       systemFingerprint: json['system_fingerprint'] as String,
//     );
//   }

//   final String id;
//   final String object;
//   final int created;
//   final String model;
//   final List<ChoiceDto> choices;
//   final UsageDto usage;
//   final String systemFingerprint;
// }

// class ChoiceDto {
//   const ChoiceDto({
//     required this.index,
//     required this.message,
//     required this.finishReason,
//     required this.contentFilterResults,
//   });

//   factory ChoiceDto.fromJson(Map<String, dynamic> json) {
//     return ChoiceDto(
//       index: json['index'] as int,
//       message: MessageDto.fromJson(json['message'] as Map<String, dynamic>),
//       finishReason: json['finish_reason'] as String,
//       contentFilterResults: ContentFilterResultsDto.fromJson(
//         json['content_filter_results'] as Map<String, dynamic>,
//       ),
//     );
//   }

//   final int index;
//   final MessageDto message;
//   final String finishReason;
//   final ContentFilterResultsDto contentFilterResults;
// }

// class MessageDto {
//   const MessageDto({required this.role, required this.content});

//   factory MessageDto.fromJson(Map<String, dynamic> json) {
//     return MessageDto(
//       role: json['role'] as String,
//       content: json['content'] as String,
//     );
//   }

//   final String role;
//   final String content;
// }

// class ContentFilterResultsDto {
//   const ContentFilterResultsDto({
//     required this.hate,
//     required this.selfHarm,
//     required this.sexual,
//     required this.violence,
//     required this.jailbreak,
//     required this.profanity,
//   });

//   factory ContentFilterResultsDto.fromJson(Map<String, dynamic> json) {
//     return ContentFilterResultsDto(
//       hate: FilterResultDto.fromJson(json['hate'] as Map<String, dynamic>),
//       selfHarm: FilterResultDto.fromJson(
//         json['self_harm'] as Map<String, dynamic>,
//       ),
//       sexual: FilterResultDto.fromJson(json['sexual'] as Map<String, dynamic>),
//       violence: FilterResultDto.fromJson(
//         json['violence'] as Map<String, dynamic>,
//       ),
//       jailbreak: FilterResultWithDetectedDto.fromJson(
//         json['jailbreak'] as Map<String, dynamic>,
//       ),
//       profanity: FilterResultWithDetectedDto.fromJson(
//         json['profanity'] as Map<String, dynamic>,
//       ),
//     );
//   }

//   final FilterResultDto hate;
//   final FilterResultDto selfHarm;
//   final FilterResultDto sexual;
//   final FilterResultDto violence;
//   final FilterResultWithDetectedDto jailbreak;
//   final FilterResultWithDetectedDto profanity;
// }

// class FilterResultDto {
//   const FilterResultDto({required this.filtered});

//   factory FilterResultDto.fromJson(Map<String, dynamic> json) {
//     return FilterResultDto(filtered: json['filtered'] as bool);
//   }

//   final bool filtered;
// }

// class FilterResultWithDetectedDto extends FilterResultDto {
//   const FilterResultWithDetectedDto({
//     required super.filtered,
//     required this.detected,
//   });

//   factory FilterResultWithDetectedDto.fromJson(Map<String, dynamic> json) {
//     return FilterResultWithDetectedDto(
//       filtered: json['filtered'] as bool,
//       detected: json['detected'] as bool,
//     );
//   }

//   final bool detected;
// }

// class UsageDto {
//   const UsageDto({
//     required this.promptTokens,
//     required this.completionTokens,
//     required this.totalTokens,
//   });

//   factory UsageDto.fromJson(Map<String, dynamic> json) {
//     return UsageDto(
//       promptTokens: json['prompt_tokens'] as int,
//       completionTokens: json['completion_tokens'] as int,
//       totalTokens: json['total_tokens'] as int,
//     );
//   }

//   final int promptTokens;
//   final int completionTokens;
//   final int totalTokens;
// }

// class LlmMessageDto {
//   const LlmMessageDto({required this.content});

//   factory LlmMessageDto.fromJson(Map<String, dynamic> json) {
//     final Map<String, dynamic> firstChoice =
//         (json['choices'] as List).first as Map<String, dynamic>;
//     final Map<String, dynamic> message =
//         firstChoice['message'] as Map<String, dynamic>;
//     return LlmMessageDto(content: message['content'] as String);
//   }

//   final String content;
// }

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
