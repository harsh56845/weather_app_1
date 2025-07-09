import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/weather_controller.dart';
import '../widgets/weather_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<WeatherController>(context);
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 600;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2196F3), Color(0xFF0D47A1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: isWide ? size.width * 0.2 : 24,
          vertical: 40,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Weather App',
                      style: GoogleFonts.poppins(
                        fontSize: isWide ? 42 : 32,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final isWide = constraints.maxWidth > 600;

                        if (isWide) {
                          // Horizontal layout for web/tablet
                          return Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: cityController,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    hintText: 'Enter City Name',
                                    hintStyle: const TextStyle(
                                      color: Colors.white70,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.1),
                                    prefixIcon: const Icon(
                                      Icons.location_city,
                                      color: Colors.white,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              IconButton(
                                icon: const Icon(
                                  Icons.my_location,
                                  color: Colors.white,
                                ),
                                iconSize: 32,
                                onPressed: () {
                                  controller.loadWeatherFromLocation();
                                },
                              ),
                            ],
                          );
                        } else {
                          // Vertical layout for mobile
                          return Column(
                            children: [
                              TextField(
                                controller: cityController,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'Enter City Name',
                                  hintStyle: const TextStyle(
                                    color: Colors.white70,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.1),
                                  prefixIcon: const Icon(
                                    Icons.location_city,
                                    color: Colors.white,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.my_location,
                                    color: Colors.white,
                                  ),
                                  iconSize: 30,
                                  onPressed: () {
                                    controller.loadWeatherFromLocation();
                                  },
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),

                    // Row(
                    //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     SizedBox(
                    //       width: 620,
                    //       child: TextField(
                    //         controller: cityController,
                    //         style: const TextStyle(color: Colors.white),
                    //         decoration: InputDecoration(
                    //           hintText: 'Enter City Name',
                    //           hintStyle: const TextStyle(color: Colors.white70),
                    //           filled: true,
                    //           fillColor: Colors.white.withOpacity(0.1),
                    //           prefixIcon: const Icon(
                    //             Icons.location_city,
                    //             color: Colors.white,
                    //           ),
                    //           border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(16),
                    //             borderSide: BorderSide.none,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(width: 15),
                    //     IconButton(
                    //       icon: Icon(Icons.my_location, color: Colors.white),
                    //       onPressed: () {
                    //         controller.loadWeatherFromLocation();
                    //       },
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        controller.loadWeather(cityController.text);
                      },
                      icon: const Icon(Icons.search),
                      label: const Text('Get Weather'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    controller.isLoading
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          )
                        : controller.weather == null
                        ? Text(
                            'Enter a city to view weather',
                            style: GoogleFonts.poppins(color: Colors.white70),
                            textAlign: TextAlign.center,
                          )
                        : WeatherCard(weather: controller.weather!),
                  ],
                ),
              ),
            ),

            // Footer
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Made with ❤️ by Harsh',
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
