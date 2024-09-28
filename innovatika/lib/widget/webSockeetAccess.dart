import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  late WebSocketChannel channel;
  String receivedData = '';
  String connectionStatus = 'Connecting...';

  @override
  void initState() {
    super.initState();
    _connectWebSocket();
  }

  void _connectWebSocket() {
    try {
      channel = IOWebSocketChannel.connect(Uri.parse("ws://192.168.4.1:81"));
      channel.stream.listen((onData) {
        setState(() {
          receivedData = onData;
          connectionStatus = 'Connected';
        });
      }, onError: (error) {
        setState(() {
          connectionStatus = 'Connection Error: $error';
        });
        print('Error: $error');
      });
    } catch (e) {
      setState(() {
        connectionStatus = 'Connection Failed: $e';
      });
      print('Error connecting to WebSocket: $e');
    }
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebSocket Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text('Status: $connectionStatus'),
            SizedBox(height: 20),
            Text('Received: $receivedData'),
          ],
        ),
      ),
    );
  }
}