class UserModel {
  final int id;
  final String name;
  final String email;
  final String? jenisKelamin;
  final String? profilePhoto;
  final int? batchId;
  final int? trainingId;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.jenisKelamin,
    this.profilePhoto,
    this.batchId,
    this.trainingId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      jenisKelamin: json['jenis_kelamin'],
      profilePhoto: json['profile_photo'],
      batchId: json['batch_id'] is String
          ? int.tryParse(json['batch_id'])
          : json['batch_id'],
      trainingId: json['training_id'] is String
          ? int.tryParse(json['training_id'])
          : json['training_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'jenis_kelamin': jenisKelamin,
      'profile_photo': profilePhoto,
      'batch_id': batchId,
      'training_id': trainingId,
    };
  }
}
