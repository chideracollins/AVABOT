import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants/colors.dart';
import '../utils/helpers/card_validator.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String cardNumber = '';
  String expiryDate = '';
  String cvvCode = '';
  String cardHolderName = '';
  bool isCvvFocused = false;

  Future<void> saveCardDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('cardNumber', cardNumber);
    await prefs.setString('expiryDate', expiryDate);
    await prefs.setString('cvvCode', cvvCode);
    await prefs.setString('cardHolderName', cardHolderName);
  }

  void onSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await saveCardDetails();
      if (mounted) {
        Navigator.pop(context, true);
      }
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Add Card",
      )),
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
                  cardNumberValidator: CardValidations.validateCardNumber,
                  expiryDateValidator: CardValidations.validateExpiryDate,
                  cvvValidator: CardValidations.validateCvv,
                  isHolderNameVisible: false,
                  obscureCvv: true,
                  obscureNumber: false,
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
                          gradient: AppColors.buttonLinearGradient,
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
