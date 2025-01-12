import 'package:dart_frog/dart_frog.dart';
import 'package:in_memory_inventories_data_source/in_memory_inventories_data_source.dart';
import 'package:inventories_data_source/inventories_data_source.dart';

final _dataSource = InMemoryInventoriesDataSource();

Handler middleware(Handler handler) {
  return handler
      .use(requestLogger())
      .use(provider<InventoriesDataSource>((_) => _dataSource));
}
