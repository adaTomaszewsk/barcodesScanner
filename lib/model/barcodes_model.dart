import 'package:hive/hive.dart';

part 'barcodes_model.g.dart';

@HiveType(typeId: 1)
class Barcodes extends HiveObject{
  Barcodes(
     this.date,
      this.code,
  );
  @HiveField(0)
  final DateTime date;
  @HiveField(1)
  final String code;

 }