import 'package:flutter/material.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:permission_handler/permission_handler.dart';
import '../utils/constants.dart';
import 'game_room_screen.dart';

class BluetoothLobbyScreen extends StatefulWidget {
  const BluetoothLobbyScreen({super.key});

  @override
  State<BluetoothLobbyScreen> createState() => _BluetoothLobbyScreenState();
}

class _BluetoothLobbyScreenState extends State<BluetoothLobbyScreen> {
  final String userName = "لاعب_${DateTime.now().millisecond}";
  final Strategy strategy = Strategy.P2P_STAR;
  Map<String, ConnectionInfo> discoveredDevices = {};
  bool isAdvertising = false;
  bool isDiscovering = false;

  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  void requestPermissions() async {
    await [
      Permission.location,
      Permission.bluetooth,
      Permission.bluetoothAdvertise,
      Permission.bluetoothConnect,
      Permission.bluetoothScan,
      Permission.nearbyWifiDevices,
    ].request();
  }

  void startHosting() async {
    try {
      bool a = await Nearby().startAdvertising(
        userName,
        strategy,
        onConnectionInitiated: onConnectionInit,
        onConnectionResult: (id, status) {
          if (status == Status.CONNECTED) {
            goToGameRoom();
          }
        },
        onDisconnected: (id) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('❌ انقطع الاتصال!')));
        },
      );
      setState(() {
        isAdvertising = a;
      });
    } catch (exception) {
      print(exception);
    }
  }

  void startDiscovering() async {
    try {
      bool d = await Nearby().startDiscovery(
        userName,
        strategy,
        onEndpointFound: (id, name, serviceId) {
          setState(() {
            // الإصلاح الأول: إزالة أسماء المتغيرات
            discoveredDevices[id] = ConnectionInfo(name, '', false);
          });
        },
        onEndpointLost: (id) {
          setState(() {
            discoveredDevices.remove(id);
          });
        },
      );
      setState(() {
        isDiscovering = d;
      });
    } catch (e) {
      print(e);
    }
  }

  void onConnectionInit(String id, ConnectionInfo info) {
    Nearby().acceptConnection(
      id,
      // الإصلاح الثاني: استخدام الإملاء الخاص بالمكتبة وإضافة الدالة الناقصة
      onPayLoadRecieved: (endId, payload) {},
      onPayloadTransferUpdate: (endId, payloadTransferUpdate) {},
    );
  }

  void goToGameRoom() {
    Nearby().stopAdvertising();
    Nearby().stopDiscovery();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const GameRoomScreen(category: "بلوتوث local 📱")),
    );
  }

  @override
  void dispose() {
    Nearby().stopAdvertising();
    Nearby().stopDiscovery();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GameColors.background,
      appBar: AppBar(
        title: const Text('غرفة اللعب المحلي 📶'),
        backgroundColor: GameColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: isAdvertising ? Colors.red : Colors.green),
                  icon: const Icon(Icons.gavel),
                  label: Text(isAdvertising ? 'إيقاف البث' : 'إنشاء غرفة (Host)'),
                  onPressed: isAdvertising ? () => Nearby().stopAdvertising().then((_) => setState(() => isAdvertising = false)) : startHosting,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: isDiscovering ? Colors.red : Colors.blue),
                  icon: const Icon(Icons.search),
                  label: Text(isDiscovering ? 'إيقاف البحث' : 'بحث عن غرف'),
                  onPressed: isDiscovering ? () => Nearby().stopDiscovery().then((_) => setState(() => isDiscovering = false)) : startDiscovering,
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text('الأجهزة والغرف المتاحة بالقرب منك:', style: TextStyle(color: Colors.white, fontSize: 18)),
            const SizedBox(height: 10),
            Expanded(
              child: discoveredDevices.isEmpty
                  ? const Center(child: Text('جاري البحث أو الانتظار... 🔍', style: TextStyle(color: Colors.white54)))
                  : ListView.builder(
                      itemCount: discoveredDevices.length,
                      itemBuilder: (context, index) {
                        String id = discoveredDevices.keys.elementAt(index);
                        ConnectionInfo info = discoveredDevices[id]!;
                        return Card(
                          color: GameColors.panel,
                          child: ListTile(
                            title: Text(info.endpointName, style: const TextStyle(color: Colors.white)),
                            subtitle: const Text('اضغط للطلب والانضمام 🎮', style: TextStyle(color: Colors.white70)),
                            trailing: const Icon(Icons.cloud_upload, color: GameColors.secondary),
                            // الإصلاح الثالث: استخدام onTap بدلاً من onPressed
                            onTap: () {
                              Nearby().requestConnection(
                                userName,
                                id,
                                onConnectionInitiated: onConnectionInit,
                                onConnectionResult: (id, status) {
                                  if (status == Status.CONNECTED) {
                                    goToGameRoom();
                                  }
                                },
                                onDisconnected: (id) {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('انقطع الاتصال!')));
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
