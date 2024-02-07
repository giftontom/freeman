

// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GanttChart extends StatelessWidget {
  const GanttChart({super.key});

  @override
  Widget build(BuildContext context) {
    bool jan = true;
    double width = MediaQuery.sizeOf(context).width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      const Padding(
                  padding: EdgeInsets.only(left:10.0),
                  child: Text(
                    'Crop Calender',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
        Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 171, 171, 171),
              borderRadius: BorderRadius.circular(3)),
          child: Column(
            children: [
              Stack(
                children: [
                  Table(
                    border:
                        TableBorder.symmetric(inside: const BorderSide(width: .75)),
                    children: [
                      jan
                          ? TableRow(children: [
                              mtext("Jan"),
                              mtext("Feb"),
                              mtext("Mar"),
                              mtext("Apr"),
                              mtext("May"),
                              mtext("Jun"),
                              mtext("July"),
                              mtext("Aug"),
                              mtext("Sept"),
                              mtext("Oct"),
                              mtext("Nov"),
                              mtext("Dec"),
                            ])
                          : TableRow(children: [
                              mtext("July"),
                              mtext("Aug"),
                              mtext("Sept"),
                              mtext("Oct"),
                              mtext("Nov"),
                              mtext("Dec"),
                              mtext("Jan"),
                              mtext("Feb"),
                              mtext("Mar"),
                              mtext("Apr"),
                              mtext("May"),
                              mtext("Jun"),
                            ])
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 30),
                      bar(2, 6, width, Colors.red),
                      bar(3, 9, width, Colors.yellow),
                      bar(5, 10, width, Colors.green),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  barName("name",Colors.red),  barName("name",Colors.yellow),  barName("name",Colors.green),
                ],
              ),

            ],
          ),
        ),
       
      ],
    );
  }

  

  Widget mtext(String txt) {
    return SizedBox(
        height: 90,
        child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(txt,style: const TextStyle(fontSize: 11),),
            )));
  }

  Widget bar(int startindex, endindex, double width, Color clr) {
    return Row(
      children: [
        SizedBox(width: ((width - 20) / 12) * startindex),
        Container(
          color: clr,
          height: 20,
          width: ((width - 20) / 12) * (endindex - startindex),
        )
      ],
    );
  }
   Widget barName(String name, Color clr) {
    return 
     
      Padding(
        padding: const EdgeInsets.all(3.0),
        child: Row(
          children: [
            Container( margin: const EdgeInsets.all(8.0),width:40,height:20, color: clr,),
           Text(name)
          ],
        ),
      );
    
  }
}
