import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:smart_cart_app/core/services/cache_helper.dart';
import 'package:smart_cart_app/core/services/cache_helper_consts.dart';
import 'package:smart_cart_app/features/home/presentation/manager/home_cubit/home_cubit.dart';

class ScanQrView extends StatelessWidget {
  const ScanQrView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MobileScanner(
        controller: MobileScannerController(
            detectionSpeed: DetectionSpeed.noDuplicates),
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          String cartID = "";
          for (final barcode in barcodes) {
            cartID += barcode.displayValue!;
          }
          CacheHelper.putString(key: CacheHelperKeys.cartID, value: cartID);
          HomeCubit.get(context).connectUserToCart(cartID);
          Navigator.pop(context);
        },
      ),
    );
  }
}
