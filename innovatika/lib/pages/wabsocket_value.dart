import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketValuePage extends StatefulWidget {
  final String title;
  final WebSocketChannel channel;
  WebSocketValuePage({Key? key, required this.channel})
      : title = 'WebSocket Value Page',
        super(key: key);
  // WebSocketValuePage({Key? key, required this.title, required this.channel}) : super(key: key);

  @override
  _WebSocketValuePageState createState() => _WebSocketValuePageState();
}

class _WebSocketValuePageState extends State<WebSocketValuePage> {
  String _message = "Waiting for data...";

  @override
  void initState() {
    super.initState();
    widget.channel.stream.listen((data) {
      setState(() {
        _message = data;
      });
    });
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              _message,
              style: TextStyle(fontSize: 24),
            ),
            WebSocketValuePage(
              channel: IOWebSocketChannel.connect('ws://192.168.137.54'),
            ),
          ],
        ),
      ),
    );
  }
}
