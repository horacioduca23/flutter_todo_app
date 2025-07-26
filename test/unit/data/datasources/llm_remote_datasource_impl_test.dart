import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_app/src/data/datasources/llm_remote_datasource_impl.dart';
import 'package:flutter_todo_app/src/data/dtos/llm_remote_dto.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group('LlmRemoteDatasourceImpl', () {
    late MockClient mockClient;
    late LlmRemoteDatasourceImpl datasource;
    const fakeApiKey = 'FAKE_API_KEY';
    final fakeUri = Uri.parse(
      'https://router.huggingface.co/v1/chat/completions',
    );

    setUp(() async {
      mockClient = MockClient();
      TestWidgetsFlutterBinding.ensureInitialized();
      dotenv.testLoad(fileInput: 'HUGGING_FACE_API_KEY=$fakeApiKey');
      datasource = LlmRemoteDatasourceImpl();
      datasource.client = mockClient;
    });

    test(
      'fetchLlmResponse retorna LlmRemoteDto si la respuesta es 200',
      () async {
        const prompt = 'Hola!';
        const title = 'Título de prueba';
        final fakeResponse = {
          'choices': [
            {
              'message': {'content': 'respuesta generada'},
            },
          ],
        };
        when(
          () => mockClient.post(
            fakeUri,
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => http.Response(jsonEncode(fakeResponse), 200));

        final result = await datasource.fetchLlmResponse(
          title: title,
          prompt: prompt,
        );
        expect(result, isA<LlmRemoteDto>());
        expect(result.choices.first.message.content, 'respuesta generada');
        verify(
          () => mockClient.post(
            fakeUri,
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).called(1);
      },
    );

    test(
      'fetchLlmResponse lanza excepción si la respuesta no es 200',
      () async {
        const prompt = 'Hola!';
        const title = 'Título de prueba';
        when(
          () => mockClient.post(
            fakeUri,
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => http.Response('Error', 500));

        expect(
          () => datasource.fetchLlmResponse(title: title, prompt: prompt),
          throwsA(isA<Exception>()),
        );
        verify(
          () => mockClient.post(
            fakeUri,
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).called(1);
      },
    );
  });
}
