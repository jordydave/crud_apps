import 'package:dart_frog/dart_frog.dart';
import 'package:inventories/airtable/airtable_service.dart';
import 'package:inventories/settings.dart';

Future<Response> onRequest(RequestContext context) async {
  try {
    final airtableService = AirtableService(airtableData);
    final requestData = await context.request.json() as Map<String, dynamic>;
    final fields = requestData['fields'] as Map<String, dynamic>;

    final result = await airtableService.createRecord(fields: fields);
    return Response.json(body: result);
  } catch (e) {
    return Response(body: e.toString(), statusCode: 500);
  }
}
