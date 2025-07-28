import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_app/src/core/network/network_utility.dart';
import 'package:flutter_todo_app/src/data/datasources/llm_remote_datasource_impl.dart';
import 'package:flutter_todo_app/src/data/dtos/llm_remote_dto.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockNetworkUtility extends Mock implements NetworkUtility {}

void main() {
  group('LlmRemoteDatasourceImpl', () {
    late MockNetworkUtility mockNetworkUtility;
    late LlmRemoteDatasourceImpl datasource;
    const fakeApiKey = 'FAKE_API_KEY';
    final fakeUri = Uri.parse(
      'https://router.huggingface.co/v1/chat/completions',
    );

    setUp(() async {
      mockNetworkUtility = MockNetworkUtility();
      TestWidgetsFlutterBinding.ensureInitialized();
      dotenv.testLoad(
        fileInput:
            'HUGGING_FACE_API_KEY=$fakeApiKey\nHUGGING_FACE_BASE_URL=https://router.huggingface.co/v1',
      );
      datasource = LlmRemoteDatasourceImpl(mockNetworkUtility);
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

        final expectedPayload = {
          "messages": [
            {"role": "user", "content": "$title\n$prompt"},
            {
              "role": "system",
              "content":
                  "Eres un asistente que responde siempre en texto plano, con máximo 5 viñetas o 3 oraciones breves.",
            },
          ],
          "model": "moonshotai/Kimi-K2-Instruct:novita",
          "stream": false,
          "max_tokens": 250,
        };

        when(
          () => mockNetworkUtility.postJson(
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
          () => mockNetworkUtility.postJson(
            fakeUri,
            headers: {'Authorization': 'Bearer $fakeApiKey'},
            body: expectedPayload,
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
          () => mockNetworkUtility.postJson(
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
          () => mockNetworkUtility.postJson(
            fakeUri,
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        ).called(1);
      },
    );
  });
}
