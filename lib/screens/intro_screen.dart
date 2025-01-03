import 'package:flutapp/widgets/android_player.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _controller,
            decoration: InputDecoration(
                hintText: "Enter playback url here...",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                    onPressed: () {
                      _controller.clear();
                    },
                    icon: Icon(Icons.close))),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => AndroidPlayer(
                          videoUrl: _controller.text,
                        )),
              );
            },
            child: Text("Watch"),
            color: Colors.amber[600],
          )
        ],
      ),
    );
  }
}
