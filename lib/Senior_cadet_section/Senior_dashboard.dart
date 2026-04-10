import 'package:flutter/material.dart';
import 'package:galaxy_explorer/Senior_cadet_section/Earth_learning.dart';
import 'package:galaxy_explorer/Senior_cadet_section/Mercury_learning.dart';
import 'package:galaxy_explorer/Senior_cadet_section/Mers_learning.dart';
import 'package:galaxy_explorer/Senior_cadet_section/Venus_learning.dart';
// অন্যান্য গ্রহের পেজগুলো এখানে ইমপোর্ট করবেন (যেমন: MarsLearning, JupiterLearning ইত্যাদি)

class SeniorDashboard extends StatelessWidget {
  const SeniorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 252, 252), 
      appBar: AppBar(
        title: const Text("Senior Explorer Dashboard", 
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: const [
                Text(
                  "Welcome, Senior Cadet! 🚀",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.orangeAccent),
                ),
                SizedBox(height: 8),
                Text(
                  "নিচের কোন গ্রহটি তুমি আজ এক্সপ্লোর করতে চাও?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Color.fromARGB(179, 10, 10, 10)),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: [
                   PlanetItem(
                    title: "Mercury",
                    img: 'assets/images/mercury_dashboard_img.png',
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const MercuryLearningPage()));
                    },
                  ),
                   PlanetItem(
                    title: "Venus",
                    img: 'assets/images/venus_dashboard_img.png',
                    onTap: () {

                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const VenusLearningPage()));
                    },

                  ),
                  PlanetItem(
                    title: "Earth",
                    img: 'assets/images/earth_dashboard_pic.png',
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const EarthLearningPage()));
                    },
                  ),
              
                  PlanetItem(
                    title: "Mars",
       
                    img: 'assets/images/mars_dashboard_img.png',
                    onTap: () {
                        
                         Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const MarsLearningPage()));
                    },
                  ),
                   PlanetItem(
                    title: "Jupiter",
                    img: 'assets/images/jupiter_dashboard_img.png',
                    onTap: () {},
                  ),

                  PlanetItem(
                    title: "Saturn",
                    img: 'assets/images/saturn_dashboard_img.png',
                    onTap: () {},
                  ),

                
                  PlanetItem(
                    title: "Uranus",
                    img: 'assets/images/uranus_dashboard_img.png',
                    onTap: () {},
                  ),
                  PlanetItem(
                    title: "Neptune",
                    img: 'assets/images/neptune_dashboard_img.png',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class PlanetItem extends StatelessWidget {
   
  final String title;
  final String img;
  final VoidCallback onTap;

  const PlanetItem({
    super.key,
    required this.title,
    required this.img,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xE0599BDA),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              spreadRadius: 5,
            )
          ],
        ),

        child: Column(
          children: [
            // 🟣 FULL Dashboard Image (Expanded)
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.asset(
                  img,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // 🟣 Title Section
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}