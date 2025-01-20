import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:smart_cart_app/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:smart_cart_app/features/home/presentation/manager/home_cubit/home_states.dart';

class ScanQrView extends StatelessWidget {
  const ScanQrView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeStates>(
      listener: (BuildContext context, state) {},
      child: Scaffold(
        body: MobileScanner(
          controller: MobileScannerController(
              detectionSpeed: DetectionSpeed.noDuplicates),
          onDetect: (capture) {
            print("====================================");
            final List<Barcode> barcodes = capture.barcodes;
            String val = "";
            for (final barcode in barcodes) {
              print(barcode.rawValue);
              val += barcode.displayValue!;
            }
            HomeCubit.get(context).saveQRCode(val);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
