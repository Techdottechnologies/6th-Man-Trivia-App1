// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sixth_man_travia/widgets/text_widget.dart';

class CrosswordAdminScreen extends StatefulWidget {
  const CrosswordAdminScreen({super.key});

  @override
  State<CrosswordAdminScreen> createState() => _CrosswordAdminScreenState();
}

class _CrosswordAdminScreenState extends State<CrosswordAdminScreen> {
  final List<Map<String, dynamic>> board =
      List.generate(7, (i) => {'row': i, 'cells': List.generate(7, (_) => '')});

  final List<Map<String, dynamic>> blocked = List.generate(
      7, (i) => {'row': i, 'cells': List.generate(7, (_) => false)});

  final TextEditingController wordCtrl = TextEditingController();
  final TextEditingController clueCtrl = TextEditingController();
  final TextEditingController rowCtrl = TextEditingController();
  final TextEditingController colCtrl = TextEditingController();
  String selectedDirection = 'across';

  List<Map<String, dynamic>> clues = [];
  String getCell(int row, int col) => board[row]['cells'][col];
  void setCell(int row, int col, String val) => board[row]['cells'][col] = val;

  bool isBlocked(int row, int col) => blocked[row]['cells'][col];
  void toggleBlock(int row, int col) =>
      blocked[row]['cells'][col] = !blocked[row]['cells'][col];
  void toggleBlocked(int row, int col) {
    setState(() {
      toggleBlock(row, col);
      if (isBlocked(row, col)) setCell(row, col, '');
    });
  }

  List<Map<String, dynamic>> history = [];
  void addWordToBoard() {
    final word = wordCtrl.text.trim().toUpperCase();
    final clue = clueCtrl.text.trim();
    final row = int.tryParse(rowCtrl.text.trim()) ?? 0;
    final col = int.tryParse(colCtrl.text.trim()) ?? 0;

    if (word.isEmpty ||
        clue.isEmpty ||
        row < 0 ||
        col < 0 ||
        row >= 7 ||
        col >= 7) return;

    List<Offset> modifiedCells = [];

    int r = row, c = col;
    for (int i = 0; i < word.length; i++) {
      if (r >= 7 || c >= 7 || isBlocked(r, c)) break;

      setState(() {
        setCell(r, c, word[i]);
        modifiedCells.add(Offset(r.toDouble(), c.toDouble()));
      });

      if (selectedDirection == 'across') {
        c++;
      } else {
        r++;
      }
    }

    setState(() {
      clues.add({
        'direction': selectedDirection,
        'text': clue,
        'number': clues.length + 1,
        'row': row,
        'col': col,
      });

      history.add({
        'modifiedCells': modifiedCells,
        'clue': clues.last,
      });

      wordCtrl.clear();
      clueCtrl.clear();
      rowCtrl.clear();
      colCtrl.clear();
    });
  }

  void undoLastAction() {
    if (history.isEmpty) return;

    final lastAction = history.removeLast();
    final List<Offset> modifiedCells = lastAction['modifiedCells'];
    final Map<String, dynamic> lastClue = lastAction['clue'];

    setState(() {
      for (var offset in modifiedCells) {
        setCell(offset.dx.toInt(), offset.dy.toInt(), '');
      }

      clues.removeWhere((e) =>
          e['row'] == lastClue['row'] &&
          e['col'] == lastClue['col'] &&
          e['text'] == lastClue['text']);
    });
  }

