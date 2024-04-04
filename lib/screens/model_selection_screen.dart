import 'package:ai_playground_project/screens/chatgpt.dart';
import 'package:ai_playground_project/screens/claude.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ai_playground_project/constants.dart';

class ExpansionTileExample extends StatefulWidget {
  const ExpansionTileExample({super.key});

  @override
  State<ExpansionTileExample> createState() => _ExpansionTileExampleState();
}

class _ExpansionTileExampleState extends State<ExpansionTileExample> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const ExpansionTile(
          title: Text('ExpansionTile 1'),
          subtitle: Text('Trailing expansion arrow icon'),
          children: <Widget>[
            ListTile(title: Text('This is tile number 1')),
          ],
        ),
        ExpansionTile(
          title: const Text('ExpansionTile 2'),
          subtitle: const Text('Custom expansion arrow icon'),
          trailing: Icon(
            _customTileExpanded
                ? Icons.arrow_drop_down_circle
                : Icons.arrow_drop_down,
          ),
          children: const <Widget>[
            ListTile(title: Text('This is tile number 2')),
          ],
          onExpansionChanged: (bool expanded) {
            setState(() {
              _customTileExpanded = expanded;
            });
          },
        ),
        const ExpansionTile(
          title: Text('ExpansionTile 3'),
          subtitle: Text('Leading expansion arrow icon'),
          controlAffinity: ListTileControlAffinity.leading,
          children: <Widget>[
            ListTile(title: Text('This is tile number 3')),
          ],
        ),
      ],
    );
  }
}

class ModelSelectionScreen extends StatefulWidget {
  const ModelSelectionScreen({super.key});
  @override
  _ModelselectionScreen createState() => _ModelselectionScreen();
}

class _ModelselectionScreen extends State<ModelSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
             ExpansionTile(
               expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
              title: Text('Select a model to continue'),


              children: <Widget>[
                ElevatedButton(
                    onPressed:(){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatGpt()),
                  );
                },
                    child: Text('ChatGpt 3.5'),

                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.transparent),
                elevation: MaterialStatePropertyAll(0),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),


                        )
                    ),
                ),

                ),
                ElevatedButton(
                  onPressed:(){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ClaudeScreen()),
                    );
                  },
                  child: Text('Claude Ai'),

                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.transparent),
                    elevation: MaterialStatePropertyAll(0),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),


                        )
                    ),
                  ),

                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
