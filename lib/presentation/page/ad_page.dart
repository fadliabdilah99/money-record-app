import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobPage extends StatefulWidget {
  const AdmobPage({super.key});

  @override
  State<AdmobPage> createState() => _AdmobPageState();
}

BannerAd bannerAd = BannerAd(
  size: AdSize.banner,
  adUnitId: 'ca-app-pub-3940256099942544/6300978111',
  listener: BannerAdListener(
    onAdLoaded: (Ad ad) {
      print('ad Loaded');
    },
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      print('failed');
    },
    onAdOpened: (Ad ad) {
      print('Ad opened');
    },
  ),
  request: const AdRequest(),
);

class _AdmobPageState extends State<AdmobPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        child: AdWidget(ad: bannerAd..load()),
      ),
    );
  }
}
