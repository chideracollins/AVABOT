enum CreditCardType {
  visa,
  mastercard,
  amex,
  discover,
  verve,
  unionpay,
  maestro,
  dinersClub,
  jcb,
  mir,
  unknown
}

class CreditCardUtils {
  static String identifyCardType(String cardNumber) {
    // Remove any spaces or special characters
    cardNumber = cardNumber.replaceAll(RegExp(r'[\s-]'), '');

    // Verve Card (16-19 digits)
    // Starts with: 506099-506198, 650002-650027, 507865-507964
    if (RegExp(
            r'^(506099|5061[0-9][0-9]|650002|65000[3-9]|65001[0-9]|650020|650021|650022|650023|650024|650025|650026|650027|507865|507866|507867|507868|507869|507870|507871|507872|507873|507874|507875|507876|507877|507878|507879|507880|507881|507882|507883|507884|507885|507886|507887|507888|507889|507890|507891|507892|507893|507894|507895|507896|507897|507898|507899|507900|507901|507902|507903|507904|507905|507906|507907|507908|507909|507910|507911|507912|507913|507914|507915|507916|507917|507918|507919|507920|507921|507922|507923|507924|507925|507926|507927|507928|507929|507930|507931|507932|507933|507934|507935|507936|507937|507938|507939|507940|507941|507942|507943|507944|507945|507946|507947|507948|507949|507950|507951|507952|507953|507954|507955|507956|507957|507958|507959|507960|507961|507962|507963|507964)[0-9]{10,13}$')
        .hasMatch(cardNumber)) {
      return 'Verve';
    }

    // Visa
    // Starts with 4, length 13 or 16
    if (RegExp(r'^4[0-9]{12}(?:[0-9]{3})?$').hasMatch(cardNumber)) {
      return 'Visa';
    }

    // Mastercard
    // Starts with 51-55 or 2221-2720, length 16
    if (RegExp(
            r'^(5[1-5][0-9]{14}|2(22[1-9][0-9]{12}|2[3-9][0-9]{13}|[3-6][0-9]{14}|7[0-1][0-9]{13}|720[0-9]{12}))$')
        .hasMatch(cardNumber)) {
      return 'Mastercard';
    }

    // American Express
    // Starts with 34 or 37, length 15
    if (RegExp(r'^3[47][0-9]{13}$').hasMatch(cardNumber)) {
      return 'American Express';
    }

    // UnionPay
    // Starts with 62, length 16-19
    if (RegExp(r'^62[0-9]{14,17}$').hasMatch(cardNumber)) {
      return 'UnionPay';
    }

    // Discover
    // Starts with 6011, 644-649, 65, length 16
    if (RegExp(r'^(6011|64[4-9]|65)[0-9]{13,15}$').hasMatch(cardNumber)) {
      return 'Discover';
    }

    // Maestro
    // Starts with 5018, 5020, 5038, 5893, 6304, 6759, 6761, 6762, 6763, length 16-19
    if (RegExp(r'^(5018|5020|5038|5893|6304|6759|6761|6762|6763)[0-9]{8,15}$')
        .hasMatch(cardNumber)) {
      return 'Maestro';
    }

    // JCB
    // Starts with 3528-3589, length 16
    if (RegExp(r'^(352[8-9]|35[3-8][0-9]|3589)[0-9]{12}$')
        .hasMatch(cardNumber)) {
      return 'JCB';
    }

    // Diners Club
    // Starts with 300-305, 309, 36, 38-39, length 14
    if (RegExp(r'^(30[0-5]|309|36|3[8-9])[0-9]{12}$').hasMatch(cardNumber)) {
      return 'Diners Club';
    }

    // MIR
    // Starts with 2200-2204, length 16
    if (RegExp(r'^220[0-4][0-9]{12}$').hasMatch(cardNumber)) {
      return 'MIR';
    }

    // Unknown card type
    return 'Unknown Card';
  }

  // Luhn algorithm for card number validation
  static bool isValidCardNumber(String cardNumber) {
    if (cardNumber.isEmpty) return false;

    // Remove any spaces or dashes
    cardNumber = cardNumber.replaceAll(RegExp(r'[\s-]'), '');

    if (!RegExp(r'^[0-9]+$').hasMatch(cardNumber)) return false;

    int sum = 0;
    bool alternate = false;

    // Loop through values starting from the rightmost side
    for (int i = cardNumber.length - 1; i >= 0; i--) {
      int n = int.parse(cardNumber[i]);
      if (alternate) {
        n *= 2;
        if (n > 9) {
          n = (n % 10) + 1;
        }
      }
      sum += n;
      alternate = !alternate;
    }

    return (sum % 10 == 0);
  }
}
