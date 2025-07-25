import 'package:flutter_todo_app/src/data/dtos/mappers/message_mapper.dart';

import '../../../domain/choice.dart';
import '../llm_remote_dto.dart';

extension ChoiceMapper on ChoiceDto {
  Choice toModel() => Choice(message: message.toModel());
}
