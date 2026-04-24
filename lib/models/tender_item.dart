class TenderItem {
  final String title;
  final String id;
  final String category; // Active, Free, Paid, etc.
  final String organization;
  final String closingDate;
  final String fee;
  final int daysLeft;
  final bool isFeeRequired;
  final String? documentUrl;

  TenderItem({
    required this.title,
    required this.id,
    required this.category,
    required this.organization,
    required this.closingDate,
    required this.fee,
    required this.daysLeft,
    this.isFeeRequired = true,
    this.documentUrl,
  });
}
