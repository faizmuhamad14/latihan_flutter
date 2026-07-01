import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../models/training_model.dart';
import '../../models/batch_model.dart';
import '../../services/api_service.dart';
import '../../services/auth_provider.dart';
import '../../utils/constants.dart';
import '../../utils/helper.dart';
import '../home/dashboard_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  
  // Input controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  String? _gender = 'L'; // L or P
  int? _selectedTrainingId;
  int? _selectedBatchId;
  
  File? _imageFile;
  String? _base64Photo;
  bool _obscurePassword = true;
  
  late Future<List<dynamic>> _dropdownDataFuture;

  @override
  void initState() {
    super.initState();
    _dropdownDataFuture = Future.wait([
      ApiService.getTrainings(),
      ApiService.getBatches(''),
    ]);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  /// Pick Image from camera or gallery
  Future<void> _pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: source,
        maxWidth: 500,
        maxHeight: 500,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        final file = File(pickedFile.path);
        final base64 = await AppHelpers.fileToBase64(file);
        
        setState(() {
          _imageFile = file;
          _base64Photo = base64;
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      if (mounted) {
        AppHelpers.showSnackBar(context, 'Gagal memilih gambar.', isError: true);
      }
    }
  }

  /// Display bottom sheet modal to choose Camera or Gallery
  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppConstants.cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Pilih Foto Profil',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.camera);
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppConstants.secondaryColor.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.camera_alt_rounded, size: 30, color: AppConstants.secondaryColor),
                          ),
                          const SizedBox(height: 8),
                          const Text('Kamera', style: TextStyle(color: Colors.white70)),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.gallery);
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppConstants.secondaryColor.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.photo_library_rounded, size: 30, color: AppConstants.secondaryColor),
                          ),
                          const SizedBox(height: 8),
                          const Text('Galeri', style: TextStyle(color: Colors.white70)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    
    if (_selectedTrainingId == null || _selectedBatchId == null) {
      AppHelpers.showSnackBar(context, 'Data pelatihan atau batch belum terisi.', isError: true);
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final error = await authProvider.register(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      gender: _gender!,
      profilePhotoBase64: _base64Photo,
      batchId: _selectedBatchId!,
      trainingId: _selectedTrainingId!,
    );

    if (!mounted) return;

    if (error != null) {
      AppHelpers.showSnackBar(context, error, isError: true);
    } else {
      AppHelpers.showSnackBar(context, 'Registrasi Berhasil!');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const DashboardView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<AuthProvider>(context).isLoading;

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        title: const Text('Daftar Akun Baru'),
        backgroundColor: AppConstants.primaryColor,
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppConstants.primaryColor,
              AppConstants.backgroundColor,
            ],
          ),
        ),
        child: FutureBuilder<List<dynamic>>(
          future: _dropdownDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: AppConstants.secondaryColor),
                    SizedBox(height: 16),
                    Text(
                      'Memuat data pelatihan...',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              );
            }

            final trainings = snapshot.hasData ? (snapshot.data![0] as List<TrainingModel>) : <TrainingModel>[];
            final batches = snapshot.hasData ? (snapshot.data![1] as List<BatchModel>) : <BatchModel>[];

            // Auto-select first if none selected
            if (trainings.isNotEmpty && _selectedTrainingId == null) {
              _selectedTrainingId = trainings.first.id;
            }
            if (batches.isNotEmpty && _selectedBatchId == null) {
              _selectedBatchId = batches.first.id;
            }

            return SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Photo Upload Picker
                      Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 55,
                              backgroundColor: AppConstants.cardColor,
                              backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
                              child: _imageFile == null
                                  ? const Icon(
                                      Icons.person_add_alt_1_rounded,
                                      size: 50,
                                      color: Colors.white60,
                                    )
                                  : null,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: _showImagePickerOptions,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    color: AppConstants.secondaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt_rounded,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      
                      // Full Name Field
                      TextFormField(
                        controller: _nameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: _buildInputDecoration('Nama Lengkap', Icons.person_outline),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Nama lengkap wajib diisi';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),
                      
                      // Email Field
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(color: Colors.white),
                        decoration: _buildInputDecoration('Email', Icons.email_outlined),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Email wajib diisi';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
                            return 'Format email tidak valid';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),
                      
                      // Password Field
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        style: const TextStyle(color: Colors.white),
                        decoration: _buildInputDecoration('Password', Icons.lock_outlined).copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              color: Colors.white70,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Password wajib diisi';
                          }
                          if (value.trim().length < 6) {
                            return 'Password minimal 6 karakter';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),
                      
                      // Gender selection (L / P)
                      DropdownButtonFormField<String>(
                        value: _gender,
                        dropdownColor: AppConstants.cardColor,
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                        decoration: _buildInputDecoration('Jenis Kelamin', Icons.wc_rounded),
                        items: const [
                          DropdownMenuItem(value: 'L', child: Text('Laki-laki (L)')),
                          DropdownMenuItem(value: 'P', child: Text('Perempuan (P)')),
                        ],
                        onChanged: (val) {
                          setState(() {
                            _gender = val;
                          });
                        },
                      ),
                      const SizedBox(height: 18),
                      
                      // Training Dropdown (Fetched dynamically)
                      DropdownButtonFormField<int>(
                        value: _selectedTrainingId,
                        dropdownColor: AppConstants.cardColor,
                        style: const TextStyle(color: Colors.white, fontSize: 15),
                        isExpanded: true,
                        decoration: _buildInputDecoration('Pelatihan', Icons.school_outlined),
                        items: trainings.map((t) {
                          return DropdownMenuItem<int>(
                            value: t.id,
                            child: Text(
                              t.title,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            _selectedTrainingId = val;
                          });
                        },
                        validator: (value) => value == null ? 'Pilih pelatihan wajib diisi' : null,
                      ),
                      const SizedBox(height: 18),
                      
                      // Batch Dropdown (Fetched dynamically / fallbacks)
                      DropdownButtonFormField<int>(
                        value: _selectedBatchId,
                        dropdownColor: AppConstants.cardColor,
                        style: const TextStyle(color: Colors.white, fontSize: 15),
                        isExpanded: true,
                        decoration: _buildInputDecoration('Angkatan (Batch)', Icons.calendar_month_outlined),
                        items: batches.map((b) {
                          return DropdownMenuItem<int>(
                            value: b.id,
                            child: Text(
                              b.title,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            _selectedBatchId = val;
                          });
                        },
                        validator: (value) => value == null ? 'Pilih angkatan wajib diisi' : null,
                      ),
                      const SizedBox(height: 36),
                      
                      // Submit Button
                      ElevatedButton(
                        onPressed: isLoading ? null : _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConstants.secondaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                        ),
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : const Text(
                                'Daftar Akun',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              );
          },
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      prefixIcon: Icon(icon, color: AppConstants.secondaryColor),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppConstants.secondaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 2),
      ),
    );
  }
}
