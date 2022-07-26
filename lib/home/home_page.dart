import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:zadanie_rekrutacyjne/home/bloc/barcodes_bloc.dart';
import 'package:zadanie_rekrutacyjne/scanner/scanner_page.dart';
import 'package:zadanie_rekrutacyjne/services/barcode.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final BarcodesBloc bloc = BlocProvider.of<BarcodesBloc>(context);
    return Scaffold(
      body: SafeArea(
        child: BlocListener(
        listener: (context, state) {

        },
          child: BlocProvider(
            create: (context) =>
                BarcodesBloc(RepositoryProvider.of<BarcodeService>(context))..add( LoadBarcodesEvent()),
            child: BlocBuilder<BarcodesBloc, BarcodesState>(
              builder: (context, state) {
                if (state is BarcodesLoadedState){
               return ListView.builder(
                 itemCount: state.barcodes.length,
                   itemBuilder: (BuildContext context, int index) {
                     return Card(
                       child: Row(
                         children: [
                          Text( state.barcodes[index].code),
                          Text( state.barcodes[index].date.toString()),
                           IconButton(onPressed: (){
                             BlocProvider.of<BarcodesBloc>(context).add(RemoveBarcodesEvent(state.barcodes[index].date,state.barcodes[index].code));
                           }, icon: Icon(Icons.close))
                         ],
                       ),
                     );
                   });
               //   ListView(
               //
               //   children: [
               //   ...state.barcodes.map( (e) => ListTile(
               //   title: Text(e.code),
               // )),
               // ],);
               } return  Container();


              },
              bloc: bloc,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(
                  builder: (context) => const ScannerPage()));
        },
        icon: const Icon(Icons.qr_code),
        label: const Text('Zrób scan barkodu'),
        backgroundColor: Colors.indigoAccent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerFloat,
    );
  }
}
