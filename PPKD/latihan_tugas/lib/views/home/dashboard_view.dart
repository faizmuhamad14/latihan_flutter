import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../models/user_model.dart';
import '../../services/api_service.dart';
import '../../services/auth_provider.dart';
import '../../utils/constants.dart';
import '../../utils/helper.dart';
import '../auth/login_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _currentIndex = 0;
  late Future<List<dynamic>> _usersFuture;

  @override
  void initState() {
    super.initState();
    // Refresh user profile details from backend
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthProvider>(context, listen: false).refreshProfile();
      _fetchUsers();
    });
  }

  /// Fetch all users list from API
  void _fetchUsers() {
    final token = Provider.of<AuthProvider>(context, listen: false).token ?? '';
    setState(() {
      _usersFuture = ApiService.getAllUsers(token);
    });
  }

  /// Trigger Name Edit Modal Dialog
  void _showEditNameDialog(String currentName) {
    final nameController = TextEditingController(text: currentName);
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppConstants.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Ubah Nama Profil',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: nameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Nama Baru',
                labelStyle: const TextStyle(color: Colors.white70),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppConstants.secondaryColor),
                ),
              ),
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return 'Nama tidak boleh kosong';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Batal',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConstants.secondaryColor,
              ),
              onPressed: () async {
                if (!formKey.currentState!.validate()) return;

                final authProvider = Provider.of<AuthProvider>(
                  context,
                  listen: false,
                );
                Navigator.pop(context);

                final error = await authProvider.updateProfileName(
                  nameController.text.trim(),
                );
                if (!mounted) return;

                if (error != null) {
                  AppHelpers.showSnackBar(context, error, isError: true);
                } else {
                  AppHelpers.showSnackBar(context, 'Nama berhasil diperbarui!');
                  _fetchUsers(); // Refresh users list
                }
              },
              child: const Text(
                'Simpan',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Picker Options for Profil Photo Update
  Future<void> _pickAndUploadImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: source,
        maxWidth: 400,
        maxHeight: 400,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        final file = File(pickedFile.path);
        final base64 = await AppHelpers.fileToBase64(file);

        if (base64 == null) return;

        if (!mounted) return;
        final authProvider = Provider.of<AuthProvider>(context, listen: false);

        // Show indicator
        AppHelpers.showSnackBar(context, 'Mengunggah foto...');

        final error = await authProvider.updateProfilePhoto(base64);
        if (!mounted) return;

        if (error != null) {
          AppHelpers.showSnackBar(context, error, isError: true);
        } else {
          AppHelpers.showSnackBar(context, 'Foto profil berhasil diperbarui!');
        }
      }
    } catch (e) {
      debugPrint('Error uploading photo: $e');
      if (mounted) {
        AppHelpers.showSnackBar(
          context,
          'Gagal mengunggah foto.',
          isError: true,
        );
      }
    }
  }

  void _showPhotoOptionsBottomSheet() {
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
                  'Perbarui Foto Profil',
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
                        _pickAndUploadImage(ImageSource.camera);
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppConstants.secondaryColor.withValues(
                                alpha: 0.1,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              size: 30,
                              color: AppConstants.secondaryColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Kamera',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        _pickAndUploadImage(ImageSource.gallery);
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppConstants.secondaryColor.withValues(
                                alpha: 0.1,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.photo_library_rounded,
                              size: 30,
                              color: AppConstants.secondaryColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Galeri',
                            style: TextStyle(color: Colors.white70),
                          ),
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

  void _logout() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.logout();

    if (!mounted) return;
    AppHelpers.showSnackBar(context, 'Keluar Sesi Berhasil');
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;
    final isLoading = authProvider.isLoading;

    final tabs = [_buildProfileTab(user, isLoading), _buildUsersDirectoryTab()];

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        title: const Text('PORTAL MAHASISWA PPKD'),
        backgroundColor: AppConstants.primaryColor,
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout_rounded,
              color: AppConstants.accentColor,
            ),
            tooltip: 'Logout',
            onPressed: _logout,
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppConstants.primaryColor, AppConstants.backgroundColor],
          ),
        ),
        child: tabs[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: AppConstants.primaryColor,
        selectedItemColor: AppConstants.secondaryColor,
        unselectedItemColor: Colors.white54,
        elevation: 8,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 1) {
            _fetchUsers();
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profil Saya',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_rounded),
            label: 'Daftar Anggota',
          ),
        ],
      ),
    );
  }

  /// TAB 1: User Profile Screen
  Widget _buildProfileTab(UserModel? user, bool isLoading) {
    if (user == null) {
      return const Center(
        child: CircularProgressIndicator(color: AppConstants.secondaryColor),
      );
    }

    String? photoUrl = user.profilePhoto;
    if (photoUrl != null && photoUrl.isNotEmpty) {
      if (photoUrl.startsWith('http://127.0.0.1:8000')) {
        photoUrl = photoUrl.replaceFirst('http://127.0.0.1:8000', AppConstants.baseUrl);
      }
      if (photoUrl.contains('public/storage/')) {
        photoUrl = photoUrl.replaceAll('public/storage/', 'storage/');
      }
      if (!photoUrl.startsWith('http://') && !photoUrl.startsWith('https://') && !photoUrl.startsWith('data:image')) {
        final separator = photoUrl.startsWith('/') ? '' : '/';
        photoUrl = '${AppConstants.baseUrl}$separator$photoUrl';
      }
    }
    final hasPhoto = photoUrl != null && photoUrl.isNotEmpty;
    final isBase64 = photoUrl != null && photoUrl.startsWith('data:image');

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Profile Photo & Title Card
          Card(
            color: AppConstants.cardColor,
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              side: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 36.0,
                horizontal: 16.0,
              ),
              child: Column(
                children: [
                  // Photo picker with loading indicator
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppConstants.secondaryColor.withValues(
                              alpha: 0.5,
                            ),
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppConstants.secondaryColor.withValues(
                                alpha: 0.2,
                              ),
                              blurRadius: 15,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Container(
                          width: 130,
                          height: 130,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppConstants.backgroundColor,
                          ),
                          child: ClipOval(
                            child: isBase64
                                ? Image.memory(
                                    base64Decode(photoUrl.split(',').last),
                                    fit: BoxFit.cover,
                                  )
                                : (hasPhoto
                                    ? Image.network(
                                        photoUrl,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return const Icon(
                                            Icons.account_circle,
                                            size: 130,
                                            color: Colors.white38,
                                          );
                                        },
                                      )
                                    : const Icon(
                                        Icons.account_circle,
                                        size: 130,
                                        color: Colors.white38,
                                      )),
                          ),
                        ),
                      ),
                      if (isLoading)
                        Positioned.fill(
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.black45,
                              shape: BoxShape.circle,
                            ),
                            child: const CircularProgressIndicator(
                              color: AppConstants.secondaryColor,
                            ),
                          ),
                        ),
                      Positioned(
                        bottom: 0,
                        right: 8,
                        child: GestureDetector(
                          onTap: _showPhotoOptionsBottomSheet,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: AppConstants.secondaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_enhance_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Username
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        user.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(
                          Icons.edit_note_rounded,
                          color: AppConstants.secondaryColor,
                          size: 24,
                        ),
                        onPressed: () => _showEditNameDialog(user.name),
                        tooltip: 'Ubah Nama',
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // Email
                  Text(
                    user.email,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppConstants.textColorSecondary.withValues(
                        alpha: 0.7,
                      ),
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Badge gender
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: (user.jenisKelamin == 'L')
                          ? Colors.blueAccent.withValues(alpha: 0.2)
                          : Colors.pinkAccent.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: (user.jenisKelamin == 'L')
                            ? Colors.blueAccent.withValues(alpha: 0.4)
                            : Colors.pinkAccent.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Text(
                      user.jenisKelamin == 'L' ? 'Laki-Laki' : 'Perempuan',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: (user.jenisKelamin == 'L')
                            ? Colors.blue
                            : Colors.pink,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Training Details info cards
          const Text(
            'Informasi Kelas Pelatihan',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white70,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),

          // Info list
          _buildInfoRow(
            'ID Pelatihan',
            user.trainingId != null
                ? 'Pelatihan #${user.trainingId}'
                : 'Tidak Terdaftar',
          ),
          const SizedBox(height: 10),
          _buildInfoRow(
            'ID Angkatan (Batch)',
            user.batchId != null ? 'Batch #${user.batchId}' : 'Tidak Terdaftar',
          ),
          const SizedBox(height: 10),
          _buildInfoRow('ID Registrasi Pengguna', '#${user.id}'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppConstants.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white60, fontSize: 14),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  /// TAB 2: Users Directory Tab
  Widget _buildUsersDirectoryTab() {
    return RefreshIndicator(
      onRefresh: () async {
        _fetchUsers();
        await _usersFuture;
      },
      child: FutureBuilder<List<dynamic>>(
        future: _usersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: AppConstants.secondaryColor),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Terjadi kesalahan: ${snapshot.error}',
                style: const TextStyle(color: Colors.white70),
              ),
            );
          }

          final usersList = snapshot.data ?? [];

          if (usersList.isEmpty) {
            return ListView(
              children: const [
                SizedBox(height: 100),
                Center(
                  child: Text(
                    'Tidak ada data pengguna terdaftar.',
                    style: TextStyle(color: Colors.white60),
                  ),
                ),
              ],
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: usersList.length,
            itemBuilder: (context, index) {
              final usr = usersList[index];
              String? imgUrl = usr['profile_photo']?.toString();
              if (imgUrl != null && imgUrl.isNotEmpty) {
                if (imgUrl.startsWith('http://127.0.0.1:8000')) {
                  imgUrl = imgUrl.replaceFirst('http://127.0.0.1:8000', AppConstants.baseUrl);
                }
                if (imgUrl.contains('public/storage/')) {
                  imgUrl = imgUrl.replaceAll('public/storage/', 'storage/');
                }
                if (!imgUrl.startsWith('http://') && !imgUrl.startsWith('https://') && !imgUrl.startsWith('data:image')) {
                  final separator = imgUrl.startsWith('/') ? '' : '/';
                  imgUrl = '${AppConstants.baseUrl}$separator$imgUrl';
                }
              }
              final hasImg = imgUrl != null && imgUrl.isNotEmpty;
              final isBase64 = imgUrl != null && imgUrl.startsWith('data:image');

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: AppConstants.cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                ),
                child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppConstants.primaryColor,
                    ),
                    child: ClipOval(
                      child: isBase64
                          ? Image.memory(
                              base64Decode(imgUrl.toString().split(',').last),
                              fit: BoxFit.cover,
                            )
                          : (hasImg
                              ? Image.network(
                                  imgUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.person, color: Colors.white60);
                                  },
                                )
                              : const Icon(Icons.person, color: Colors.white60)),
                    ),
                  ),
                  title: Text(
                    usr['name'] ?? 'Guest',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    usr['email'] ?? '',
                    style: const TextStyle(color: Colors.white54, fontSize: 13),
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'ID #${usr['id']}',
                      style: const TextStyle(color: Colors.white70, fontSize: 11),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
