import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PrintPage extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  const PrintPage({super.key, required this.data});

  @override
  State<PrintPage> createState() => _PrintPageState();
}

class _PrintPageState extends State<PrintPage> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  final f = NumberFormat("\$###,###.00", "en_US");
  bool _connected = false;
  BluetoothDevice? _device2;
  String tips = 'no device connect';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => initPrinter() );
  }

  Future<void>initPrinter() async {
    bluetoothPrint.startScan(timeout: const Duration(seconds: 4));
    bool isConnected=await bluetoothPrint.isConnected??false;
    bluetoothPrint.state.listen((state) {
      print('******************* estado actual del dispositivo: $state');

      switch (state) {
        case BluetoothPrint.CONNECTED:
          setState(() {
            _connected = true;
            tips = 'connect success';
          });
          break;
        case BluetoothPrint.DISCONNECTED:
          setState(() {
            _connected = false;
            tips = 'disconnect success';
          });
          break;
        default:
          break;
      }
    });

    if (!mounted) return;

    if(isConnected) {
      setState(() {
        _connected=true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar( title: const Text("Selecciona impresora"),
          backgroundColor: Colors.redAccent,),
        body: RefreshIndicator(
          onRefresh: () =>
              bluetoothPrint.startScan(timeout: const Duration(seconds: 4)),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Text(tips),
                    ),
                  ],
                ),
                const Divider(),
                StreamBuilder<List<BluetoothDevice>>(
                  stream: bluetoothPrint.scanResults,
                  initialData: const [],
                  builder: (c, snapshot) => Column(
                    children: snapshot.data!.map((d) => ListTile(
                      title: Text(d.name??''),
                      subtitle: Text(d.address??''),
                      onTap: () async {
                        setState(() {
                          _device2 = d;
                          _openBluetooth();
                        });
                      },
                      trailing: _device2!=null && _device2!.address == d.address?const Icon(
                        Icons.check,
                        color: Colors.green,
                      ):null,
                    )).toList(),
                  ),
                ),
                const Divider(),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                  child: Column(
                    children: <Widget>[
                     // Divider(),
                      OutlinedButton(
                        onPressed:  _connected?() async {
                          _startPrint();
                        }:null,
                        child: const Text('Imprimir'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: StreamBuilder<bool>(
          stream: bluetoothPrint.isScanning,
          initialData: false,
          builder: (c, snapshot) {
            if (snapshot.data == true) {
              return FloatingActionButton(
                onPressed: () => bluetoothPrint.stopScan(),
                backgroundColor: Colors.red,
                child: const Icon(Icons.stop),
              );
            } else {
              return FloatingActionButton(
                  child: const Icon(Icons.search),
                  onPressed: () => bluetoothPrint.startScan(timeout: const Duration(seconds: 4)));
            }
          },
        ),
    );
  }

  Future<void> _openBluetooth() async{
    await bluetoothPrint.connect(_device2!);
  }

  Future<void> _startPrint() async {
    Map<String, dynamic> config = {};
    List<LineText> list = [];

    list.add(LineText(
      type: LineText.TYPE_TEXT,
      content: "Prueba Yisus",
      weight: 2,
      width: 2,
      height: 2,
      align: LineText.ALIGN_CENTER,
      linefeed: 1,
    ));
    debugPrint("Lllega antes del for ${widget.data[0]['title']}");

    for (var i = 0; i< widget.data.length; i++){
      list.add(
          LineText(
            type: LineText.TYPE_TEXT,
            content: widget.data[i]['title'],
            width: 0,
            align: LineText.ALIGN_LEFT,
            linefeed: 1,
          )
      );

      list.add(
          LineText(
            type: LineText.TYPE_TEXT,
            content: "${f.format(widget.data[i]['price'])} x ${widget.data[i]['quantity']}",
            align: LineText.ALIGN_LEFT,
            linefeed: 1,
          )
      );
    }
    list.add(LineText(linefeed: 1));
    list.add(LineText(linefeed: 1));
    await bluetoothPrint.printReceipt(config, list);
  }
}
