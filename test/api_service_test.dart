import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/src/mock.dart';
import 'package:celendar/app/modules/home/controllers/api_service.dart';

class MockClient extends Mock implements http.Client {}

@GenerateMocks([http.Client, ApiService])
void main(){
  const _baseUrl = 'https://newsapi.org/v2/';
  const _apiKey = '8b1a01a392c64c58a8d8dfae800a299a';
  const _category = 'business';
  const _country = 'us';

  late ApiService apiService;
  late MockClient mockClient;
  // final mockClient = MockClient();


  setUp((){
    mockClient = MockClient();
    apiService = ApiService();
  });

  group('ApiService', () {
    test('fetchArticles returns a list of articles if response is successful',
            () async {
              when(mockClient.get(Uri.parse(
                  '${_baseUrl}top-headlines?country=$_country&category=$_category&apiKey=$_apiKey')))
                  .thenAnswer((_) async =>
                  http.Response('{"articles": []}', 200));

              final articles = await apiService.fetchArticles();
              expect(articles, isA<List<Article>>());
            });
  });
}