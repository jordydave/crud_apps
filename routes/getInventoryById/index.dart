import 'package:dart_frog/dart_frog.dart';
import 'package:inventories/airtable/airtable_service.dart';
import 'package:inventories/settings.dart';

Future<Response> onRequest(RequestContext context) async {
  try {
    final airtableService = AirtableService(airtableData);
    final recordId = context.request.uri.queryParameters['recordId'] ?? '';
    final result = await airtableService.getRecordById(recordId: recordId);
    return Response.json(body: result);
  } catch (e) {
    return Response(body: e.toString(), statusCode: 500);
  }
}
