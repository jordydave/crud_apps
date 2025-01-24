import 'package:dart_frog/dart_frog.dart';
import 'package:inventories/airtable/airtable_service.dart';
import 'package:inventories/settings.dart';

Future<Response> onRequest(RequestContext context) async {
  try {
    final airtableService = AirtableService(airtableData);
    final recordId = context.request.uri.queryParameters['recordId'];

    if (recordId == null) {
      return Response(body: 'Missing recordId', statusCode: 400);
    }

    await airtableService.deleteRecord(recordId: recordId);
    return Response.json(
      body: {'message': 'Record $recordId deleted successfully'},
    );
  } catch (e) {
    return Response(body: e.toString(), statusCode: 500);
  }
}
