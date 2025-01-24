import 'package:dart_frog/dart_frog.dart';
import 'package:inventories/airtable/airtable_service.dart';
import 'package:inventories/settings.dart';

Future<Response> onRequest(RequestContext context) async {
  try {
    final airtableService = AirtableService(airtableData);
    final title = context.request.uri.queryParameters['title'] ?? '';
    final result = await airtableService.getRecordByTitle(title: title);
    return Response.json(body: result);
  } catch (e) {
    return Response(body: e.toString(), statusCode: 500);
  }
}
