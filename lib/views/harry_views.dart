import 'package:flutter/material.dart';
import 'package:latihan_flutter/constant/app_colors.dart';
import 'package:latihan_flutter/models/harry_models.dart';
import 'package:latihan_flutter/services/dio_client.dart';
import 'package:latihan_flutter/services/harry_api_services.dart';
import 'package:latihan_flutter/views/harry_detail_views.dart';

class HarryViews extends StatefulWidget {
  const HarryViews({super.key});

  @override
  State<HarryViews> createState() => _HarryViewsState();
}

class _HarryViewsState extends State<HarryViews> {
  final TextEditingController searchController = TextEditingController();
  House? selectedHouse;
  late Future<List<Welcome>> futureCharacters;

  @override
  void initState() {
    super.initState();
    futureCharacters = ApiService(createDioClient()).getAllPosts();
  }

  // Warna latar khas tiap house Hogwarts
  Color houseColor(House house) {
    switch (house) {
      case House.GRYFFINDOR:
        return const Color(0xFF740001); // merah marun
      case House.SLYTHERIN:
        return const Color(0xFF1A472A); // hijau tua
      case House.RAVENCLAW:
        return const Color(0xFF222F5B); // biru tua
      case House.HUFFLEPUFF:
        return const Color(0xFFECB939); // kuning
      case House.EMPTY:
        return Colors.grey.shade700;
    }
  }

  // Warna khas tiap species
  Color speciesColor(String species) {
    switch (species.toLowerCase()) {
      case "human":
        return const Color(0xFF6EC1E4); // biru langit
      case "half-giant":
        return const Color(0xFFB5651D); // cokelat
      case "ghost":
        return const Color(0xFFB0BEC5); // abu kebiruan
      case "werewolf":
        return const Color(0xFF8E44AD); // ungu
      case "house-elf":
        return const Color(0xFF27AE60); // hijau
      case "cat":
        return const Color(0xFFE67E22); // oranye
      case "giant":
        return const Color(0xFF795548); // cokelat tua
      case "dragon":
        return const Color(0xFFC0392B); // merah
      case "goblin":
        return const Color(0xFFD4AC0D); // emas tua
      case "centaur":
        return const Color(0xFF16A085); // teal
      default:
        return const Color(0xFFD6B4FF); // ungu muda (default)
    }
  }

  // Warna teks yang kontras dengan warna house
  Color houseTextColor(House house) {
    switch (house) {
      case House.GRYFFINDOR:
        return const Color(0xFFD3A625); // emas
      case House.SLYTHERIN:
        return const Color(0xFFAAAAAA); // perak
      case House.RAVENCLAW:
        return const Color(0xFFCD7F32); // perunggu
      case House.HUFFLEPUFF:
        return Colors.black; // hitam
      case House.EMPTY:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral,
      body: FutureBuilder<List<Welcome>>(
        future: futureCharacters,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          // Tidak ada data
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Data kosong"));
          }

          final characters = snapshot.data!;

          final filteredCharacters = characters.where((character) {
            final matchesSearch = character.name.toLowerCase().contains(
              searchController.text.toLowerCase(),
            );
            final matchesHouse =
                selectedHouse == null || character.house == selectedHouse;
            return matchesSearch && matchesHouse;
          }).toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: searchController,

                  onChanged: (value) {
                    setState(() {});
                  },

                  decoration: InputDecoration(
                    hintText: "Search Character...",
                    prefixIcon: const Icon(Icons.search),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 48,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: House.values
                      .where((house) => house != House.EMPTY)
                      .map((house) {
                        final isSelected = selectedHouse == house;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            label: Text(houseValues.reverse[house] ?? ""),
                            selected: isSelected,
                            onSelected: (value) {
                              setState(() {
                                selectedHouse = value ? house : null;
                              });
                            },
                            selectedColor: houseColor(house),
                            checkmarkColor: houseTextColor(house),
                            labelStyle: TextStyle(
                              color: isSelected
                                  ? houseTextColor(house)
                                  : Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      })
                      .toList(),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredCharacters.length,
                  itemBuilder: (context, index) {
                    final item = filteredCharacters[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HarryDetailViews(character: item),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(16, 20, 16, 1),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 130,
                                height: 180,
                                child: ClipRRect(
                                  borderRadius: BorderRadiusGeometry.only(
                                    topLeft: Radius.circular(16),
                                    bottomLeft: Radius.circular(16),
                                  ),
                                  child: Image.network(
                                    item.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.species.toUpperCase(),
                                            style: TextStyle(
                                              color: speciesColor(item.species),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 2,
                                            ),
                                          ),

                                          Text(
                                            item.name,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Color(0xFFE2B84B),
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),

                                          const SizedBox(height: 8),

                                          Text(
                                            item.actor,
                                            style: TextStyle(
                                              color: Colors.grey.shade400,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedHouse =
                                                    selectedHouse == item.house
                                                    ? null
                                                    : item.house;
                                              });
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 18,
                                                    vertical: 10,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: houseColor(item.house),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Text(
                                                item.house.name.toUpperCase(),
                                                style: TextStyle(
                                                  color: houseTextColor(
                                                    item.house,
                                                  ),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
