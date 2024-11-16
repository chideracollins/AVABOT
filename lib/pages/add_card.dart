import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _pinFormKey = GlobalKey<FormFieldState>();
  final TextEditingController pinController = TextEditingController();

  String cardNumber = '';
  String expiryDate = '';
  String cvvCode = '';
  String pinCode = '';
  String cardHolderName = '';
  bool isCvvFocused = false;

  String? validateCardNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Card number is required';
    }
    if (value.length < 16 || value.length > 19) {
      return 'Card number must be 16-19 digits';
    }
    return null;
  }

  String? validateExpiryDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Expiry date is required';
    }
    if (!RegExp(r"^(0[1-9]|1[0-2])\/\d{2}$").hasMatch(value)) {
      return 'Expiry date must be in MM/YY format';
    }
    return null;
  }

  String? validateCvv(String? value) {
    if (value == null || value.isEmpty) {
      return 'CVV is required';
    }
    if (value.length != 3) {
      return 'CVV must be 3 digits';
    }
    return null;
  }

  String? validatePinCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'PIN is required';
    }
    if (value.length != 4) {
      return 'PIN must be 4 digits';
    }
    if (!RegExp(r'^\d{4}$').hasMatch(value)) {
      return 'PIN must contain only numbers';
    }
    return null;
  }

  Future<void> saveCardDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('cardNumber', cardNumber);
    await prefs.setString('expiryDate', expiryDate);
    await prefs.setString('cvvCode', cvvCode);
    await prefs.setString('pinCode', pinCode);
    await prefs.setString('cardHolderName', cardHolderName);
  }

  void onSubmit() async {
    if (_formKey.currentState!.validate() &&
        _pinFormKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _pinFormKey.currentState!.save();
      await saveCardDetails();
      Navigator.pop(context, true);
    }
  }

  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        cardHolderName = user.displayName ?? '';
      });
    }
  }

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          "Add Card",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.only(
            left: 20.0,
            top: 0.0,
            right: 20.0,
            bottom: 20.0,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceDim,
            borderRadius: BorderRadius.circular(12),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CreditCardForm(
                  formKey: _formKey,
                  cardNumber: cardNumber,
                  cardHolderName: cardHolderName,
                  expiryDate: expiryDate,
                  cvvCode: cvvCode,
                  onCreditCardModelChange: (CreditCardModel data) {
                    setState(() {
                      cardNumber = data.cardNumber;
                      expiryDate = data.expiryDate;
                      cvvCode = data.cvvCode;
                      isCvvFocused = data.isCvvFocused;
                    });
                  },
                  cardNumberValidator: validateCardNumber,
                  expiryDateValidator: validateExpiryDate,
                  cvvValidator: validateCvv,
                  isHolderNameVisible: false,
                  obscureCvv: true,
                  obscureNumber: true,
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: TextFormField(
                    key: _pinFormKey,
                    controller: pinController,
                    decoration: const InputDecoration(
                      labelText: 'Transaction PIN',
                      hintText: 'Enter 4-digit transaction PIN',
                      border: UnderlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    validator: validatePinCode,
                    onSaved: (value) => pinCode = value ?? '',
                    maxLength: 4,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: onSubmit,
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
                          child: const Text(
                            'Done',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
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
