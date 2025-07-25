import 'package:flutter_todo_app/src/data/dtos/mappers/choice_mapper.dart';

import '../../../domain/llm_remote.dart';
import '../llm_remote_dto.dart';

extension LlmRemoteMapper on LlmRemoteDto {
  LlmRemote toModel() =>
      LlmRemote(choices: choices.map((dto) => dto.toModel()).toList());
}
