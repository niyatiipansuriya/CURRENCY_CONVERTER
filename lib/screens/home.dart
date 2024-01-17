import 'package:currency/components/usd_to_any.dart';
import 'package:currency/models/rates_model.dart';
import 'package:flutter/material.dart';
import 'package:currency/functions/fetch_rate.dart';

class Home extends StatefulWidget {
  Home({super.key});
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  late Future<RatesModel> result;
  late Future<Map> allCurrencies;
  final formkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    result = fetchrates();
    allCurrencies = fetchcurrencies();
  }

  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: const Text(
          'Currency Converter',
          style: TextStyle(color: Color.fromARGB(255, 112, 110, 110)),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: h,
        width: w,
        padding: EdgeInsets.only(top: 65, left: 15, right: 15),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/demo.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: formkey,
            child: FutureBuilder<RatesModel>(
              future: result,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Center(
                  child: FutureBuilder<Map>(
                    future: allCurrencies,
                    builder: (context, currentSnapshot) {
                      if (currentSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Column(
                        children: [
                          UsdToAny(
                              rates: snapshot.data!.rates,
                              currencies: currentSnapshot.data!),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
