import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
  ChangeNotifierProvider(
    builder: (context) => Counter(),
    child: MyApp(), 
  )
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: App(),
    );
  }
}
class Counter with ChangeNotifier{
  int value = 0;
  int flag = 0;
  String notification = "";

  void increment(){
    if(value != 20){
      value += 1;
    }
    flag = 1;
    notifyListeners();
    
  }

  void decrement(){
    if(value != 0){
      value--;
    }
    flag = 2;
    notifyListeners();
  }

  Color colorChanger(){
    if(value == 0){
        notification = "Not okay...";
        return  Colors.red;
    }else if(value > 0 && value < 10){
        notification = "Hmm, nice one!";
        return Colors.orange;
    }
    notification = "Very good!";
    return Colors.green;
  }

  Icon iconChanger(){
    if(value == 0){
       return Icon(Icons.sentiment_dissatisfied);
    }else if(value > 0 && value < 10){
       return Icon(Icons.sentiment_satisfied);
    }
    return Icon(Icons.sentiment_very_satisfied);
  }
  
}

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<Counter>(context);
   
    return Scaffold(
    
      body:SafeArea(
        
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              SizedBox(
                
                height: 300,
                width: 200,
                child: Container(
                  child: provider.iconChanger(),
                  color: provider.colorChanger(),
                ),
              ),
              Divider(),
              Text((provider.value != 20)?"${provider.value}":"You have reached the maximum value!",style: TextStyle(fontSize:20,fontStyle: FontStyle.italic)),
              Divider(),
              FloatingActionButton(
                onPressed: (){
                provider.decrement();
              },
              tooltip: "Decrement",
              child:(provider.value == 0)?Icon(Icons.block):Icon(Icons.remove),
              backgroundColor: (provider.value == 0)?Colors.grey:provider.colorChanger(),
              
              ),
              SizedBox(
                height:20
              ),
              FloatingActionButton(
                onPressed: (){
                    provider.increment();
                },
                tooltip: "Increment",
                child: (provider.value==20)?Icon(Icons.block):Icon(Icons.add),//Text((provider.flag == 1)?"+":"${provider.value}"),
                backgroundColor:(provider.value == 20)?Colors.grey:provider.colorChanger()
              ),
              Divider(),
              Text("Max Bryan C. Bauzon",)
            ]
          ),
      )
      ),
      
    );
  }

}

