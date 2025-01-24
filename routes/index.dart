import 'package:dart_frog/dart_frog.dart';
import 'package:inventories/airtable/airtable_service.dart';
import 'package:inventories/settings.dart';

Future<Response> onRequest(RequestContext context) async {
  try {
    final airtableService = AirtableService(airtableData);
    final records =
        await airtableService.getRecordByTitle(title: 'Sample Title');
    return Response.json(body: records);
  } catch (e) {
    return Response(body: e.toString());
  }
}
