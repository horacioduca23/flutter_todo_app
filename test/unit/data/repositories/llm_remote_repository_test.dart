import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_app/src/data/datasources/llm_remote_datasource.dart';
import 'package:flutter_todo_app/src/data/dtos/llm_remote_dto.dart';
import 'package:flutter_todo_app/src/data/repositories/llm_remote_repository.dart';
import 'package:flutter_todo_app/src/domain/choice.dart';
import 'package:flutter_todo_app/src/domain/llm_remote.dart';
import 'package:flutter_todo_app/src/domain/message.dart';
import 'package:mocktail/mocktail.dart';

class MockLlmRemoteDatasource extends Mock implements LlmRemoteDatasource {}

void main() {
  group('LlmRemoteRepository', () {
    late MockLlmRemoteDatasource mockDatasource;
    late LlmRemoteRepository repository;

    setUp(() {
      mockDatasource = MockLlmRemoteDatasource();
      repository = LlmRemoteRepository(llmRemoteDatasource: mockDatasource);
    });

    test(
      'fetchLlmRemoteDescription retorna el modelo esperado (caso éxito)',
      () async {
        const prompt = 'test prompt';
        final dto = LlmRemoteDto(
          choices: [ChoiceDto(message: MessageDto(content: 'contenido'))],
        );
        final expectedModel = LlmRemote(
          choices: [Choice(message: Message(content: 'contenido'))],
        );

        when(
          () => mockDatasource.fetchLlmResponse(prompt: prompt),
        ).thenAnswer((_) async => dto);

        final result = await repository.fetchLlmRemoteDescription(
          prompt: prompt,
        );

        expect(result.choices.length, expectedModel.choices.length);
        expect(
          result.choices.first.message.content,
          expectedModel.choices.first.message.content,
        );
        verify(() => mockDatasource.fetchLlmResponse(prompt: prompt)).called(1);
      },
    );

    test(
      'fetchLlmRemoteDescription propaga la excepción del datasource',
      () async {
        const prompt = 'test prompt';
        final exception = Exception('Datasource error');

        when(
          () => mockDatasource.fetchLlmResponse(prompt: prompt),
        ).thenThrow(exception);

        expect(
          () => repository.fetchLlmRemoteDescription(prompt: prompt),
          throwsA(exception),
        );
        verify(() => mockDatasource.fetchLlmResponse(prompt: prompt)).called(1);
      },
    );
  });
}
