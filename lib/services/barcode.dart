import 'package:hive/hive.dart';
import 'package:zadanie_rekrutacyjne/model/barcodes_model.dart';

class BarcodeService{
  late Box<Barcodes> _barcodes;

  Future<void> init() async {
    Hive.registerAdapter(BarcodesAdapter());
    _barcodes = await Hive.openBox<Barcodes>('barcodes');
   // await _barcodes.clear();
  }

  List<Barcodes> getBarcodes(){
    final barcodes = _barcodes.values;
    return barcodes.toList();
  }

  void addBarcode(final String code, final DateTime date){
    _barcodes.add(Barcodes(date, code));
  }

  void removeBarcode(final String code, final DateTime date) async{
    final barcodeToMove = _barcodes.values.firstWhere((element) => element.code == code && element.date == date );
    await barcodeToMove.delete();
  }

}