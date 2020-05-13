import 'package:My_Todo_App/notes.dart';
import 'package:My_Todo_App/utils/colors.dart';
import 'package:My_Todo_App/utils/text_styles.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/Constants/Helpers.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:swipedetector/swipedetector.dart';

class MyLiquidPage extends StatefulWidget {
  @override
  _MyLiquidPageState createState() => _MyLiquidPageState();
}

class _MyLiquidPageState extends State<MyLiquidPage> {
  @override
  Widget build(BuildContext context) {
    final pages = [
     
      Container(
        
        color: MyColors.accent,
        child:
        GestureDetector(
              onHorizontalDragUpdate: (DragUpdateDetails details)  {
                if (details.delta.dx > 0) {
                   Navigator.push(
                   context,
                    MaterialPageRoute(builder: (context) => NotesListWidget()),
                  );
                } else if(details.delta.dx < -0){

                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotesListWidget()),
                 );
                }

                
                    
                },


            
             
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
           
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                
                Container(
                  width: 350,
                  height: 350,
                  child: FlareActor(
                    'assets/flare/card.flr',
                    animation: 'animation',
                  ),
                ),
                Text(
                  '<< Swipe to right >>',
                  style: SubHeadingStylesMaterial.dark,
                ),
              ],
            ),
            
          ],
        ),
      ),
      ),
      
      Container(
        color: MyColors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 350,
                  height: 350,
                  child: FlareActor(
                    'assets/flare/card.flr',
                    animation: 'animation',
                  ),
                ),
                Text(
                  '<< Swipe >>',
                  style: SubHeadingStylesMaterial.light,
                ),
              ],
            )
          ],
        ),
      ),
    ];

    return LiquidSwipe(
      pages: pages,
      initialPage: 0,
      fullTransitionValue: 350.0,
      enableLoop: true,

      waveType: WaveType.liquidReveal,
    );
  }
}
