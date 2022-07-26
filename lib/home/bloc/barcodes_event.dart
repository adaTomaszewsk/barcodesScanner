part of 'barcodes_bloc.dart';

abstract class BarcodesEvent extends Equatable {
  const BarcodesEvent();
}

class RegisterServicesEvent extends BarcodesEvent{

  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class LoadBarcodesEvent extends BarcodesEvent {
  //final List<Barcodes> barcodes;

  LoadBarcodesEvent();

  @override
  List<Object?> get props => [];
}
class AddBarcodesEvent extends BarcodesEvent {
   final String code;
   final DateTime date;

   AddBarcodesEvent(this.date, this.code);


  @override
  List<Object?> get props => [code, date];
}
class RemoveBarcodesEvent extends BarcodesEvent {
   final String code;
   final DateTime date;

   RemoveBarcodesEvent(this.date, this.code);


  @override
  List<Object?> get props => [code, date];
}


