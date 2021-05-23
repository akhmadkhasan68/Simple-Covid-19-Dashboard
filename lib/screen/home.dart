import 'package:covid19_app/model/countries_data.dart';
import 'package:covid19_app/model/country_data.dart';
import 'package:covid19_app/model/global_data.dart';
import 'package:flutter/material.dart';
import 'package:covid19_app/color.dart';
import 'package:flutter_svg/svg.dart';
import 'package:covid19_app/widgets/infoCard.dart';
import 'package:covid19_app/service/covidApi.dart';

CovidApi _api = CovidApi();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<GlobalData> globalData;
  Future<CountriesData> countriesData;
  Future<CountryData> countryData;

  @override
  void initState() {
    super.initState();
    globalData = _api.getGlobalData();
    countriesData = _api.getCountriesData();
  }

  void selectCountry(newValue) {
    setState(() {
      valueChoose = newValue;
      print(newValue);
    });
    countryData = _api.getCountryData(newValue);
  }

  String valueChoose;
  List listItem = ["Indonesia", "Amerika", "Austria"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildHelpCard(context),
                  SizedBox(height: 20),
                  Text(
                    "Kasus Covid-19 Seluruh Dunia",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  FutureBuilder(
                      future: globalData,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: mainColor,
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  secondaryColor),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text("Error");
                        } else {
                          return Wrap(
                            runSpacing: 20,
                            spacing: 20,
                            children: [
                              Text(
                                "Terakhir update pada tanggal ${snapshot.data.lastUpdate}",
                                style: TextStyle(
                                  color: Color(0xff1e2432).withOpacity(0.5),
                                ),
                              ),
                              InfoCard(
                                title: "Total Kasus",
                                iconColor: Color(0xFF5856D6),
                                containerColor: whiteColor,
                                effectedNum: snapshot.data.confirmed.value +
                                    snapshot.data.deaths.value +
                                    snapshot.data.recovered.value,
                                press: () {},
                              ),
                              InfoCard(
                                title: "Terkonfirmasi",
                                iconColor: Color(0xFFFF8C00),
                                containerColor: whiteColor,
                                effectedNum: snapshot.data.confirmed.value,
                                press: () {},
                              ),
                              InfoCard(
                                title: "Kasus Meninggal",
                                iconColor: Color(0xFFFF2D55),
                                containerColor: whiteColor,
                                effectedNum: snapshot.data.deaths.value,
                                press: () {},
                              ),
                              InfoCard(
                                title: "Kasus Sembuh",
                                iconColor: Color(0xFF50E3C2),
                                containerColor: whiteColor,
                                effectedNum: snapshot.data.recovered.value,
                                press: () {},
                              ),
                            ],
                          );
                        }
                      }),
                  SizedBox(height: 20),
                  Text(
                    "Kasus Covid-19 Setiap Negara",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                    height: 60,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: FutureBuilder(
                        future: countriesData,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(
                                backgroundColor: mainColor,
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    secondaryColor),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Text("Error");
                          } else {
                            return DropdownButton(
                              hint: Text("Pilih Negara"),
                              underline: SizedBox(),
                              isExpanded: true,
                              value: valueChoose,
                              onChanged: (newValue) {
                                selectCountry(newValue);
                              },
                              items: snapshot.data.countries
                                  .map<DropdownMenuItem<String>>((item) {
                                return DropdownMenuItem<String>(
                                  value: item.iso3,
                                  child: Text(item.name),
                                );
                              }).toList(),

                              // listItem.map((valueItem) {
                              //   return DropdownMenuItem(
                              //     value: valueItem,
                              //     child: Text(valueItem),
                              //   );
                              // }).toList(),
                            );
                          }
                        }),
                  ),
                  SizedBox(height: 20),
                  (valueChoose != null)
                      ? FutureBuilder(
                          future: countryData,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: mainColor,
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      secondaryColor),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Text("Error");
                            } else {
                              return Wrap(
                                runSpacing: 20,
                                spacing: 20,
                                children: [
                                  Text(
                                    "Terakhir update pada tanggal ${snapshot.data.lastUpdate}",
                                    style: TextStyle(
                                      color: Color(0xff1e2432).withOpacity(0.5),
                                    ),
                                  ),
                                  InfoCard(
                                    title: "Total Kasus",
                                    iconColor: Color(0xFF5856D6),
                                    containerColor: whiteColor,
                                    effectedNum: snapshot.data.confirmed.value +
                                        snapshot.data.deaths.value +
                                        snapshot.data.recovered.value,
                                    press: () {},
                                  ),
                                  InfoCard(
                                    title: "Terkonfirmasi",
                                    iconColor: Color(0xFFFF8C00),
                                    containerColor: whiteColor,
                                    effectedNum: snapshot.data.confirmed.value,
                                    press: () {},
                                  ),
                                  InfoCard(
                                    title: "Kasus Meninggal",
                                    iconColor: Color(0xFFFF2D55),
                                    containerColor: whiteColor,
                                    effectedNum: snapshot.data.deaths.value,
                                    press: () {},
                                  ),
                                  InfoCard(
                                    title: "Kasus Sembuh",
                                    iconColor: Color(0xFF50E3C2),
                                    containerColor: whiteColor,
                                    effectedNum: snapshot.data.recovered.value,
                                    press: () {},
                                  ),
                                ],
                              );
                            }
                          })
                      : Container(),
                  SizedBox(height: 20),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Tindakan Preventif",
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        buildPreventation(),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row buildPreventation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        PreventitonCard(
          svgSrc: "assets/icons/hand_wash.svg",
          title: "Cuci Tangan",
        ),
        PreventitonCard(
          svgSrc: "assets/icons/use_mask.svg",
          title: "Pakai Masker",
        ),
        PreventitonCard(
          svgSrc: "assets/icons/Clean_Disinfect.svg",
          title: "Jaga Kebersihan",
        ),
      ],
    );
  }

  Container buildHelpCard(BuildContext context) {
    return Container(
      height: 110,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              // left side padding is 40% of total width
              // left: MediaQuery.of(context).size.width * .4,
              left: 20,
              top: 20,
              right: 0,
            ),
            height: 130,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  mainColor,
                  secondaryColor,
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Hubungi 021-5210411 \nuntuk Bantuan Medis!\n",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.white),
                  ),
                  TextSpan(
                    text: "Jika anda mengalami gejala Covid-19",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 10),
          //   child: SvgPicture.asset("assets/icons/nurse.svg"),
          // ),
          Positioned(
            top: 30,
            right: 10,
            child: SvgPicture.asset("assets/icons/virus.svg"),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: mainColor.withOpacity(0.03),
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.menu,
          color: mainColor,
        ),
        onPressed: () {},
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
            color: mainColor,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}

class PreventitonCard extends StatelessWidget {
  final String svgSrc;
  final String title;
  const PreventitonCard({
    Key key,
    this.svgSrc,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SvgPicture.asset(svgSrc),
        SizedBox(height: 5),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
        )
      ],
    );
  }
}
