import 'package:flutter/material.dart';
import 'package:flutter_application_dio/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService _api = ApiService();
  List<dynamic> posts = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  
  }
  Future<void> loadData() async {
    final result = await _api.getPosts();
    setState(() {
      posts = result;
      loading = false;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Demo con DIO Noe"),),
      body: loading 
      ? Center(child: CircularProgressIndicator(),)
      :ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index){
          final item = posts[index];
          return ListTile(
            title: Text(item['title']),
            subtitle: Text(item['body']),
          );
        }
        )
      );
  }
}
