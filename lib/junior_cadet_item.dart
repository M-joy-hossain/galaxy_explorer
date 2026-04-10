import 'package:flutter/material.dart';
import 'package:galaxy_explorer/AlphabetPage.dart';
import 'package:galaxy_explorer/math_problem_solving.dart';
import 'package:galaxy_explorer/place_the_planets.dart';
import 'SpaceMuseumDoor.dart';



class junior_cadet_item extends StatelessWidget {
  const junior_cadet_item({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Junior Cadet Dashboard"),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.count(
          crossAxisCount: 2,      // 2 items per row
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [

            DashboardItem(
              title: "Alphabet",
              img: 'assets/images/alphabet_dashboard.png',

              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const AlphabetPage())
                );
              },

            ),

            DashboardItem(
              title: "Space Museum",
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const SpaceMuseumGrid())
                );
              },
              img:'assets/images/space_museum.png',
            ),

            DashboardItem(
              title: "Place The Planets Game",
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const PlaceThePlanets())
                );
              },
              img:'assets/images/place_the_planet_dashboard_img.png',
            ),

            DashboardItem(
              title: "Math Problem Solving",
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const MathProblemSolving())
                );
              },
              img:'assets/images/math_problem_dashboard_img.png',
            ),



          ],
        ),
      ),
    );
  }
}


class DashboardItem extends StatelessWidget {
  final String title;
  final String img;
  final VoidCallback onTap;

  const DashboardItem({
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


