class COVIDData {
  final String countryname;
  final String flagImage;
  final int test;
  final int todayDeaths;
  final int todayRecovered;
  final int todayCases;
  final int totalCases;
  final int totalRecovered;
  final int totalDeaths;
  final int critical;
  final int activeCases;
  final int population;

  COVIDData({
    required this.countryname,
    required this.flagImage,
    required this.test,
    required this.todayDeaths,
    required this.todayRecovered,
    required this.todayCases,
    required this.totalCases,
    required this.totalRecovered,
    required this.totalDeaths,
    required this.critical,
    required this.activeCases,
    required this.population,
  });

  factory COVIDData.fromMap({required Map data}) {
    return COVIDData(
      countryname: data["country"],
      // iso3: data["countryInfo"]["iso3"],
      flagImage: data["countryInfo"]["flag"],
      test: data["tests"],
      // continent: data["continent"],
      todayDeaths: data["todayDeaths"],
      todayRecovered: data["todayRecovered"],
      todayCases: data["todayCases"],
      totalCases: data["cases"],
      totalRecovered: data["recovered"],
      totalDeaths: data["deaths"],
      critical: data["critical"],
      activeCases: data["active"],
      population: data["population"],
    );
  }
}
