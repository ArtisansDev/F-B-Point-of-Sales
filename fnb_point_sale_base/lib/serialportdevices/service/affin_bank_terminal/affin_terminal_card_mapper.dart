// === MBB Terminal Card Type KEY  === //
// 01 - UPI
// 04 - VISA
// 05 - MASTER
// 06 - DINERS
// 07 - AMEX
// 08 - DEBIT
// 10 - GENTING CARD
// 11 - JCB

// === Create custom number to support Wallet & Union Pay of Affin terminal == //
// 20 - WALLET
// 21 - UNION_PAY

//== Affin Terminal Cart Type Response ==//

// VISA
// MASTERCARD
// AMEX
// MyDebit
// Wallet
// UNIONPAY

/// We need to create mapper to convert affin terminal response to mbb terminal response.
/// Because, mbb terminal key is being used in payment types to link to exact payment type.
String getPaymentCardFromAffinCode(String? cardType) {
  if ((cardType ?? "").toUpperCase().contains("VISA")) {
    return "04";
  }
  if ((cardType ?? "").toUpperCase().contains("MASTERCARD")) {
    return "05";
  }
  if ((cardType ?? "").toUpperCase().contains("AMEX")) {
    return "07";
  }

  if ((cardType ?? "").toUpperCase().contains("MYDEBIT")) {
    return "08";
  }

  if ((cardType ?? "").toUpperCase().contains("WALLET")) {
    return "20";
  }

  if ((cardType ?? "").toUpperCase().contains("UNIONPAY")) {
    return "21";
  }

  return cardType ?? "";
}
