import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override

  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> expenseGroups = [
    'Food',
    'Transportation',
    'Utilities',
    'Entertainment',
    'Healthcare',
    'Others'
  ];

  void _addExpenseGroup(String groupName) {
    setState(() {
      expenseGroups.add(groupName);
    });
  }

  void _submitNewGroup(String groupName) {
    if (groupName.trim().isEmpty) return;
    _addExpenseGroup(groupName.trim());
    Navigator.of(context).pop();
  }

  void _showAddGroupDialog() {
    String newGroupName = '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Expense Group'),
        content: TextField(
          autocorrect: true,
          decoration: const InputDecoration(
            hintText: 'Enter group name',
          ),
          onChanged: (value) {
            newGroupName = value;
          },
          onSubmitted: (_) {
            _submitNewGroup(newGroupName);
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), 
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              _submitNewGroup(newGroupName);
            }, 
            child: const Text('Add'),
          )
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Expense Tracker')),
      body: Center(
        child: ListView.builder(
          itemCount: expenseGroups.length,
          itemBuilder: (context, index) {
            final group = expenseGroups[index];
            return ListTile(
              title: Text(group),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Tapped on $group'),
                  )
                );
              }
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddGroupDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
