import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:inventories_data_source/inventories_data_source.dart';

FutureOr<Response> onRequest(RequestContext context, String id) async {
  final dataSource = context.read<InventoriesDataSource>();
  final inventory = await dataSource.read(id);

  if (inventory == null) {
    return Response(statusCode: HttpStatus.notFound, body: 'Not found');
  }

  switch (context.request.method) {
    case HttpMethod.get:
      return _get(context, inventory);
    case HttpMethod.put:
      return _put(context, id, inventory);
    case HttpMethod.delete:
      return _delete(context, id);
    case HttpMethod.head:
    case HttpMethod.options:
    case HttpMethod.patch:
    case HttpMethod.post:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _get(RequestContext context, Inventory inventory) async {
  return Response.json(body: inventory);
}

Future<Response> _put(
    RequestContext context, String id, Inventory inventory) async {
  final dataSource = context.read<InventoriesDataSource>();
  final updatedInventory = Inventory.fromJson(
    await context.request.json() as Map<String, dynamic>,
  );
  final newInventory = await dataSource.update(
    id,
    inventory.copyWith(
      title: updatedInventory.title,
      description: updatedInventory.description,
      quantity: updatedInventory.quantity,
      price: updatedInventory.price,
    ),
  );
  return Response.json(body: newInventory);
}

Future<Response> _delete(RequestContext context, String id) async {
  final dataSource = context.read<InventoriesDataSource>();
  await dataSource.delete(id);
  return Response(statusCode: HttpStatus.noContent);
}
