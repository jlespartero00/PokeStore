import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _address = '';
  String _city = '';
  String _zip = '';
  String _paymentMethod = 'Credit Card';

  void _placeOrder() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      // Clear cart after successful order
      final cart = Provider.of<CartModel>(context, listen: false);
      cart.clear();

      // Show confirmation dialog
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Order Confirmed'),
          content: const Text('Thank you for your purchase! Your order is being processed.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop(); // Close dialog
                Navigator.of(context).popUntil((route) => route.isFirst); // Back to home
              },
              child: const Text('OK'),
            )
          ],
        ),
      );
    }
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required FormFieldSetter<String> onSaved,
    required FormFieldValidator<String> validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'Shipping Information',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              _buildTextField(
                label: 'Full Name',
                hint: 'Enter your full name',
                validator: (val) =>
                    (val == null || val.trim().isEmpty) ? 'Please enter your full name' : null,
                onSaved: (val) => _name = val!.trim(),
              ),
              _buildTextField(
                label: 'Address',
                hint: 'Enter your address',
                validator: (val) =>
                    (val == null || val.trim().isEmpty) ? 'Please enter your address' : null,
                onSaved: (val) => _address = val!.trim(),
              ),
              _buildTextField(
                label: 'City',
                hint: 'Enter your city',
                validator: (val) =>
                    (val == null || val.trim().isEmpty) ? 'Please enter your city' : null,
                onSaved: (val) => _city = val!.trim(),
              ),
              _buildTextField(
                label: 'ZIP Code',
                hint: 'Enter ZIP code',
                keyboardType: TextInputType.number,
                validator: (val) =>
                    (val == null || val.trim().isEmpty) ? 'Please enter ZIP code' : null,
                onSaved: (val) => _zip = val!.trim(),
              ),
              const SizedBox(height: 20),
              const Text(
                'Payment Method',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Column(
                children: [
                  RadioListTile<String>(
                    title: const Text('Credit Card'),
                    value: 'Credit Card',
                    groupValue: _paymentMethod,
                    onChanged: (value) {
                      setState(() {
                        _paymentMethod = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('PayPal'),
                    value: 'PayPal',
                    groupValue: _paymentMethod,
                    onChanged: (value) {
                      setState(() {
                        _paymentMethod = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Cash on Delivery'),
                    value: 'Cash on Delivery',
                    groupValue: _paymentMethod,
                    onChanged: (value) {
                      setState(() {
                        _paymentMethod = value!;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _placeOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  'Place Order',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
