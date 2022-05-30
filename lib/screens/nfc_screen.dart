import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NFCScreen extends StatefulWidget {
  const NFCScreen({Key? key}) : super(key: key);

  @override
  State<NFCScreen> createState() => _NFCScreenState();
}

class _NFCScreenState extends State<NFCScreen> {
  String data = "No data";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CupertinoNavigationBar(
        previousPageTitle: "Back",
      ),
      body: Align(
        alignment: Alignment.center,
        child: FractionallySizedBox(
          heightFactor: 0.9,
          widthFactor: 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                fit: FlexFit.tight,
                flex: 5,
                child: Scrollbar(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        border: Border.fromBorderSide(BorderSide())),
                    child: SingleChildScrollView(
                      child: Center(
                        child: Text(
                          data,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20.0)),
                    onPressed: () async {
                      NfcManager.instance.startSession(
                          onDiscovered: (NfcTag tag) async {
                        setState(() {
                          data = tag.data.toString();
                        });
                        NfcManager.instance.stopSession();
                      });
                    },
                    child: const Text("Scan NFC-tag"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
