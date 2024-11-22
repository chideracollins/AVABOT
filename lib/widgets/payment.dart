// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_paystack_max/flutter_paystack_max.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import '../widgets/dialogs/success_dialog.dart';
// import '../widgets/dialogs/failure_dialog.dart';

// class Payment extends StatelessWidget {
//   final double totalAmount;

//   const Payment({Key? key, required this.totalAmount});

//   Future<void> _processPayment(BuildContext context) async {
//     final secretKey = dotenv.env['PAYSTACK_SECRET_KEY'];
//     final userEmail = FirebaseAuth.instance.currentUser?.email;

//     if (secretKey == null || userEmail == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Payment configuration error")),
//       );
//       return;
//     }

//     final reference = 'cart_${DateTime.now().microsecondsSinceEpoch}';
//     final amountInKobo = (totalAmount * 100.0);

//     final request = PaystackTransactionRequest(
//       reference: reference,
//       secretKey: secretKey,
//       email: userEmail,
//       amount: amountInKobo,
//       currency: PaystackCurrency.ngn,
//       channel: [
//         PaystackPaymentChannel.card,
//         PaystackPaymentChannel.bankTransfer,
//       ],
//     );

//     try {
//       final transaction = await PaymentService.initializeTransaction(request);

//       if (!transaction.status) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(transaction.message)),
//         );
//         Navigator.push(
//             context, MaterialPageRoute(builder: (_) => const FailureDialog()));
//         return;
//       }

//       try {
//         await PaymentService.showPaymentModal(
//           context,
//           transaction: transaction,
//           callbackUrl: dotenv.env['PAYSTACK_CALLBACK_URL'] ?? '',
//         );

//         if (!context.mounted) return;
//         Navigator.push(
//             context, MaterialPageRoute(builder: (_) => const SuccessDialog()));
//       } catch (modalError) {
//         if (!context.mounted) return;
//         Navigator.push(
//             context, MaterialPageRoute(builder: (_) => const FailureDialog()));
//       }
//     } catch (e) {
//       if (!context.mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("An error occurred: $e")),
//       );
//       Navigator.push(
//           context, MaterialPageRoute(builder: (_) => const FailureDialog()));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Payment'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text(
//               "Total Amount: ₦${totalAmount.toStringAsFixed(2)}",
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 24),
//             ElevatedButton(
//               onPressed: () => _processPayment(context),
//               child: const Text("Proceed to Pay"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
