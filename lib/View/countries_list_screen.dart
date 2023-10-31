import 'package:covid/Utilites/states_services.dart';
import 'package:covid/View/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search Country name..',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
            Expanded(
                child: FutureBuilder(
                    future: statesServices.CountriesListApi(),
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                      if (!snapshot.hasData) {
                        return ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey.shade700,
                                highlightColor: Colors.grey.shade100,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Container(
                                        width: 10,
                                        height: 10,
                                        color: Colors.white,
                                      ),
                                      subtitle: Container(
                                        width: 10,
                                        height: 10,
                                        color: Colors.white,
                                      ),
                                      leading: Container(
                                        width: 50,
                                        height: 50,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              String name = snapshot.data![index]['country'];
                              if (searchController.text.isEmpty) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailScreen(
                                              image: snapshot.data![index]
                                                  ['countryInfo']['flag'],
                                              name: snapshot.data![index]
                                                  ['country'],
                                              totalCases: snapshot.data![index]
                                                  ['cases'],
                                              todayRecovered: snapshot
                                                  .data![index]['recovered'],
                                              TotalDeaths: snapshot.data![index]
                                                  ['deaths'],
                                              active: snapshot.data![index]
                                                  ['active'],
                                              test: snapshot.data![index]
                                                  ['tests'],
                                              critical: snapshot.data![index]
                                                  ['critical'],
                                            ),
                                          ),
                                        );
                                      },
                                      child: ListTile(
                                        title: Text(
                                            snapshot.data![index]['country']),
                                        subtitle: Text(snapshot.data![index]
                                                ['cases']
                                            .toString()),
                                        leading: Image.network(
                                          snapshot.data![index]['countryInfo']
                                              ['flag'],
                                          width: 50,
                                          height: 50,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else if (name.toLowerCase().contains(
                                  searchController.text.toLowerCase())) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                          image: snapshot.data![index]
                                              ['countryInfo']['flag'],
                                          name: snapshot.data![index]
                                              ['country'],
                                          totalCases: snapshot.data![index]
                                              ['cases'],
                                          todayRecovered: snapshot.data![index]
                                              ['recovered'],
                                          TotalDeaths: snapshot.data![index]
                                              ['deaths'],
                                          active: snapshot.data![index]
                                              ['active'],
                                          test: snapshot.data![index]['tests'],
                                          critical: snapshot.data![index]
                                              ['critical'],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                            snapshot.data![index]['country']),
                                        subtitle: Text(snapshot.data![index]
                                                ['cases']
                                            .toString()),
                                        leading: Image.network(
                                          snapshot.data![index]['countryInfo']
                                              ['flag'],
                                          width: 50,
                                          height: 50,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            });
                      }
                    }))
          ],
        ),
      ),
    );
  }
}
