part of 'barcodes_bloc.dart';

abstract class BarcodesState extends Equatable {
  const BarcodesState();
}

class BarcodesInitial extends BarcodesState {
  @override
  List<Object> get props => [];
}
class BarcodesLoadedState extends BarcodesState {
  final List<Barcodes> barcodes;

  BarcodesLoadedState({required this.barcodes});
  @override
  List<Object> get props => [barcodes];
}
// class RegisterServicesState extends BarcodesState{
//   @override
//   // TODO: implement props
//   List<Object?> get props => [];
//
// }

