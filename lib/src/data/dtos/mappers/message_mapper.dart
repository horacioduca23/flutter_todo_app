import '../../../domain/message.dart';
import '../llm_remote_dto.dart';

extension MessageMapper on MessageDto {
  Message toModel() => Message(content: content);
}
