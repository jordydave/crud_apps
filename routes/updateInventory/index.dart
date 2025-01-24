import 'package:dart_frog/dart_frog.dart';
import 'package:inventories/airtable/airtable_service.dart';
import 'package:inventories/settings.dart';

Future<Response> onRequest(RequestContext context) async {
  try {
    final airtableService = AirtableService(airtableData);
    final requestData = await context.request.json() as Map<String, dynamic>;
    final fields = requestData['fields'] as Map<String, dynamic>;
    final recordId = requestData['recordId'] as String;
    final result =
        await airtableService.updateRecord(fields: fields, recordId: recordId);
    return Response.json(body: result);
  } catch (e) {
    return Response(body: e.toString(), statusCode: 500);
  }
}
