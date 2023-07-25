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
          child: Column(children: [
            const SizedBox(height: 30),
            Image.asset('assets/logos.png', height: 400),
            const Center(
              child: Padding(
                padding: EdgeInsets.all(50),
                child: SizedBox(
                    height: 200,
                    width: 700,
                    child: Text(
                        'The project is a data visualizer about COVID 19, it aims to analyze the data obtained about the virus through an API, process and show it in a Liquid Galaxy cluster. Thus, it will be possible for the user to filter the data about the virus and view its trajectory around the world based on its evolution through filters chosen by him, such as country, date and variant.', style: TextStyle(fontSize: 20))),
              ),
            )
          ])),
    );
  }
}
