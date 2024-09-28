import 'dart:async';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:innovatika/database/informer_hardware.dart';
import 'package:innovatika/widget/appbar.dart';
import 'package:innovatika/widget/loading.dart';
import 'package:innovatika/widget/wifi.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:toastification/toastification.dart';

class DeviceSetup extends StatefulWidget {
  const DeviceSetup({super.key});

  @override
  State<DeviceSetup> createState() => _DeviceSetupState();
}

class _DeviceSetupState extends State<DeviceSetup> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final MobileScannerController controller = MobileScannerController(
    formats: const [BarcodeFormat.qrCode],
  );
  late bool isLoading = false;
  @override
  Future<void> dispose() async {
    super.dispose();
    await controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    TextEditingController ipAddr = TextEditingController();
    TextEditingController ssid = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController devID = TextEditingController();
    TextEditingController devName = TextEditingController();

    Future<void> handleSubmit() async {
      if (formKey.currentState!.validate()) {
        setState(() {
          isLoading = true;
        });
        bool isConnected = await connectWifi(
          ssid.text,
          password.text,
        );
        bool isPing = await isPingSuccessful(ipAddr.text);
        if (!context.mounted) return;
        // await deviceNameEnter(context);
        devName.text = devID.text;
        if (!isPing || devName.text.isEmpty || !isConnected) {
          String errorN = "Failed! Please provide valid details.";
          if (!isConnected) {
            errorN =
                "Connection to the device WiFi failed. Please check the WiFi settings and try again.";
          } else if (!isPing) {
            errorN = "Unable to ping the device. Please try again later.";
          } else if (devName.text.isEmpty) {
            errorN =
                "Device name cannot be empty. Please enter a valid device name.";
          }
          toastification.show(
            context: context,
            type: ToastificationType.error,
            style: ToastificationStyle.flat,
            alignment: Alignment.bottomCenter,
            autoCloseDuration: const Duration(seconds: 5),
            title: Text(
              errorN,
              textAlign: TextAlign.center,
            ),
          );
          setState(() {
            isLoading = false;
          });
          return;
        } else {
          //TODO
          Hardware(
            name: devName.text,
            ip: ipAddr.text,
            ssid: ssid.text,
            passwd: password.text,
            id: 0,
          );
          toastification.show(
            context: context,
            type: ToastificationType.success,
            style: ToastificationStyle.flat,
            alignment: Alignment.bottomCenter,
            autoCloseDuration: const Duration(seconds: 5),
            title: const Text(
              'Device Added Successfully!',
              textAlign: TextAlign.center,
            ),
          );
          setState(() {
            isLoading = false;
          });
        }
        Navigator.pop(context);
      }
    }

    Map<String, String> extractWiFiDetails(String qrData) {
      String ssid = '';
      String password = '';
      String ipAddress = '';
      String id = '';

      // Split the input string by commas to get individual parts
      List<String> parts = qrData.split(',');

      // Loop through each part and extract the corresponding value
      for (String part in parts) {
        if (part.startsWith('ssid:')) {
          ssid = part.substring(5); // Remove 'ssid:' and get the SSID
        } else if (part.startsWith('ip:')) {
          ipAddress = part.substring(3); // Remove 'ip:' and get the IP address
        } else if (part.startsWith('pass:')) {
          password = part.substring(5); // Remove 'pass:' and get the password
        } else if (part.startsWith('id:')) {
          id = part.substring(3); // Remove 'id:' and get the device id
        }
      }
      return {
        'ssid': ssid,
        'ip': ipAddress,
        'password': password,
        'id': id,
      };
    }

    return Scaffold(
      appBar: commonApp(context: context),
      body: !isLoading
          ? ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: width / 2,
                      height: width / 2,
                      child: MobileScanner(
                        controller: controller,
                        onDetect: (barcodes) {
                          if (barcodes.raw != null) {
                            Map<String, String> wifiDetails =
                                extractWiFiDetails(barcodes.raw.toString());
                            ssid.text = wifiDetails['ssid'] ?? '';
                            ipAddr.text = wifiDetails['ip'] ?? '';
                            password.text = wifiDetails['password'] ?? '';
                            devID.text = wifiDetails['id'] ?? '';
                            formKey.currentState!.save();
                            handleSubmit();
                          }
                        },
                      ),
                    ),
                    // Bottom half: Divider and manual input section
                    const SizedBox(
                      height: 50,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.0),
                            child: Divider(
                              thickness: 2.0,
                            ),
                          ),
                          const Text(
                            "OR",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w500),
                          ),
                          const Text(
                            'Enter Manually',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 20.0),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextFormField(
                              controller: ipAddr,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty &&
                                        !RegExp(r'^(?=\d+\.\d+\.\d+\.\d+$)(?:(?:25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9][0-9]|[0-9])\.){3}(?:25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9][0-9]|[0-9])$')
                                            .hasMatch(value)) {
                                  return 'Enter IP Address';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: 'IP Address',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: ssid,
                                    decoration: const InputDecoration(
                                      labelText: 'SSID',
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter Device SSID';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ), // Add space between the two fields
                                Expanded(
                                  child: TextFormField(
                                    controller: password,
                                    decoration: const InputDecoration(
                                      labelText: 'Password',
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter Device Password';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextFormField(
                              controller: devID,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter Device ID';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: 'Device ID',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextButton.icon(
                            onPressed: () {
                              handleSubmit();
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                const Color.fromARGB(255, 253, 234, 255),
                              ),
                            ),
                            icon: const Text("Save"),
                            label: const Icon(Iconsax.document_upload),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ],
            )
          : const Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                LoadingDeviceAnimation(),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
    );
  }
}
