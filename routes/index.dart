import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:inventories_data_source/inventories_data_source.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _get(context);
    case HttpMethod.post:
      return _post(context);
    case HttpMethod.delete:
    case HttpMethod.head:
    case HttpMethod.options:
    case HttpMethod.patch:
    case HttpMethod.put:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _get(RequestContext context) async {
  final dataSource = context.read<InventoriesDataSource>();
  final inventories = await dataSource.readAll();
  return Response.json(body: inventories);
}

Future<Response> _post(RequestContext context) async {
  final dataSource = context.read<InventoriesDataSource>();
  final inventory = Inventory.fromJson(
    await context.request.json() as Map<String, dynamic>,
  );

  return Response.json(
    body: await dataSource.create(inventory),
    statusCode: HttpStatus.created,
  );
}
