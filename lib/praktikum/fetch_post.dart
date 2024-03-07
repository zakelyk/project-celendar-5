// fetch_post.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'post.dart';
import 'fetch.dart';

void main() {
  group('fetchPosts', () {
    test('returns a Posts object if the http call completes successfully', () async {
      // Arrange
      final client = http.Client();

      // Act
      final result = await fetchPosts(client);

      // Assert
      expect(await result, isA<Posts>());

      // Clean up
      client.close();
    });

    test('throws an exception if the http call completes with an error', () async {
      // Arrange
      final client = http.Client();

      // Act
      final future = fetchPosts(client);

      // Assert
      expect(future, throwsA(isA<Exception>()));

      // Clean up
      client.close();
    });
  });
}
