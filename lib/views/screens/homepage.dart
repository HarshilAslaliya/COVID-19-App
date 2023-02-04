import 'package:covid_19_app/helpers/COVIDHelper.dart';
import 'package:covid_19_app/model/COVID.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dynamic selectedCountry;
  List country = [];
  List flag = [];
  dynamic i;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("COVID - 19 Tracker"),
      ),
      body: FutureBuilder(
        future: CovidApiHelper.covidApiHelper.fetchCovidData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            List<COVIDData> data = snapshot.data as List<COVIDData>;
            country = data.map((e) => e.countryname).toList();
            return Container(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        border: Border.all(
                          color: Colors.teal,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButton(
                        iconSize: 25,
                        icon: const Icon(Icons.location_on_outlined),
                        hint: const Text("Select Country"),
                        value: selectedCountry,
                        onChanged: (val) {
                          setState(() {
                            selectedCountry = val;
                            i = country.indexOf(val);
                          });
                        },
                        items: country.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text("$e"),
                          );
                        }).toList(),
                      ),
                    ),
                    if (i != null)
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.height*0.025,
                            ),
                            Container(
                              height: size.height * 0.2,
                              width: size.width * 0.65,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                      image: NetworkImage(data[i].flagImage),
                                      fit: BoxFit.fill),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2,
                                  )),
                            ),
                            SizedBox(
                              height: size.height*0.02,
                            ),
                            Text(
                              data[i].countryname,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                            Text("Population : ${data[i].population}",style: const TextStyle(
                              fontSize: 16,
                            ),),
                            card(
                                title: "Confirmed",
                                totalCount: data[i].totalCases,
                                todayCount: data[i].todayCases,
                                color: Colors.black),
                            card(
                                title: "COVID Test",
                                totalCount: data[i].test,
                                todayCount: data[i].test,
                                color: Colors.black),
                            card(
                                title: "Recovered",
                                totalCount: data[i].totalRecovered,
                                todayCount: data[i].todayRecovered,
                                color: Colors.black),
                            card(
                                title: "Deaths",
                                totalCount: data[i].totalDeaths,
                                todayCount: data[i].todayDeaths,
                                color: Colors.black),
                            card(
                                title: "Active",
                                totalCount: data[i].activeCases,
                                todayCount: "0",
                                color: Colors.black),
                            card(
                                title: "Critical",
                                totalCount: data[i].critical,
                                todayCount: "0",
                                color: Colors.black),
                          ],
                        ),
                      )
                    else
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.coronavirus_outlined,
                                size: 60,
                                color: Colors.red.withOpacity(0.3),
                              ),
                              const Spacer(),
                              Icon(
                                Icons.coronavirus_outlined,
                                size: 60,
                                color: Colors.red.withOpacity(0.3),
                              ),
                            ],
                          ),
                          coronaIcon(),
                          coronaIcon(),
                          coronaIcon(),
                          coronaIcon(),
                          coronaIcon(),
                        ],
                      ),
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: Image(
              image: AssetImage("assets/images/corona.gif"),
              height: 100,
              width: 100,
            ),
          );
        },
      ),
    );
  }

  coronaIcon() {
    return Column(
      children: [
        Icon(
          Icons.coronavirus_outlined,
          size: 60,
          color: Colors.red.withOpacity(0.3),
        ),
        Row(
          children: [
            Icon(
              Icons.coronavirus_outlined,
              size: 60,
              color: Colors.red.withOpacity(0.3),
            ),
            const Spacer(),
            Icon(
              Icons.coronavirus_outlined,
              size: 60,
              color: Colors.red.withOpacity(0.3),
            ),
          ],
        ),
      ],
    );
  }

  card(
      {required title,
      required totalCount,
      required todayCount,
      required color}) {
    return Card(
      elevation: 5,
      child: Container(
        height: MediaQuery.of(context).size.height*0.12,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "$totalCount",
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Today",
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "$todayCount",
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.005,)
          ],
        ),
      ),
    );
  }
}
//     return Scaffold(
//       backgroundColor: Colors.blue.withOpacity(0.8),
//       appBar: AppBar(
//         title: const Text("Covid-19 Case Tracker"),
//         elevation: 1,
//         centerTitle: true,
//       ),
//       body: FutureBuilder(
//         future: CovidApiHelper.covidApiHelper.fetchCovidData(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Center(
//               child: Text('Error : ${snapshot.error}'),
//             );
//           } else if (snapshot.hasData) {
//             List<COVIDData> data = snapshot.data as List<COVIDData>;
//             country = data.map((e) => e.countryname).toList();
//             return Container(
//               alignment: Alignment.topCenter,
//               padding: const EdgeInsets.all(8),
//               child: SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.85,
//                       child: DropdownButtonFormField(
//                         iconSize: 35,
//                         icon: const Icon(Icons.location_on_outlined),
//                         decoration: InputDecoration(
//                           border: const OutlineInputBorder(
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(30.0),
//                             ),
//                           ),
//                           filled: true,
//                           fillColor: Colors.blue.withOpacity(0.1),
//                         ),
//                         hint: const Text("Select Country"),
//                         value: selectedCountry,
//                         onChanged: (val) {
//                           setState(() {
//                             selectedCountry = val;
//                             i = country.indexOf(val);
//                           });
//                         },
//                         items: country.map((e) {
//                           return DropdownMenuItem(
//                             value: e,
//                             child: SizedBox(
//                               width: MediaQuery.of(context).size.width *
//                                   0.50,
//                               child: Text(e),
//                             ),
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                     (i != null)
//                         ? Column(
//                             crossAxisAlignment:
//                                 CrossAxisAlignment.start,
//                             children: [
//                               const SizedBox(height: 20),
//                               Card(
//                                 elevation: 10,
//                                 child: Container(
//                                   padding: EdgeInsets.all(10),
//                                   child: Column(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.end,
//                                     children: [
//                                       Container(
//                                         decoration: BoxDecoration(
//                                             border: Border.all(
//                                                 color: Colors.black)),
//                                         height: 130,
//                                         width: double.infinity,
//                                         child: Image.network(
//                                           data[i].flagImage,
//                                           fit: BoxFit.fill,
//                                         ),
//                                       ),
//                                       Text(
//                                         "${data[i].countryname}",
//                                         style: mystyle,
//                                       ),
//                                       Text(
//                                         "Population: ${data[i].population}",
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               builcard(
//                                   title: "Confirmed",
//                                   totalCount: data[i].totalCases,
//                                   todayCount: data[i].todayCases,
//                                   color: Colors.red),
//                               builcard(
//                                   title: "Recovered",
//                                   totalCount: data[i].totalRecovered,
//                                   todayCount: data[i].todayRecovered,
//                                   color: Colors.green),
//                               builcard(
//                                   title: "Deaths",
//                                   totalCount: data[i].totalDeaths,
//                                   todayCount: data[i].todayDeaths,
//                                   color: Colors.blueGrey),
//                               builcard(
//                                   title: "Active",
//                                   totalCount: data[i].activeCases,
//                                   todayCount: "",
//                                   color: Colors.blue),
//                               builcard(
//                                   title: "Critical",
//                                   totalCount: data[i].critical,
//                                   todayCount: "",
//                                   color: Colors.amber),
//                             ],
//                           )
//                         : Column(
//                             mainAxisSize: MainAxisSize.max,
//                             children: [
//                               SizedBox(
//                                 height: 40,
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.end,
//                                 children: [
//                                   getcoro2(
//                                       color: Colors.green
//                                           .withOpacity(0.1)),
//                                   Spacer(),
//                                   getcoro2(
//                                       color:
//                                           Colors.pink.withOpacity(0.1)),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 50,
//                               ),
//                               getcoro(
//                                   color: Colors.red.withOpacity(0.1)),
//                               SizedBox(
//                                 height: 50,
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.start,
//                                 children: [
//                                   getcoro2(
//                                       color:
//                                           Colors.blue.withOpacity(0.1)),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 50,
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.end,
//                                 children: [
//                                   getcoro2(
//                                       color:
//                                           Colors.blue.withOpacity(0.1)),
//                                   SizedBox(
//                                     width: 50,
//                                   )
//                                 ],
//                               ),
//                             ],
//                           ),
//                   ],
//                 ),
//               ),
//             );
//           } else {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     );
//   }
//
//   getcoro({required color}) {
//     return Icon(
//       Icons.coronavirus_outlined,
//       size: 60,
//       color: color,
//     );
//   }
//
//   getcoro2({required color}) {
//     return Icon(
//       Icons.coronavirus_rounded,
//       size: 60,
//       color: color,
//     );
//   }
//
//   builcard(
//       {required title,
//       required totalCount,
//       required todayCount,
//       required color}) {
//     return Card(
//       elevation: 5,
//       child: Container(
//         height: 80,
//         decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
//         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         child: Column(
//           children: [
//             Text(
//               title,
//               style: TextStyle(
//                 color: Colors.grey,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 14,
//               ),
//             ),
//             Expanded(child: Container()),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Total",
//                       style: TextStyle(
//                         color: color,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 12,
//                       ),
//                     ),
//                     Text(
//                       "$totalCount",
//                       style: TextStyle(
//                         color: color,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 28,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Text(
//                       "Today",
//                       style: TextStyle(
//                         color: color,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 12,
//                       ),
//                     ),
//                     Text(
//                       "$todayCount",
//                       style: TextStyle(
//                         color: color,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 28,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
