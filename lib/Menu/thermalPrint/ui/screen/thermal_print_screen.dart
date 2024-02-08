import 'package:flutter/material.dart';
import 'package:gomart/Menu/thermalPrint/ui/widget/print_page.dart';
import 'package:intl/intl.dart';

class ThermalPrintScreen extends StatefulWidget {
  const ThermalPrintScreen({super.key});

  @override
  State<ThermalPrintScreen> createState() => _ThermalPrintScreenState();
}

class _ThermalPrintScreenState extends State<ThermalPrintScreen> {
  final List<Map<String, dynamic>> data = [
    {'title': 'Coca-cola', 'price': 19, 'quantity': 4},
    {'title': 'Fanta', 'price': 19, 'quantity': 6},
    {'title': 'Gomitas', 'price': 23, 'quantity': 8},
    {'title': 'Paletas', 'price': 35, 'quantity': 3},
  ];

  final f = NumberFormat("\$###,###.00", "en_US");


  @override
  Widget build(BuildContext context) {
    int _total = 0;
    _total =data.map((e) => e['price'] * e['quantity']).reduce((value, element) => value + element);
    return Scaffold(
      appBar: AppBar( title: const Text("Ejemplo de ticket"),
      backgroundColor: Colors.redAccent,),
      body: Column(
        children: [
          Expanded(child:ListView.builder(
            itemCount: data.length,
            itemBuilder: (c,i){
              return ListTile(
                title: Text(data[i]['title'].toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
                ),
                subtitle: Text('${f.format(data[i]['price'])} x ${data[i]['quantity']}'),
                trailing: Text(f.format(data[i]['price'] * data[i]['quantity'])),
              );
            }
          ),
          ),
          Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Text("Total: ${f.format(_total)}",
                style: const TextStyle(fontWeight: FontWeight.bold),),
                const SizedBox(width: 80,),
                Expanded(
                    child: TextButton.icon(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) => PrintPage(data: data)));
                      },
                      icon: const Icon(Icons.print),
                      label: const Text("Imprimir"),
                      style: TextButton.styleFrom(
                        foregroundColor:Colors.white ,backgroundColor: Colors.grey,
                     ),
                    )
                )

              ],
            ),
          )
        ],
      ),
    );
  }
}
