import 'package:flutter/material.dart';
import 'package:latihan_flutter/constant/app_colors.dart';
import 'package:latihan_flutter/models/harry_models.dart';

class HarryDetailViews extends StatelessWidget {
  final Welcome character;

  const HarryDetailViews({super.key, required this.character});

  // Warna latar khas tiap house Hogwarts
  Color _houseColor(House house) {
    switch (house) {
      case House.GRYFFINDOR:
        return const Color(0xFF740001);
      case House.SLYTHERIN:
        return const Color(0xFF1A472A);
      case House.RAVENCLAW:
        return const Color(0xFF222F5B);
      case House.HUFFLEPUFF:
        return const Color(0xFFECB939);
      case House.EMPTY:
        return Colors.grey.shade700;
    }
  }

  // Rapikan teks: kosong jadi "-", huruf depan kapital
  String _pretty(String value) {
    if (value.trim().isEmpty) return "-";
    return value[0].toUpperCase() + value.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final house = character.house;
    final accent = _houseColor(house);
    final houseName = houseValues.reverse[house] ?? "";

    return Scaffold(
      backgroundColor: AppColors.neutral,
      body: CustomScrollView(
        slivers: [
          // Header gambar besar dengan gradasi warna house
          SliverAppBar(
            expandedHeight: 360,
            pinned: true,
            backgroundColor: accent,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    character.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) => Container(
                      color: accent.withValues(alpha: 0.4),
                      child: const Icon(
                        Icons.person,
                        size: 120,
                        color: Colors.white54,
                      ),
                    ),
                  ),
                  // Gradasi gelap dari bawah agar teks terbaca
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          AppColors.neutral.withValues(alpha: 0.5),
                          AppColors.neutral,
                        ],
                        stops: const [0.4, 0.8, 1.0],
                      ),
                    ),
                  ),
                  // Nama + house menempel di bawah
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (houseName.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: accent,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white24),
                            ),
                            child: Text(
                              houseName.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        const SizedBox(height: 10),
                        Text(
                          character.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          character.actor.isEmpty
                              ? "Tanpa aktor"
                              : "diperankan oleh ${character.actor}",
                          style: TextStyle(
                            color: Colors.grey.shade300,
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Isi detail
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status hidup / mati
                  _StatusBadge(alive: character.alive),
                  const SizedBox(height: 20),

                  _Section(
                    title: "Identitas",
                    accent: accent,
                    children: [
                      _InfoTile(
                        icon: Icons.pets,
                        label: "Spesies",
                        value: _pretty(character.species),
                      ),
                      _InfoTile(
                        icon: Icons.wc,
                        label: "Gender",
                        value: _pretty(
                          genderValues.reverse[character.gender] ?? "",
                        ),
                      ),
                      _InfoTile(
                        icon: Icons.bloodtype,
                        label: "Keturunan",
                        value: _pretty(
                          ancestryValues.reverse[character.ancestry] ?? "",
                        ),
                      ),
                      _InfoTile(
                        icon: Icons.cake,
                        label: "Tanggal Lahir",
                        value: character.dateOfBirth ?? "-",
                      ),
                      _InfoTile(
                        icon: Icons.calendar_today,
                        label: "Tahun Lahir",
                        value: character.yearOfBirth?.toString() ?? "-",
                      ),
                    ],
                  ),

                  _Section(
                    title: "Penampilan",
                    accent: accent,
                    children: [
                      _InfoTile(
                        icon: Icons.remove_red_eye,
                        label: "Warna Mata",
                        value: _pretty(
                          eyeColourValues.reverse[character.eyeColour] ?? "",
                        ),
                      ),
                      _InfoTile(
                        icon: Icons.content_cut,
                        label: "Warna Rambut",
                        value: _pretty(
                          hairColourValues.reverse[character.hairColour] ?? "",
                        ),
                      ),
                    ],
                  ),

                  _Section(
                    title: "Sihir",
                    accent: accent,
                    children: [
                      _InfoTile(
                        icon: Icons.auto_fix_high,
                        label: "Penyihir",
                        value: character.wizard ? "Ya" : "Bukan",
                      ),
                      _InfoTile(
                        icon: Icons.pets_outlined,
                        label: "Patronus",
                        value: _pretty(
                          patronusValues.reverse[character.patronus] ?? "",
                        ),
                      ),
                      _InfoTile(
                        icon: Icons.school,
                        label: "Murid Hogwarts",
                        value: character.hogwartsStudent ? "Ya" : "Tidak",
                      ),
                      _InfoTile(
                        icon: Icons.work,
                        label: "Staf Hogwarts",
                        value: character.hogwartsStaff ? "Ya" : "Tidak",
                      ),
                    ],
                  ),

                  _Section(
                    title: "Tongkat Sihir",
                    accent: accent,
                    children: [
                      _InfoTile(
                        icon: Icons.park,
                        label: "Kayu",
                        value: _pretty(character.wand.wood),
                      ),
                      _InfoTile(
                        icon: Icons.bolt,
                        label: "Inti",
                        value: _pretty(
                          coreValues.reverse[character.wand.core] ?? "",
                        ),
                      ),
                      _InfoTile(
                        icon: Icons.straighten,
                        label: "Panjang",
                        value: character.wand.length != null
                            ? "${character.wand.length} inci"
                            : "-",
                      ),
                    ],
                  ),

                  // Nama lain (jika ada)
                  if (character.alternateNames.isNotEmpty) ...[
                    _SectionTitle(title: "Nama Lain", accent: accent),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: character.alternateNames.map((name) {
                        return Chip(
                          label: Text(name),
                          backgroundColor: AppColors.tertiary,
                          labelStyle: const TextStyle(color: Colors.white),
                          side: BorderSide(
                            color: accent.withValues(alpha: 0.6),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Badge status hidup / mati
class _StatusBadge extends StatelessWidget {
  final bool alive;

  const _StatusBadge({required this.alive});

  @override
  Widget build(BuildContext context) {
    final color = alive ? const Color(0xFF2ECC71) : const Color(0xFFE74C3C);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            alive ? Icons.favorite : Icons.heart_broken,
            color: color,
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(
            alive ? "Masih Hidup" : "Telah Tiada",
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

// Judul section dengan garis aksen warna house
class _SectionTitle extends StatelessWidget {
  final String title;
  final Color accent;

  const _SectionTitle({required this.title, required this.accent});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

// Section = judul + kartu berisi daftar info
class _Section extends StatelessWidget {
  final String title;
  final Color accent;
  final List<Widget> children;

  const _Section({
    required this.title,
    required this.accent,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(title: title, accent: accent),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppColors.tertiary,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Column(children: children),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

// Baris satu informasi: ikon, label, nilai
class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary, size: 22),
          const SizedBox(width: 14),
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: TextStyle(color: Colors.grey.shade400, fontSize: 15),
            ),
          ),
          Expanded(
            flex: 2,
            child: Flexible(
              child: Text(
                value,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
