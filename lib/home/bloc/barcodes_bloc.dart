import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zadanie_rekrutacyjne/model/barcodes_model.dart';
import 'package:zadanie_rekrutacyjne/services/barcode.dart';

part 'barcodes_event.dart';
part 'barcodes_state.dart';

class BarcodesBloc extends Bloc<BarcodesEvent, BarcodesState> {
  final BarcodeService _barcodeService;

  BarcodesBloc(this._barcodeService): super(BarcodesInitial()) {


    // on<RegisterServicesEnevt>((event, emit) async{
    //   await _barcodeService.init();
    //   emit(BarcodesInitial)
    // });

    on<LoadBarcodesEvent>((event, emit) async {
      await _barcodeService.init();
      final barcodes = _barcodeService.getBarcodes();
      emit(BarcodesLoadedState(barcodes: barcodes));
    });


    on<AddBarcodesEvent>((event, emit) async {
      final currentState = state as LoadBarcodesEvent;
      _barcodeService.addBarcode(event.code, event.date);
      add(LoadBarcodesEvent());
      });
    on<RemoveBarcodesEvent>((event, emit) async {
      final currentState = state as LoadBarcodesEvent;
      _barcodeService.removeBarcode(event.code, event.date);
      add(LoadBarcodesEvent());
      });
  }
}
