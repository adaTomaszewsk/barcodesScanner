import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:zadanie_rekrutacyjne/home/home_page.dart';

import '../home/bloc/barcodes_bloc.dart';
import '../services/barcode.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({Key? key}) : super(key: key);

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  String? _qrInfo = 'Scan a QR/Bar code';
  bool _camState = false;

  _qrCallback(String? code) {
    setState(() {
      _camState = false;
      _qrInfo = code;
    });
  }
  _scanCode() {
    setState(() {
      _camState = true;
    });
  }
  @override
  void initState() {
    super.initState();
    _scanCode();
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
            }),
            Text("Skaner")
          ],
        ),
      ),
      body: _camState
          ? Center(
        child: SizedBox(
          height: 1000,
          width: 500,
          child: QRBarScannerCamera(
            onError: (context, error) => Text(
              error.toString(),
              style: TextStyle(color: Colors.red),
            ),
            qrCodeCallback: (code) {
              _qrCallback(code);
            },
          ),
        ),
      )
          : BlocProvider(
        create: (context) =>
        BarcodesBloc(RepositoryProvider.of<BarcodeService>(context))..add( LoadBarcodesEvent()),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(_qrInfo!),
                Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(onPressed: (){
                        var date= DateTime.now();
                        if(_qrInfo != null) {
                          BlocProvider.of<BarcodesBloc>(context).add(
                              AddBarcodesEvent(date, _qrInfo!));
                        }
                      },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.add_outlined),
                              Text("Zapisz")
                            ],
                          )),
                      ElevatedButton(onPressed: (){
                        setState(() {
                          _scanCode();
                        });
                      },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.red
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.cancel_outlined),
                              Text("Odrzuć")
                            ],
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
    );
  }
}
