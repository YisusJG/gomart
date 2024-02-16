import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/physics.dart';
import 'package:gomart/Menu/options/ui/screen/options_screen.dart';
import 'package:gomart/Menu/sideBar/ui/screen/side_bar_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{
  late bool _menuBtn = false;
  late AnimationController? _animationController;
  late Animation<double> _sidebarAnim;
  final springDes = const SpringDescription(
      mass: 0.1,
      stiffness: 40,
      damping: 5
  );
  @override
  void initState(){
    _animationController = AnimationController(duration: const Duration(milliseconds: 200),
      upperBound: 1,
      vsync: this,
    );

    _sidebarAnim = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController!,
        curve: Curves.linear,
     )
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Positioned(child: Container(color: Colors.indigo.shade800,)),
          AnimatedBuilder(
            animation: _sidebarAnim,
            builder: (BuildContext context, Widget? child){
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(2, 1, 0.001)
                  ..rotateY((1 - _sidebarAnim.value * -30) * math.pi / 180)
                  ..translate((1 - _sidebarAnim.value) * -300 ),
                child: child,
              );
            },
            //child: const SideBarScreen(),
            child: FadeTransition(opacity: _sidebarAnim,
              child: const SideBarScreen(),
            ),
          ),
          AnimatedBuilder(
            animation: _sidebarAnim,
            builder: (context,child){
              return Transform.scale(
                scale: 1 - _sidebarAnim.value * 0.1,
                child: Transform.translate(
                  offset: Offset(_sidebarAnim.value * 200,0),
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY((_sidebarAnim.value * 30) * math.pi / 180),
                    child: child,
                  ),
                ),
              );
            },
            child: const OptionsScreen(),
          ),
          AnimatedBuilder(animation: _sidebarAnim,
              builder: (context, child){
              return SafeArea(
                child:Row(
                  children: [
                    SizedBox( width: _sidebarAnim.value * 165,),
                    child!,
                  ],
                )
             );
            },
            child: InkWell(
              onTap: _onMenuIconInit,
              child: Container(
                width: 44,
                height: 44,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(44/2),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.white,
                        blurRadius: 1,
                        //offset: const Offset(0, 2)
                      )
                    ]
                ),
                child: _menuBtn == false ? const Icon(Icons.menu_open_rounded,color: Colors.black,) : const Icon(Icons.close_rounded,color: Colors.black,),
              ),
            ),
          )
         // Container(height: 100,color: Colors.cyan),

        ],
      ),
    );
  }

  void _onMenuIconInit(){
    setState(() {
      _menuBtn = !_menuBtn;
      if(_menuBtn){
        final springAnim = SpringSimulation(springDes, 0, 1, 0);
        _animationController?.animateWith(springAnim);
      }else{
        _animationController?.reverse();
      }
    });

    debugPrint("Menu ${!_menuBtn}");
  }

  void onMenuPress(){

  }
}
