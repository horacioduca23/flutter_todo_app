import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

import '../dtos/llm_remote_dto.dart';
import 'llm_remote_datasource.dart';

class LlmRemoteDatasourceImpl implements LlmRemoteDatasource {
  final String apiKey = dotenv.env['HUGGING_FACE_API_KEY']!;
  late Client client = Client();

  @override
  Future<LlmRemoteDto> fetchLlmResponse({required String prompt}) async {
    LlmRemoteDto llmRemoteDTO;

    final Uri uri = Uri.parse(
      'https://router.huggingface.co/v1/chat/completions',
    );

    final Map<String, dynamic> payload = {
      "messages": [
        {"role": "user", "content": prompt},
        {
          "role": "system",
          "content":
              "Eres un asistente que responde siempre en texto plano, con máximo 5 viñetas o 3 oraciones breves.",
        },
      ],
      "model": "moonshotai/Kimi-K2-Instruct:novita",
      "stream": false,
      "max_tokens": 150,
    };

    final response = await client.post(
      uri,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      llmRemoteDTO = LlmRemoteDto.fromJson(json.decode(response.body));
    } else {
      throw Exception(
        'Error Fetching Data, Http Status Code == "${response.statusCode}"',
      );
    }

    return llmRemoteDTO;
  }
}
