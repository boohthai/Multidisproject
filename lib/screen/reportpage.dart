import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';


class ReportPage extends StatefulWidget {
  @override
  _LineChartSample2State createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<ReportPage> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  List<Color> gradientColors_1 = [
    const Color(0xff23b6e6),
    const Color(0xff233ae6),
    const Color(0xff8b30db),  
    const Color(0xffdb30d0)
  ];

  List<Color> gradientColors_2 = [
     const Color(0xfff04a29).withOpacity(0.6),
     const Color(0xfffc1767).withOpacity(0.6),
  ];
   List<Color> gradientColors_3 = [
    const Color(0xff18f2eb).withOpacity(0.3),
    const Color(0xff472be3).withOpacity(0.8),
  ];
 
  bool showAvg = false;

  var dateChosen = DateFormat('yyyy-MM-dd').format(DateTime.now());
  // var dateChosen  = '2021-06-04';
  List data = [];
  void _showDatePicker(ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
          height: 280,
          color: Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only( top:10),
                height: 250,
                child: CupertinoDatePicker(
                  mode:CupertinoDatePickerMode.date,
                    initialDateTime: DateTime.parse(dateChosen),
                    onDateTimeChanged: (val) {
                      setState(() {
                        dateChosen = DateFormat('yyyy-MM-dd').format(val) ;
                      });
                    }),
              ),
            ],
          ),
        ));
  }
  convertDate(date){
      List t  = date.split(',');
      List list = t[0].split('/');
      var time = t[1];
      return  list.reversed.join('-')  +time ;
    }
    printDate(date){
      return date.split('-').reversed.join('-') ;
    }

    getDate(date){
      List t  = date.split(' ');
      return  t[0] ;
    }
    buttonCalendar(){

      return Container(child: CupertinoButton(
          padding: EdgeInsetsDirectional.zero,
          child: Text('Choose date'),
          onPressed: () => _showDatePicker(context),
        ),);
  }

  stream(type){
    var typ = type == 'Noise' ? "room1_noise_record":"room1_light_record";
      return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection(typ).snapshots(includeMetadataChanges: true),
      builder: (BuildContext _context, AsyncSnapshot<QuerySnapshot> snapshot) {
          List noise_list; 
          if (snapshot.hasData ){
            noise_list =  snapshot.data!.docs.map((DocumentSnapshot document) { 
              return [convertDate(document.data()['date']),document.data()['data']];
          }).toList();
          }
          else{
            noise_list = [['${dateChosen} 00:00:01','0'],['${dateChosen} 10:30:00','0']];
          }
  
          noise_list = noise_list.where((_set) => getDate(_set[0]) == dateChosen ).toList();
          if (noise_list.isEmpty){ noise_list = [['${dateChosen} 00:00:01','0'],['${dateChosen} 23:59:10','0']];          print(Theme.of(context).primaryColor);
}
  
          var sum = 0 ;
          noise_list.forEach((e) => sum += int.parse(e[1]) );

          var largest_value = int.parse(noise_list[0][1]);
          var smallest_value = int.parse(noise_list[0][1]);

          noise_list.forEach((e) => {
                if (int.parse(e[1]) > largest_value) {largest_value = int.parse(e[1])},
                if (int.parse(e[1]) < smallest_value) {smallest_value = int.parse(e[1])},
              });

          final List<FlSpot> values = noise_list
            .map((datum) => FlSpot(DateTime.parse(datum[0]).millisecondsSinceEpoch.toDouble(),double.parse(datum[1])))
            .toList()
            ;
          values.sort((a, b) => a.x.compareTo(b.x));
          var avg = sum/noise_list.length;

          final List<FlSpot> values_avg = noise_list
            .map((datum) => FlSpot(DateTime.parse(datum[0]).millisecondsSinceEpoch.toDouble(),sum/noise_list.length))
            .toList()
            ;
          values_avg.sort((a, b) => a.x.compareTo(b.x));
          
          double _minX = values.first.x;
          double _maxX = values.last.x;

    LineChartData mainData(values) {

        return LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                // color: const Color(0xff37434d),
                color: const Color(0xffcfd0d1),
                strokeWidth: 0.5,
              );
            },
            getDrawingVerticalLine: (value) {
              return FlLine(
                color: const Color(0xffcfd0d1),
                strokeWidth: 0.5,
              );
            },
          ),
          
          titlesData: FlTitlesData(
            show: true,

            bottomTitles: SideTitles(
              showTitles: true,
              reservedSize: 22,
              getTextStyles: (value) =>
                  const TextStyle(color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 12),
              getTitles: (value) {
                final DateTime date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
                return DateFormat('H:mm').format(date);
              
              },
              interval: (_maxX - _minX) / 6,
              margin: 8,
            ),

            leftTitles: SideTitles(
              showTitles: true,
              getTextStyles: (value) => const TextStyle(color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 12),
              getTitles: (value) {
                return '${value.toInt()}';
              },
              interval: (1000 ) / 5,
              reservedSize: 28,
              margin: 12,
            ),
          ),
          //
          borderData:
              FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1)),
          minX:_minX,
          maxX: _maxX,
          minY: 0,
          maxY: 1000,
          lineBarsData: [
            LineChartBarData(
              spots:values,
              isCurved: true,
              colors: type == 'Noise'? gradientColors : gradientColors_1,
              barWidth: 1,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: false,
              ),
              belowBarData: BarAreaData(
                show: true,
                // colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),

                colors: type == 'Noise'? gradientColors.map((color) => color.withOpacity(0.3)).toList() : gradientColors_1.map((color) => color.withOpacity(0.3)).toList(),
              ),
            ),
      ],
    );
  }
  drawChart(){
    return AspectRatio(
          aspectRatio: 1.70,
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                ),
            child: 
            Padding(
              padding: const EdgeInsets.only(right: 18.0, left: 12.0, top: 18, bottom: 12),
              child: LineChart(
                showAvg ? mainData(values_avg) : mainData(values),
              ),
            ),
            
          ),
        );
  }
  chartInfo(){
     return Column(
              children:[
                Row(children:[
                     Container(
                  margin: const EdgeInsets.only( left: 45.0),
                    child: 
                Text(
                      '${type} records',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.pink.shade600,
                              // color: Colors.ammber,
                          fontWeight: FontWeight.w900,
                      ),
                    ),
          
                
                )]),
               SizedBox(height:10),
                Row(
                  children:[
                    Container(
                     height: 40,  child: VerticalDivider(color: Theme.of(context).primaryColor,thickness:7,), margin: const EdgeInsets.only( left: 45.0),),
                     Column(
                       children:[
                          Text('Minimum',style: TextStyle(fontSize: 13,fontWeight:FontWeight.w500,color: Theme.of(context).primaryColor,),),
                          SizedBox(height:3),
                          Text('${smallest_value}',style: TextStyle(fontSize: 23,color:Colors.grey.shade600,), ),
                       ]
                     ),
                     SizedBox(width:50),
                     Container(
                     height: 40,  child: VerticalDivider(color: Theme.of(context).primaryColor.withOpacity(0.7),thickness:7,), margin: const EdgeInsets.only( left: 45.0),),
                      Column(
                       children:[
                          Text('Maximum',style: TextStyle(fontSize: 13,fontWeight:FontWeight.w500,color: Theme.of(context).primaryColor.withOpacity(0.7),),),
                          SizedBox(height:3),
                          Text('${largest_value}',style: TextStyle(fontSize: 23,color:Colors.grey.shade600,), ),
                       ]
                     ),
                     SizedBox(width:30),
                      OutlinedButton(
                          child: Text('Avg'),
                          style: OutlinedButton.styleFrom(
                            primary: Colors.black,
                            backgroundColor: Colors.amber,
                            side: BorderSide(color: Colors.black, width: 2),
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)),),
                          ),
                          onPressed: () {setState(() { showAvg = !showAvg;});
                        }
                    )
                    
                  ]
                ),
              drawChart()
              ]
            );
  }
  buttonAvg(){
    return  SizedBox(
          width: 60,
          height: 34,
          child: 
          TextButton(
            onPressed: () {
              setState(() {
                showAvg = !showAvg;
              });
            },
            child: Text(
              'avg',
              style: TextStyle(
                  fontSize: 12, color: showAvg ? Colors.white.withOpacity(0.5) : Colors.red),
            ),
          ),
          //  return OutlinedButton(
          //     child: Text('Average'),
          //     style: OutlinedButton.styleFrom(
          //       primary: Colors.black,
          //       backgroundColor: buttonThemeData.primaryColor,
          //       side: BorderSide(color: Colors.black, width: 2),
          //       //  primary:  Colors.black ,
          //       // backgroundColor: Colors.white,
          //       shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)),),
          //     ),
          //     onPressed: () => themeNotifier.setTheme(buttonThemeData),
          //   );
        );
        }
        return  chartInfo();
      },  
    );
  }

  @override
  Widget build(BuildContext context) {

        return new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 4,
          child:  Scaffold(
            appBar:  AppBar(
              backgroundColor: Theme.of(context).primaryColor,

              flexibleSpace: new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              new TabBar(
                indicatorColor: Colors.amber,
                indicatorWeight:7,
                labelColor: Colors.black,
                tabs: [
                  new Tab(child:  Column(children:[ Image.asset("assets/monitor_1.png", width: 25,height:25),Text('Room 1')])),
                  new Tab(child:  Column(children:[ Image.asset("assets/read.png", width: 25,height:25),Text('Room 2')])),
                  new Tab(child:  Column(children:[ Image.asset("assets/conversation.png", width: 25,height:25),Text('Room 3')])),
                  new Tab(child:  Column(children:[ Image.asset("assets/listening.png", width: 25,height:25),Text('Room 4')])),

                ],
              ),
            ],
          ),
            ),
            body: TabBarView(
              children: [
                SingleChildScrollView(
          child: Column(
            children:[
        
               Stack(
                children: [
                 
                Container(
                  width:double.infinity,

                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black, width: 1),

                  boxShadow: [
                    BoxShadow(
                      color:  Colors.grey.shade500,
                      blurRadius: 2,
                      offset: Offset(1, 2), // Shadow position
                    ),
                  ],
                ),
                      // margin: EdgeInsets.only(
                      //   top:10,bottom:10,left:50, right:50
                      // ),
                      margin: EdgeInsets.all(10),
                  child:   Column(
                 children:[
                   SizedBox(height:20),
                    Stack(
                      children:[
                          Text(
                    '${printDate(dateChosen)}',
                    style: TextStyle(
                      fontSize: 40,
                        fontWeight: FontWeight.w900,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 3
                        ..color = Colors.black,
                      
                    ),
                  
                  ),
                    Text(
                   '${printDate(dateChosen)}',
                    style: TextStyle(
                      fontSize: 40,
                      // color: Theme.of(context).primaryColor.withOpacity(1.0),
                      color:Colors.amber,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                      ]
                    ),
                       buttonCalendar(),
                 ]
               ),)
                
                ]
              ),
           
              stream('Noise'),
              stream('Light'),

            ]
          )
        ),
                 Text('Hello'),
                 Text('Hello'),
                 Text('Hello'),
               
            
              ],
            ),
          ),
        ),
      );

 
   
  }




}



