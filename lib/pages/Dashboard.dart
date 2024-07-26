import 'package:flutter/material.dart';

class dashboard extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {'icon': Icons.games, 'title' : 'Gaming', 'color': const Color.fromARGB(255, 0, 0, 0)!},
    {'icon' : Icons.tv, 'title' : 'TV', 'color' : const Color.fromARGB(255, 0, 255, 8)!},
  ];
  dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info App'),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: categories[index]['color'],
                      child: 
                          Icon(categories[index]['icon'], color: Colors.white),
                    ),
                    title: Text(categories[index]['title']),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                );
              }
            
          )
        
      ),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,

            ),
            onPressed: () {
              print("Explore");
            },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: const Text(
              'Explore More',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
  
            ),
          ),
          ),
      ),
],
        ),
  
    );
  }
}