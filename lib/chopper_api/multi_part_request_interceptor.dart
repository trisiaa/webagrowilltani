import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:chopper/chopper.dart';
import 'package:path/path.dart'; // for file path operations

class MultipartRequestInterceptor {
  @override
  Future<Request> onRequest(Request request) async {
    if (request.multipart) {
      // Convert request to a multipart request
      final uri = Uri.parse(request.url.toString());
      final multipartRequest = http.MultipartRequest(request.method, uri);

      // Add headers
      multipartRequest.headers.addAll(request.headers);

      // Add fields (non-file data)
      multipartRequest.fields.addAll(request.parameters
          .map((key, value) => MapEntry(key, value.toString())));

      // Add files if they exist
      for (final entry in request.parts) {
        if (entry.value is http.MultipartFile) {
          multipartRequest.files.add(entry.value);
        }
      }

      // Send the multipart request
      final streamedResponse = await multipartRequest.send();

      // Convert the streamed response to a regular response
      final response = await http.Response.fromStream(streamedResponse);

      return request.copyWith(
        body: json.decode(response.body),
        headers: response.headers,
        uri: request.url,
        method: request.method,
      );
    }
    return request;
  }
}
