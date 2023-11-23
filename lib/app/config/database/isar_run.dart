import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../../data/models/subscriptions/subscription_model.dart';

Future<Isar> initializeIsar() async {
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [SubscriptionModelSchema],
    directory: dir.path,
  );
  return isar;
}
