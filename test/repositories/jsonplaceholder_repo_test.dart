import 'package:fetch_users_01/repositories/jsonplaceholder_repo.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Deve receber um response', () async {
    var resultado = await JsonplaceholderRepo.getData(1);
    print(resultado);
  });
}
