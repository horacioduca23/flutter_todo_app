import '../../../domain/choice.dart';
import '../llm_remote_dto.dart';
import 'message_mapper.dart';

extension ChoiceMapper on ChoiceDto {
  Choice toModel() => Choice(message: message.toModel());
}
