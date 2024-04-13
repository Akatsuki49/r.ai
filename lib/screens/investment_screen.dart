import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class InvestmentScreen extends StatefulWidget {
  @override
  _InvestmentScreenState createState() => _InvestmentScreenState();
}

class _InvestmentScreenState extends State<InvestmentScreen> {
  List<dynamic> _investmentUpdates = [];

  @override
  void initState() {
    super.initState();
    _fetchInvestmentUpdates();
  }

  Future<void> _fetchInvestmentUpdates() async {
    try {
      var url = Uri.parse('https://your-api-endpoint.com/investment_updates');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          _investmentUpdates = json.decode(response.body);
        });
      } else {
        print('Failed to fetch investment updates');
      }
    } catch (e) {
      print('Error fetching investment updates: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Investment Updates'),
        backgroundColor: Colors.green[800],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green[200]!,
              Colors.green[400]!,
            ],
          ),
        ),
        child: ListView.builder(
          itemCount: _investmentUpdates.length,
          itemBuilder: (context, index) {
            final update = _investmentUpdates[index];
            return Card(
              color: Colors.green[100],
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  update['headline'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800],
                  ),
                ),
                subtitle: Text(
                  update['timestamp'],
                  style: TextStyle(
                    color: Colors.green[700],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
