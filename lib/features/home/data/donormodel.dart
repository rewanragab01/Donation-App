class DonorModel {
  final String id;
  final String email;
  final String phone;
  final String bloodType;

  DonorModel({
    required this.id,
    required this.email,
    required this.phone,
    required this.bloodType,
  });

  // Factory method to create a DonorModel from Firestore data
  factory DonorModel.fromFirestore(Map<String, dynamic> data, String id) {
    return DonorModel(
      id: id,
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      bloodType: data['bloodType'] ?? '',
    );
  }
}
