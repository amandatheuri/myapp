import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/waste_collector/controllers/waste_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final WasteController _wasteController = Get.put(WasteController());
  String userEmail = '';
  double plasticAmount = 0;
  double glassAmount = 0;
  double paperAmount = 0;
  double totalAmount = 0;

  void _calculateTotal() {
    setState(() {
      totalAmount = plasticAmount + glassAmount + paperAmount;
    });
  }

  void _verifyData() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Show a loading indicator
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Center(child: CircularProgressIndicator()),
        );

        await _wasteController.saveWasteData(
          userEmail: userEmail,
          plasticAmount: plasticAmount,
          glassAmount: glassAmount,
          paperAmount: paperAmount,
          totalAmount: totalAmount,
        );

        // Close the loading indicator
        Navigator.of(context).pop();

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Data verified and submitted!'),
            backgroundColor: Colors.green,
          ),
        );

        // Clear the form
        _formKey.currentState!.reset();
        setState(() {
          plasticAmount = 0;
          glassAmount = 0;
          paperAmount = 0;
          totalAmount = 0;
        });
      } catch (e) {
        // Close the loading indicator
        Navigator.of(context).pop();

        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to submit data: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello, Admin!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'User Email',
                    border: OutlineInputBorder(),
                    hintText: 'Enter the user\'s email address',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the user\'s email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      userEmail = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                _buildCategoryField('Plastic', plasticAmount, (value) {
                  setState(() {
                    plasticAmount = value;
                    _calculateTotal();
                  });
                }),
                SizedBox(height: 20),
                _buildCategoryField('Glass', glassAmount, (value) {
                  setState(() {
                    glassAmount = value;
                    _calculateTotal();
                  });
                }),
                SizedBox(height: 20),
                _buildCategoryField('Paper', paperAmount, (value) {
                  setState(() {
                    paperAmount = value;
                    _calculateTotal();
                  });
                }),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green.withOpacity(0.5)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Waste:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${totalAmount.toStringAsFixed(1)} kg',
                        style: TextStyle(
                          fontSize: 18, 
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue.withOpacity(0.5)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tokens to Award:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${(totalAmount * WasteController.TOKENS_PER_KG).toInt()}',
                        style: TextStyle(
                          fontSize: 18, 
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[700],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _verifyData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Verify and Submit', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
Widget _buildCategoryField(String label, double amount, Function(double) onChanged) {
  final TextEditingController controller = TextEditingController(
    text: amount > 0 ? amount.toString() : '',
  );
  
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.withOpacity(0.5)),
    ),
    child: Row(
      children: [
        // Checkbox to enable/disable the field
        Checkbox(
          value: amount > 0,
          onChanged: (value) {
            if (value == true) {
              // If checked and amount is 0, set to 0.1 as default
              if (amount <= 0) {
                onChanged(0.1);
                controller.text = '0.1';
              }
            } else {
              // If unchecked, reset amount to 0
              onChanged(0);
              controller.text = '';
            }
          },
        ),
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: 'Amount (kg)',
              border: OutlineInputBorder(),
              // Don't use enabled property as it prevents interaction
              // Provide a hint instead
              hintText: amount > 0 ? null : 'Check to enable',
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onChanged: (value) {
              final newAmount = double.tryParse(value) ?? 0;
              onChanged(newAmount);
            },
            // Allow input even if checkbox is not checked
          ),
        ),
      ],
    ),
  );
}
}