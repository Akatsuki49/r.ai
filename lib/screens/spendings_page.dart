import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:arithmania_frontend/widgets/transaction_list.dart';

class SpendingsPage extends StatefulWidget {
  const SpendingsPage({Key? key}) : super(key: key);

  @override
  State<SpendingsPage> createState() => _SpendingsPageState();
}

class _SpendingsPageState extends State<SpendingsPage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  String _type = "expense";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 10),
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My spendings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 300),
                child: Container(
                  color: Colors.red,
                  height: 60,
                  width: 60,
                ),
              ),
              Container(
                color: Colors.white,
                height: 150,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    color: Colors.white,
                    height: 70,
                    width: 70,
                  ),
                  Container(
                    color: Colors.white,
                    height: 70,
                    width: 70,
                  ),
                  Container(
                    color: Colors.white,
                    height: 70,
                    width: 70,
                  ),
                  Container(
                    color: Colors.white,
                    height: 70,
                    width: 70,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Color(0xff019254),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: GestureDetector(
                        onTap: () => _showTransactionDialog(),
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Text('Recent',
                  style: TextStyle(color: Colors.white, fontSize: 25)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TransactionList(
                    userId: FirebaseAuth.instance.currentUser!.uid,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget chotawidget() {
    return Container(
      color: Colors.white,
      height: 70,
      width: 70,
    );
  }

  void _showTransactionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Transaction'),
          content: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Amount'),
                  ),
                  TextFormField(
                    controller: _categoryController,
                    decoration: InputDecoration(labelText: 'Category'),
                  ),
                  DropdownButton<String>(
                    value: _type,
                    onChanged: (String? newValue) {
                      setState(() {
                        _type = newValue!;
                      });
                    },
                    items: <String>['expense', 'income'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _addTransaction();
                Navigator.of(context).pop();
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void _addTransaction() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('transactions')
        .add({
      "amount": double.parse(_amountController.text),
      "type": _type,
      "category": _categoryController.text,
      "description": "Added manually",
      "timestamp": DateTime.now(),
    }).then((value) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Transaction added successfully.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      print('Transaction added successfully.');
    }).catchError((error) {
      print('Error adding transaction: $error');
    });
  }
}
