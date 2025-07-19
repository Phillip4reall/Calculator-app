import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
   List<String> history = [];
  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      history = prefs.getStringList('calc_history') ?? [];
    });

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar( leading: IconButton(onPressed: (){
        Navigator.pop(context);
        
      }, icon: Icon(Icons.arrow_back_ios,color:Colors.white70 ,)),
        backgroundColor: Colors.black,title:Text('History',style: const TextStyle(color: Colors.white70),), 
        actions: [ TextButton(onPressed:() async{
          final prefs = await SharedPreferences.getInstance();
    await prefs.remove('calc_history');
    setState(() {
      
      history.clear();
    });
       
        }, child: Text('Clear',style: const TextStyle(color: Colors.white70),))],),
      backgroundColor: Colors.black,
      body: SafeArea(child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: history.length,
        //reverse: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text(
              history[index],
              style: const TextStyle(color: Colors.white70),
            ),
          );
        },
      ),)
    );
  }
}

