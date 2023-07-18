import 'package:flutter/material.dart';

const List<String> _currencies = [
  "North America",
  "South America",
  "Africa",
  "Asia",
  "Europe",
  "Australia-Oceania",
];

const List<String> _countries = [
  "Anguilla",
  "Antigua and Barbuda",
  "Aruba",
  "Bahamas",
  "Barbados",
  "Belize",
  "Bermuda",
  "British Virgin Islands",
  "Canada",
  "Caribbean Netherlands",
  "Cayman Islands",
  "Costa Rica",
  "Cuba",
  "Curaçao",
  "Dominica",
  "Dominican Republic",
  "El Salvador",
  "Greenland",
  "Grenada",
  "Guadeloupe",
  "Guatemala",
  "Haiti",
  "Honduras",
  "Jamaica",
  "Martinique",
  "Mexico",
  "Montserrat",
  "Nicaragua",
  "Panama",
  "Saint Kitts and Nevis",
  "Saint Lucia",
  "Saint Martin",
  "Saint Pierre Miquelon",
  "Saint Vincent and the Grenadines",
  "Sint Maarten",
  "St. Barth",
  "Trinidad and Tobago",
  "Turks and Caicos Islands",
  "USA",
  "Afghanistan",
  "Armenia",
  "Azerbaijan",
  "Bahrain",
  "Bangladesh",
  "Bhutan",
  "Brunei",
  "Cambodia",
  "China",
  "Cyprus",
  "Georgia",
  "Hong Kong",
  "India",
  "Indonesia",
  "Iran",
  "Iraq",
  "Israel",
  "Japan",
  "Jordan",
  "Kazakhstan",
  "Kuwait",
  "Kyrgyzstan",
  "Lao People's Democratic Republic",
  "Lebanon",
  "Macao",
  "Malaysia",
  "Maldives",
  "Mongolia",
  "Myanmar",
  "N. Korea",
  "Nepal",
  "Oman",
  "Pakistan",
  "Palestine",
  "Philippines",
  "Qatar",
  "S. Korea",
  "Saudi Arabia",
  "Singapore",
  "Sri Lanka",
  "Syrian Arab Republic",
  "Taiwan",
  "Tajikistan",
  "Thailand",
  "Timor-Leste",
  "Turkey",
  "UAE",
  "Uzbekistan",
  "Vietnam",
  "Yemen",
  "Albania",
  "Andorra",
  "Austria",
  "Belarus",
  "Belgium",
  "Bosnia",
  "Bulgaria",
  "Channel Islands",
  "Croatia",
  "Czechia",
  "Denmark",
  "Estonia",
  "Faroe Islands",
  "Finland",
  "France",
  "Germany",
  "Gibraltar",
  "Greece",
  "Holy See (Vatican City State)",
  "Hungary",
  "Iceland",
  "Ireland",
  "Isle of Man",
  "Italy",
  "Latvia",
  "Liechtenstein",
  "Lithuania",
  "Luxembourg",
  "Macedonia",
  "Malta",
  "Moldova",
  "Monaco",
  "Montenegro",
  "Netherlands",
  "Norway",
  "Poland",
  "Portugal",
  "Romania",
  "Russia",
  "San Marino",
  "Serbia",
  "Slovakia",
  "Slovenia",
  "Spain",
  "Sweden",
  "Switzerland",
  "UK",
  "Ukraine",
  "Argentina",
  "Bolivia",
  "Brazil",
  "Chile",
  "Colombia",
  "Ecuador",
  "Falkland Islands (Malvinas)",
  "French Guiana",
  "Guyana",
  "Paraguay",
  "Peru",
  "Suriname",
  "Uruguay",
  "Venezuela",
  "Australia",
  "Cook Islands",
  "Fiji",
  "French Polynesia",
  "Kiribati",
  "Marshall Islands",
  "Micronesia",
  "Nauru",
  "New Caledonia",
  "New Zealand",
  "Niue",
  "Palau",
  "Papua New Guinea",
  "Samoa",
  "Solomon Islands",
  "Tokelau",
  "Tonga",
  "Tuvalu",
  "Vanuatu",
  "Wallis and Futuna",
  "Algeria",
  "Angola",
  "Benin",
  "Botswana",
  "Burkina Faso",
  "Burundi",
  "Cabo Verde",
  "Cameroon",
  "Central African Republic",
  "Chad",
  "Comoros",
  "Congo",
  "Côte d'Ivoire",
  "DRC",
  "Djibouti",
  "Egypt",
  "Equatorial Guinea",
  "Eritrea",
  "Ethiopia",
  "Gabon",
  "Gambia",
  "Ghana",
  "Guinea",
  "Guinea-Bissau",
  "Kenya",
  "Lesotho",
  "Liberia",
  "Libyan Arab Jamahiriya",
  "Madagascar",
  "Malawi",
  "Mali",
  "Mauritania",
  "Mauritius",
  "Mayotte",
  "Morocco",
  "Mozambique",
  "Namibia",
  "Niger",
  "Nigeria",
  "Rwanda",
  "Réunion",
  "Saint Helena",
  "Sao Tome and Principe",
  "Senegal",
  "Seychelles",
  "Sierra Leone",
  "Somalia",
  "South Africa",
  "South Sudan",
  "Sudan",
  "Swaziland",
  "Tanzania",
  "Togo",
  "Tunisia",
  "Uganda",
  "Western Sahara",
  "Zambia",
  "Zimbabwe"
];
const List<String> _sortBy = [
  "updated",
  "cases",
  "todayCases",
  "deaths",
  "todayDeaths",
  "recovered",
  "todayRecovered",
  "active",
  "critical",
  "casesPerOneMillion",
  "deathsPerOneMillion",
  "tests",
  "testsPerOneMillion",
  "population",
  "continent",
  "activePerOneMillion",
  "recoveredPerOneMillion",
  "criticalPerOneMillion"
];

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  String? _currentSelectedValue = _currencies.first;
  //final _countryController = TextEditingController();
  String? _currentCountry = _countries.first;
  String? _currentSort = _sortBy.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Search')),
        body: Center(
            child: Container(
          color: Colors.grey.shade200,
          width: double.infinity,
          height: double.infinity,
          child: ListView(scrollDirection: Axis.vertical, children: [
            Padding(
              padding: const EdgeInsets.all(150),
              child: Column(
                children: [
                  Row(
                    children: [
                      FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return DropdownButton<String>(
                            value: _currentSelectedValue,
                            elevation: 30,
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                _currentSelectedValue = value;
                              });
                            },
                            items: _currencies
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          );
                        },
                      ),
                      Spacer(),
                      FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return DropdownButton<String>(
                            value: _currentCountry,
                            elevation: 16,
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                _currentCountry = value;
                              });
                            },
                            items: _countries
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          );
                        },
                      ),
                      Spacer(),
                      FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return DropdownButton<String>(
                            value: _currentSort,
                            elevation: 30,
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                _currentSort = value;
                              });
                            },
                            items: _sortBy
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          );
                        },
                      ),
                      /* TextFormField(
                        controller: _countryController,
                        decoration: const InputDecoration(
                          label: Text('Country name'),
                          hintText: 'Spain',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(),
                        ),
                      ), */
                    ],
                  ),
                  SizedBox(height: 150),
                  SizedBox(
                        height: 50,
                        width: 200,
                        child: ElevatedButton(
                            onPressed: () {},
                            child: const Text(
                              'Generate KML',
                              style: TextStyle(fontSize: 20),
                            ))),
                ],
              ),
            )
          ]),
        )));
  }
}
