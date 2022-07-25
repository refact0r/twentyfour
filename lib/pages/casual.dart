import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/casual_game.dart';
import '../utils/haptics.dart';

class CasualPage extends StatefulWidget {
  const CasualPage({super.key});

  @override
  State<CasualPage> createState() => _CasualPageState();
}

class _CasualPageState extends State<CasualPage> {
  static const opIcons = [
    CupertinoIcons.plus,
    CupertinoIcons.minus,
    CupertinoIcons.multiply,
    CupertinoIcons.divide
  ];

  @override
  void initState() {
    super.initState();
    Provider.of<CasualGame>(context, listen: false).initialize(context);
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 36, 24, 36),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    hapticClick(context);
                    Navigator.pop(context);
                  },
                  color: colorScheme.onSurfaceVariant,
                  highlightColor:
                      colorScheme.onSurfaceVariant.withOpacity(0.08),
                  iconSize: 32,
                  icon: const Icon(Icons.clear_rounded),
                ),
                IconButton(
                  onPressed: () {
                    Provider.of<CasualGame>(context, listen: false).hint();
                  },
                  color: colorScheme.onSurfaceVariant,
                  highlightColor:
                      colorScheme.onSurfaceVariant.withOpacity(0.08),
                  iconSize: 32,
                  icon: const Icon(Icons.lightbulb_outline_rounded),
                ),
                IconButton(
                  onPressed: () {
                    Provider.of<CasualGame>(context, listen: false).undo();
                  },
                  color: colorScheme.onSurfaceVariant,
                  highlightColor:
                      colorScheme.onSurfaceVariant.withOpacity(0.08),
                  iconSize: 32,
                  icon: const Icon(Icons.undo_rounded),
                ),
                IconButton(
                  onPressed: () {
                    Provider.of<CasualGame>(context, listen: false).reset(true);
                  },
                  color: colorScheme.onSurfaceVariant,
                  highlightColor:
                      colorScheme.onSurfaceVariant.withOpacity(0.08),
                  iconSize: 32,
                  icon: const Icon(Icons.restart_alt_rounded),
                ),
              ],
            ),
            const Spacer(flex: 1),
            Center(
              child: Consumer<CasualGame>(
                builder: (context, casualGame, child) {
                  return GridView.count(
                    primary: false,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    children: <Widget>[
                      for (int i = 0; i < 4; i++)
                        Visibility(
                          visible: casualGame.numShown[i],
                          child: Hero(
                            tag: 'num$i',
                            child: ElevatedButton(
                              onPressed: () {
                                casualGame.pressNumButton(i, true);
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24)),
                                primary: casualGame.numPressed[i]
                                    ? colorScheme.primaryContainer
                                    : null,
                              ),
                              child: Text(
                                casualGame.nums[i].toString(),
                                style: const TextStyle(fontSize: 48),
                              ),
                            ),
                          ),
                        )
                    ],
                  );
                },
              ),
            ),
            const Spacer(flex: 1),
            Consumer<CasualGame>(
              builder: (context, casualGame, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (int i = 0; i < 4; i++)
                      SizedBox(
                        width: 72,
                        height: 72,
                        child: ElevatedButton(
                          onPressed: () {
                            hapticClick(context);
                            casualGame.pressOpButton(i);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: casualGame.opPressed[i]
                                ? colorScheme.primaryContainer
                                : null,
                          ),
                          child: Icon(opIcons[i], size: 32),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
