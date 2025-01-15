import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:inventories_data_source/inventories_data_source.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../routes/inventories/[id].dart' as route;

class _MockRequestContext extends Mock implements RequestContext {}

class _MockRequest extends Mock implements Request {}

class _MockInventoriesDataSource extends Mock
    implements InventoriesDataSource {}

void main() {
  late RequestContext context;
  late Request request;
  late InventoriesDataSource dataSource;

  const id = 'id';

  final inventory = Inventory(
    id: id,
    title: 'Test title',
    description: 'Test description',
    quantity: 1,
    price: 1,
  );

  setUpAll(() => registerFallbackValue(inventory));

  setUp(() {
    context = _MockRequestContext();
    request = _MockRequest();
    dataSource = _MockInventoriesDataSource();
    when(() => context.read<InventoriesDataSource>()).thenReturn(dataSource);
    when(() => context.request).thenReturn(request);
    when(() => request.headers).thenReturn({});
  });

  group('responds with a 405', () {
    setUp(() {
      when(() => dataSource.read(any())).thenAnswer((_) async => inventory);
    });

    test('when method is HEAD', () async {
      when(() => request.method).thenReturn(HttpMethod.head);

      final response = await route.onRequest(context, id);

      expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
    });

    test('when method is OPTIONS', () async {
      when(() => request.method).thenReturn(HttpMethod.options);

      final response = await route.onRequest(context, id);

      expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
    });

    test('when method is PATCH', () async {
      when(() => request.method).thenReturn(HttpMethod.patch);

      final response = await route.onRequest(context, id);

      expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
    });

    test('when method is POST', () async {
      when(() => request.method).thenReturn(HttpMethod.post);

      final response = await route.onRequest(context, id);

      expect(response.statusCode, equals(HttpStatus.methodNotAllowed));
    });
  });

  group('responds with a 404', () {
    test('if no inventory is found', () async {
      when(() => dataSource.read(any())).thenAnswer((_) async => null);
      when(() => request.method).thenReturn(HttpMethod.get);

      final response = await route.onRequest(context, id);

      expect(response.statusCode, equals(HttpStatus.notFound));

      verify(() => dataSource.read(any(that: equals(id)))).called(1);
    });
  });

  group('GET /inventories/[id]', () {
    test('responds with a 200 and the found inventory', () async {
      when(() => dataSource.read(any())).thenAnswer((_) async => inventory);
      when(() => request.method).thenReturn(HttpMethod.get);

      final response = await route.onRequest(context, id);

      expect(response.statusCode, equals(HttpStatus.ok));
      await expectLater(
        response.json(),
        completion(
          equals(
            inventory.toJson(),
          ),
        ),
      );

      verify(() => dataSource.read(any(that: equals(id)))).called(1);
    });
  });

  group('PUT /inventories/[id]', () {
    test('responds with a 200 and updated the inventory', () async {
      final updatedInventory = inventory.copyWith(title: 'New title');

      when(() => dataSource.read(any())).thenAnswer((_) async => inventory);
      when(
        () => dataSource.update(any(), any()),
      ).thenAnswer((_) async => updatedInventory);
      when(() => request.method).thenReturn(HttpMethod.put);
      when(() => request.json())
          .thenAnswer((_) async => updatedInventory.toJson());

      final response = await route.onRequest(context, id);

      expect(response.statusCode, equals(HttpStatus.ok));
      expect(response.json(), completion(equals(updatedInventory.toJson())));

      verify(() => dataSource.read(any(that: equals(id)))).called(1);
      verify(
        () => dataSource.update(
          any(that: equals(id)),
          any(that: equals(updatedInventory)),
        ),
      ).called(1);
    });
  });

  group('DELETE /inventories/[id]', () {
    test('responds with a 204 and deletes the inventory', () async {
      when(() => dataSource.read(any())).thenAnswer((_) async => inventory);
      when(() => dataSource.delete(any())).thenAnswer((_) async => {});
      when(() => request.method).thenReturn(HttpMethod.delete);

      final response = await route.onRequest(context, id);

      expect(response.statusCode, equals(HttpStatus.noContent));
      expect(response.body(), completion(isEmpty));

      verify(() => dataSource.read(any(that: equals(id)))).called(1);
      verify(() => dataSource.delete(any(that: equals(id)))).called(1);
    });
  });
}
