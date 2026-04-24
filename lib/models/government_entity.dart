class GovernmentEntity {
  final String name;
  final String category; // Regional Sector, Zone, Woreda, etc.
  final String description;
  final String? website;
  final String? address;
  final String? contact;
  final String imageUrl;

  GovernmentEntity({
    required this.name,
    required this.category,
    required this.description,
    this.website,
    this.address,
    this.contact,
    required this.imageUrl,
  });
}
