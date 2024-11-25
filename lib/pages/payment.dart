import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/shopping_cart.dart';
import '../utils/constants/images.dart';
import '../widgets/dialogs/success_dialog.dart';
import 'shop.dart';

class PaymentPage extends StatefulWidget {
  final double totalAmount;

  const PaymentPage(this.totalAmount, {super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSavedCardDetails();
  }

  Future<void> _loadSavedCardDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _cardNumberController.text = prefs.getString('cardNumber') ?? '';
      _expiryDateController.text = prefs.getString('expiryDate') ?? '';
      _cvvController.text = prefs.getString('cvvCode') ?? '';
    });
  }

  String? _validateCardNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Card number is required';
    }
    String cleanedValue = value.replaceAll(RegExp(r'\D'), '');
    if (cleanedValue.length < 16 || cleanedValue.length > 19) {
      return 'Card number must be 16-19 digits';
    }
    return null;
  }

  String? _validateExpiryDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Expiry date is required';
    }
    if (!RegExp(r'^(0[1-9]|1[0-2])\/\d{2}$').hasMatch(value)) {
      return 'Expiry date must be in MM/YY format';
    }
    return null;
  }

  String? _validateCVV(String? value) {
    if (value == null || value.isEmpty) {
      return 'CVV is required';
    }
    if (value.length != 3) {
      return 'CVV must be 3 digits';
    }
    return null;
  }

  void _onPayNow() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => const SuccessDialog(),
    );

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const ShopPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final shoppingCart = Provider.of<ShoppingCart>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            IconButton(
              icon: const Image(
                image: AssetImage(Images.logo),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShopPage(),
                  ),
                );
              },
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Enter your card details to pay",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // Card Number Input
                TextFormField(
                  controller: _cardNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Card Number',
                    hintText: 'XXXX XXXX XXXX XXXX',
                    border: UnderlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(19),
                    _CardNumberFormatter(),
                  ],
                  validator: _validateCardNumber,
                ),
                const SizedBox(height: 16),

                // Row for Expiry Date and CVV
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _expiryDateController,
                        decoration: const InputDecoration(
                          labelText: 'Expiry Date',
                          hintText: 'MM/YY',
                          border: UnderlineInputBorder(),
                          labelStyle: TextStyle(color: Colors.white),
                          hintStyle: TextStyle(color: Colors.white70),
                        ),
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(4),
                          _ExpiryDateFormatter(),
                        ],
                        validator: _validateExpiryDate,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _cvvController,
                        decoration: const InputDecoration(
                          labelText: 'CVV',
                          hintText: 'XXX',
                          border: UnderlineInputBorder(),
                          labelStyle: TextStyle(color: Colors.white),
                          hintStyle: TextStyle(color: Colors.white70),
                        ),
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.number,
                        obscureText: true,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3),
                        ],
                        validator: _validateCVV,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Pay Now Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: () {
                      _onPayNow();
                      shoppingCart.clearCart();
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF0797BA), Color(0xFF01F123)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        constraints: const BoxConstraints(maxHeight: 50.0),
                        child: Text(
                          'Pay ₦${widget.totalAmount.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text.replaceAll(' ', '');
    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(' ');
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}

class _ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text.replaceAll('/', '');
    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex == 2) {
        buffer.write('/');
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}
