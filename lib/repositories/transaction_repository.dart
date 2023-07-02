import 'package:bolso_organizado/commons/constants/collections_cloud_firestore.dart';
import 'package:bolso_organizado/repositories/repository.dart';

class TransactionRepository extends Repository{
  TransactionRepository(): super(CollectitonsCloudFirestore.TRANSACTION);
}