  void exportPuzzle() async {
    try {
      final serializedBoard =
          board.map((e) => List<String>.from(e['cells'])).toList();
      final serializedBlocked =
          blocked.map((e) => List<bool>.from(e['cells'])).toList();

      final serializedClues = clues.map((e) {
        try {
          return {
            'direction': e['direction']?.toString() ?? '',
            'text': e['text']?.toString() ?? '',
            'number': int.tryParse(e['number']?.toString() ?? '') ?? 0,
            'row': int.tryParse(e['row']?.toString() ?? '') ?? 0,
            'col': int.tryParse(e['col']?.toString() ?? '') ?? 0,
          };
        } catch (_) {
          return {
            'direction': '',
            'text': '',
            'number': 0,
            'row': 0,
            'col': 0,
          };
        }
      }).toList();

      final model = {
        'board': board,
        'blocked': blocked,
        'clues': serializedClues,
        'createdAt': FieldValue.serverTimestamp(),
      };

      print('🧩 MODEL EXPORT START');
      debugPrint('board: $serializedBoard', wrapWidth: 999999);
      debugPrint('blocked: $serializedBlocked', wrapWidth: 999999);
      debugPrint('clues: $serializedClues', wrapWidth: 999999);
      print('🧩 MODEL EXPORT END');
      await FirebaseFirestore.instance
          .collection('crossword')
          .doc(selectedDay)
          .delete();
      await FirebaseFirestore.instance
          .collection('crossword')
          .doc(selectedDay)
          .set(model);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("✅ Crossword saved successfully"),
        ));
      }
    } catch (e, stacktrace) {
      debugPrint('🔥 Export failed: $e\n$stacktrace');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("❌ Failed to save: $e"),
        ));
      }
    }
  }

  Widget _cell(int row, int col) {
    return GestureDetector(
      onTap: () => toggleBlocked(row, col),
      child: Container(
        width: 38,
        height: 38,
        margin: const EdgeInsets.all(3),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isBlocked(row, col) ? Colors.grey.shade800 : Colors.white,
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          getCell(row, col),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isBlocked(row, col) ? Colors.transparent : Colors.black,
          ),
        ),
      ),
    );
  }

  List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  String selectedDay = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding:
                EdgeInsets.only(top: 6.h, left: 16, right: 16, bottom: 3.h),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1E1E1E), Color(0xFF1E1E1E)],
              ),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Get.back(),
                      child: const Icon(Icons.arrow_back,
                          color: Color(0xFFF86624)),
                    ),
                    text_widget("Add Crosswords",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                    InkWell(
                        onTap: () {},
                        child: Icon(Icons.admin_panel_settings,
                            size: 2.h, color: Colors.transparent)),
                  ],
                ),
                SizedBox(height: 3.h),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  SizedBox(
                    width: 90.w,
                    height: 5.5.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: days.length,
                      itemBuilder: (_, index) => InkWell(
                        onTap: () {
                          if (selectedDay == days[index]) {
                            selectedDay = "";
                            setState(() {});
                          } else {
                            selectedDay = days[index];
                          }
                          setState(() {});
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: selectedDay == days[index]
                                  ? const Color(0xFFF86624)
                                  : Colors.grey),
                          child: text_widget(days[index],
                              color: selectedDay == days[index]
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 15.sp),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),

                  /// Input Fields
                  Row(
                    children: [
                      Expanded(
                          child: TextField(
                              controller: wordCtrl,
                              decoration:
                                  const InputDecoration(labelText: 'Word'))),
                      SizedBox(width: 2.w),
                      Expanded(
                          child: TextField(
                              controller: clueCtrl,
                              decoration:
                                  const InputDecoration(labelText: 'Clue'))),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      Expanded(
                          child: TextField(
                              controller: rowCtrl,
                              keyboardType: TextInputType.number,
                              decoration:
                                  const InputDecoration(labelText: 'Row'))),
                      SizedBox(width: 2.w),
                      Expanded(
                          child: TextField(
                              controller: colCtrl,
                              keyboardType: TextInputType.number,
                              decoration:
                                  const InputDecoration(labelText: 'Col'))),
                      SizedBox(width: 2.w),
                      DropdownButton<String>(
                        value: selectedDirection,
                        items: ['across', 'down']
                            .map((e) => DropdownMenuItem(
                                value: e, child: Text(e.capitalize!)))
                            .toList(),
                        onChanged: (v) =>
                            setState(() => selectedDirection = v!),
                      ),
                      SizedBox(width: 2.w),
                      InkWell(
                        onTap: addWordToBoard,
                        child: Container(
                          height: 40,
                          width: 25.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF86624),
                            borderRadius: BorderRadius.circular(35),
                          ),
                          child: Center(
                            child: text_widget(
                              "Add Word",
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                      )
                      // ElevatedButton(
                      //   onPressed: addWordToBoard,
                      //   child: const Text('Add Word'),
                      // ),
                    ],
                  ),
                  SizedBox(height: 2.h),

                  /// Grid Preview
                  Wrap(
                    children: List.generate(7, (row) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(7, (col) => _cell(row, col)),
                      );
                    }),
                  ),

                  // SizedBox(height: 2.h),

                  /// Clues List
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: clues.map((e) {
                        return ListTile(
                          title: Text(
                              "${e['number']}. ${e['text']} (${e['direction']})"),
                          subtitle: Text("Row: ${e['row']}, Col: ${e['col']}"),
                        );
                      }).toList(),
                    ),
                  ),
                  InkWell(
                    onTap: undoLastAction,
                    child: Container(
                      height: 50,
                      width: 30.w,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: Center(
                        child: text_widget(
                          "Undo",
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  InkWell(
                    onTap: () {
                      if (selectedDay == "") {
                        EasyLoading.showInfo('Select day first!');
                        return;
                      }

                      FocusScope.of(context)
                          .unfocus(); // prevent accidental keyboard issues
                      exportPuzzle();
                    },
                    child: Container(
                      height: 50,
                      width: 30.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF86624),
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: Center(
                        child: text_widget(
                          "Save",
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
