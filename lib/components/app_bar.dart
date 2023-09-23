import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glad/main.dart';

class GladAppBar extends StatefulWidget{
   final String titleOfPage;
   final String? previousPage;
   const GladAppBar({super.key, required this.titleOfPage, this.previousPage = "Glad"});

  @override
  State<GladAppBar> createState() => _GladAppBarState();
}

class _GladAppBarState extends State<GladAppBar> {
  @override
  Widget build(BuildContext context) {

    return  CupertinoSliverNavigationBar(

      previousPageTitle: widget.previousPage,
      largeTitle: Text(widget.titleOfPage, style:
       TextStyle(
        fontSize:  28,
        fontWeight:  FontWeight.w700,
        height:  1.2575,
        color: MediaQuery.of(context).platformBrightness == Brightness.dark ? Colors.white : Colors.black
       ),),
      trailing: Image.asset(
        "assets/infinitylogo.png",
        height: 50,
        width: 50,
      ),
    );
  }
}