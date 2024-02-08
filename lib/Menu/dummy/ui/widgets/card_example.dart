import 'package:flutter/material.dart';

class CardExample extends StatefulWidget {
  const CardExample({super.key});

  @override
  State<CardExample> createState() => _CardExampleState();
}

class _CardExampleState extends State<CardExample> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: 5,
            left: 5,
            right: 5,
            child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color:  Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:const Offset(0, 3), // changes position of shadow
                      ),
                    ]
                ),
                child:   Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        IconButton(onPressed: (){}, icon: const Icon(Icons.man),)

                      ],
                    )
                )
            )
        )
      ],
    );
  }
}
