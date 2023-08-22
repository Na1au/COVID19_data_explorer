import 'package:covid19_data_explorer/widgets/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

  void _sendEmail(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );

    await launchUrl(emailLaunchUri, mode: LaunchMode.externalApplication);
  }

  void _openGitHub(String account) async {
    final Uri ghLaunchUri = Uri.https('github.com', '/$account');

    await launchUrl(ghLaunchUri, mode: LaunchMode.externalApplication);
  }

  void _openLinkedIn(String account) async {
    final Uri liLaunchUri = Uri.https('linkedin.com', '/$account');

    await launchUrl(liLaunchUri, mode: LaunchMode.externalApplication);
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
                SizedBox(
                    width: 500,
                    height: 100,
                    child: Column(
                      children: [
                        const Text('Made by: Ana Laura de Oliveira Silva ',
                            style: TextStyle(fontSize: 20)),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                iconSize: 30,
                                icon: const Icon(
                                  Icons.mail_rounded,
                                  color: Colors.black45,
                                ),
                                splashRadius: 24,
                                tooltip: 'analaura-osilva@hotmail.com',
                                onPressed: () {
                                  _sendEmail('analaura-osilva@hotmail.com');
                                },
                              ),
                              IconButton(
                                iconSize: 30,
                                splashRadius: 24,
                                icon: const Icon(
                                  AppIcons.github,
                                  color: Colors.black45,
                                ),
                                tooltip: 'Na1au',
                                onPressed: () {
                                  _openGitHub('Na1au');
                                },
                              ),
                              IconButton(
                                iconSize: 30,
                                icon: Icon(
                                  AppIcons.linkedin,
                                  color: Colors.blue.shade600,
                                ),
                                splashRadius: 24,
                                tooltip: 'ana-laura-silva',
                                onPressed: () {
                                  _openLinkedIn('in/ana-laura-silva');
                                },
                              )
                            ]),
                      ],
                    )),
                const SizedBox(
                    width: 900,
                    child: Text(
                        'Organization: Liquid Galaxy project \nMain mentor: Karine Pistili \nHelp mentors: Marc Gonzalez and Emilie Ma \nOrganization admin: Andreu Ibañez',
                        style: TextStyle(fontSize: 20))),
                const SizedBox(height: 30),
                const SizedBox(
                    width: 900,
                    child: Text(
                        'Thanks to Emilie, Andreu, and the Liquid Galaxy LAB testers Mohamed, Navdeep and Imad for all the help reviewing and always bringing new ideas to improve the application.',
                        style: TextStyle(fontSize: 20))),
                const SizedBox(height: 30),
                Image.asset('assets/partners_logo.png', height: 300),
              ])))),
    );
  }
}
