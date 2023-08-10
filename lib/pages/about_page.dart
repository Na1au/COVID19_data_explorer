import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
              padding: const EdgeInsets.all(15),
              child: Center(
                  child: Column(children: [
                Image.asset('assets/Logo_Covid.png', height: 300),
                const SizedBox(height: 30),
                const SizedBox(
                    width: 900,
                    child: Text(
                        'The project is a data visualizer about COVID 19, it aims to analyze the data obtained about the virus through the Disease.sh and Athena API, process and show it in a Liquid Galaxy cluster. Thus, it will be possible for the user to filter the data about the virus and view its trajectory around the world.',
                        style: TextStyle(fontSize: 20))),
                const SizedBox(height: 30),
                const SizedBox(
                    width: 900,
                    child: Text(
                        'Made by: Ana Laura de Oliveira Silva \nOrganization: Liquid Galaxy project \nMain mentor: Karine Pistili \nHelp mentors: Marc Gonzalez and Emilie Ma \nOrganization admin: Andreu Ibañez',
                        style: TextStyle(fontSize: 20))),
                const SizedBox(height: 30),
                const SizedBox(
                    width: 900,
                    child: Text(
                        'Thanks to Emilie, Andreu, and the Liquid Galaxy LAB testers Mohamed, Navdeep and Imad for all the help reviewing and always bringing new ideas to improve the application.',
                        style: TextStyle(fontSize: 20))),
                const SizedBox(height: 30),
                Image.asset('assets/partners_logo.png', height: 300),
                /* Center(
                  child: Padding(
                    padding: EdgeInsets.all(50),
                    child: SizedBox(
                        height: 630,
                        width: 900,
                        child: Column(
                          children: [
                            const Text(
                                'The project is a data visualizer about COVID 19, it aims to analyze the data obtained about the virus through the Disease.sh and Athena API, process and show it in a Liquid Galaxy cluster. Thus, it will be possible for the user to filter the data about the virus and view its trajectory around the world.',
                                style: TextStyle(fontSize: 20)),
                            const SizedBox(height: 30),
                            const Text(
                                'Made by: Ana Laura de Oliveira Silva \nOrganization: Liquid Galaxy project \nMentor: Karine Pistili \nCo-mentors: Marc Gonzalez Capdevila and Emilie Ma \nOrganization admin: Andreu Ibañez \nThanks to Emilie, Andreu, and the Liquid Galaxy LAB testers Mohamed, Navdeep and Imad for all the help reviewing and always bringing new ideas to improve the application.',
                                style: TextStyle(fontSize: 20)),
                            const SizedBox(height: 30),
                            Image.asset('assets/partners_logo.png',
                                height: 300),
                          ],
                        )),
                  ),
                ) */
              ])))),
    );
  }
}
