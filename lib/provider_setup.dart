import 'package:provider/provider.dart';

import 'core/services/local_storage_service.dart';

List<SingleChildCloneableWidget> providers = [
  Provider.value(value: LocalStorageService())
];