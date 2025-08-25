import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../widgets/text_widget.dart';

class Clue {
  final String direction; // 'across' or 'down'
  final String text;
  final int number;
  final int row;
  final int col;

  Clue({
    required this.direction,
    required this.text,
    required this.number,
    required this.row,
    required this.col,
  });
}

class PlayGameScreen extends StatefulWidget {
  const PlayGameScreen({super.key});

  @override
  State<PlayGameScreen> createState() => _PlayGameScreenState();
}

class _PlayGameScreenState extends State<PlayGameScreen> {
  List<Map<String, dynamic>> board = [];
  List<Map<String, dynamic>> blocked = [];
  List<List<TextEditingController>> controllers = [];
  List<List<bool>> revealed = [];
  List<List<String?>> gridNumbers = [];
  List<Clue> clues = [];
  List<Map<String, dynamic>> solutionBoard = [];
  List<List<bool>> blockedCells = [];
  Clue? selectedClue;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadSavedGame();
  }

  String fetchCurrentDay() {
    final now = DateTime.now();
    const weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    return weekdays[now.weekday - 1]; // weekday: 1=Mon … 7=Sun
  }

  bool isAvailable = false;
  String? statusMessage;
  Future<void> loadSavedGame() async {
    try {
      final day = fetchCurrentDay();
      final doc = await FirebaseFirestore.instance
          .collection('crossword')
          .doc(day)
          .get();

      if (!doc.exists) {
        setState(() {
          isLoading = false;
          isAvailable = false;
          statusMessage = "Crossword is not available for today ($day).";
        });
        return;
      }

      final data = doc.data()!;
      board = List<Map<String, dynamic>>.from(data['board'] ?? []);
      blocked = List<Map<String, dynamic>>.from(data['blocked'] ?? []);
      final cluesData = List<Map<String, dynamic>>.from(data['clues'] ?? []);
      clues = cluesData.map((e) {
        return Clue(
          direction: e['direction'] ?? '',
          text: e['text'] ?? '',
          number: e['number'] ?? 0,
          row: e['row'] ?? 0,
          col: e['col'] ?? 0,
        );
      }).toList();

      final rowCount = board.length;
      final colCount = rowCount > 0 ? (board[0]['cells'] as List).length : 0;

      revealed =
          List.generate(rowCount, (_) => List.generate(colCount, (_) => false));
      controllers = List.generate(
        rowCount,
        (i) => List.generate(colCount, (j) => TextEditingController()),
      );
      gridNumbers =
          List.generate(rowCount, (_) => List.generate(colCount, (_) => null));

      for (var clue in clues) {
        if (clue.row < rowCount && clue.col < colCount) {
          gridNumbers[clue.row][clue.col] = clue.number.toString();
        }
      }

      solutionBoard = board.map((row) {
        return {'cells': List<String>.from(row['cells'])};
      }).toList();

      blockedCells =
          blocked.map((row) => List<bool>.from(row['cells'])).toList();

      setState(() {
        isLoading = false;
        isAvailable = true;
        statusMessage = null;
      });
    } catch (e, st) {
      debugPrint("🔥 Exception while loading game: $e\n$st");
      if (mounted) {
        setState(() {
          isLoading = false;
          isAvailable = false;
          statusMessage = "Failed to load crossword: $e";
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to load crossword: $e")),
        );
      }
    }
  }

  bool isCellBlocked(int row, int col) {
    try {
      return List<bool>.from(blocked[row]['cells'])[col];
    } catch (_) {
      return false;
    }
  }

  String getCellValueSafe(List list, int row, int col) {
    try {
      return List<String>.from(list[row]['cells'])[col];
    } catch (_) {
      return '';
    }
  }

  List<Offset> getHighlightedCells(Clue clue) {
    List<Offset> cells = [];
    int r = clue.row;
    int c = clue.col;
    while (r < 7 &&
        c < 7 &&
        !(blockedCells.length > r &&
            blockedCells[r].length > c &&
            blockedCells[r][c])) {
      cells.add(Offset(r.toDouble(), c.toDouble()));
      if (clue.direction == 'across') {
        c++;
      } else {
        r++;
      }
    }
    return cells;
  }

  Widget _cell(int row, int col) {
    final isBlocked = isCellBlocked(row, col);
    if (isBlocked) {
      return Container(
        width: 38,
        height: 38,
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(5),
        ),
      );
    }

    bool isHighlighted = false;
    if (selectedClue != null) {
      isHighlighted = getHighlightedCells(selectedClue!).any(
        (offset) => offset.dx.toInt() == row && offset.dy.toInt() == col,
      );
    }

    final solution = getCellValueSafe(solutionBoard, row, col);
    final currentVal = getCellValueSafe(board, row, col);
    final showError = currentVal.isNotEmpty && currentVal != solution;

    Color bgColor;
    if (isHighlighted) {
      bgColor = Colors.orange.shade100;
    } else if (revealed[row][col]) {
      bgColor = Colors.green.shade100;
    } else if (showError) {
      bgColor = Colors.red.shade100;
    } else {
      bgColor = Colors.white;
    }

    return Stack(
      children: [
        Container(
          width: 38,
          height: 38,
          margin: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: const Color(0xFFD9D9D9)),
          ),
        ),
        if (gridNumbers[row][col] != null)
          Positioned(
            top: 2,
            left: 4,
            child: Text(
              gridNumbers[row][col]!,
              style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.bold),
            ),
          ),
        Positioned.fill(
          child: Center(
            child: TextField(
              controller: controllers[row][col],
              onChanged: (val) => setState(() {
                final rowBoard = List<String>.from(board[row]['cells']);
                rowBoard[col] = val.toUpperCase();
                board[row]['cells'] = rowBoard;
                selectedClue = null;
              }),
              textAlign: TextAlign.center,
              maxLength: 1,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
              decoration: const InputDecoration(
                  border: InputBorder.none, counterText: ''),
            ),
          ),
        )
      ],
    );
  }

  Widget _clueColumn(String dir) {
    final filtered =
        clues.where((e) => e.direction == dir.toLowerCase()).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text_widget(dir, fontSize: 17.sp, color: const Color(0xFFF86624)),
        SizedBox(height: 1.5.h),
        ...filtered.map((clue) {
          return GestureDetector(
            onTap: () {
              if (selectedClue == clue) {
                selectedClue = null;
                setState(() {});
              } else {
                setState(() => selectedClue = clue);
              }
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 1.5.h),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: selectedClue == clue
                    ? const Color(0xFFF86624).withOpacity(0.15)
                    : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFCFCFCF), width: 1.2),
              ),
              child: Row(
                children: [
                  text_widget("${clue.number}.",
                      fontSize: 15.sp, fontWeight: FontWeight.w500),
                  const SizedBox(width: 8),
                  Expanded(child: text_widget(clue.text, fontSize: 15.sp)),
                ],
              ),
            ),
          );
        })
      ],
    );
  }

  void resetBoard() {
    setState(() {
      for (int i = 0; i < board.length; i++) {
        board[i]['cells'] = List.generate(7, (_) => "");
        for (int j = 0; j < 7; j++) {
          controllers[i][j].text = "";
          revealed[i][j] = false;
        }
      }
    });
  }

  void checkAnswer() {
    for (int i = 0; i < board.length; i++) {
      final rowBoard = List<String>.from(board[i]['cells']);
      final rowSolution = List<String>.from(solutionBoard[i]['cells']);
      final rowBlocked = List<bool>.from(blocked[i]['cells']);
      for (int j = 0; j < rowBoard.length; j++) {
        if (!rowBlocked[j]) {
          revealed[i][j] = rowBoard[j].toUpperCase() == rowSolution[j];
        }
      }
    }
    setState(() {});
  }

  void revealLetter() {
    outerLoop:
    for (int i = 0; i < blocked.length; i++) {
      final rowBlocked = List<bool>.from(blocked[i]['cells']);
      final rowSolution = List<String>.from(solutionBoard[i]['cells']);
      final rowBoard = List<String>.from(board[i]['cells']);
      for (int j = 0; j < rowBoard.length; j++) {
        if (!rowBlocked[j] && rowBoard[j] != rowSolution[j]) {
          rowBoard[j] = rowSolution[j];
          controllers[i][j].text = rowSolution[j];
          revealed[i][j] = true;
          board[i]['cells'] = rowBoard;
          break outerLoop;
        }
      }
    }
    setState(() {});
  }

  void revealWord() {
    for (int i = 0; i < board.length; i++) {
      final rowBlocked = List<bool>.from(blocked[i]['cells']);
      final rowSolution = List<String>.from(solutionBoard[i]['cells']);
      final rowBoard = List<String>.from(board[i]['cells']);
      for (int j = 0; j < rowBoard.length; j++) {
        if (!rowBlocked[j]) {
          rowBoard[j] = rowSolution[j];
          controllers[i][j].text = rowSolution[j];
          revealed[i][j] = true;
        }
      }
      board[i]['cells'] = rowBoard;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  // ── Top header (unchanged) ────────────────────────────────────────
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                        top: 6.h, left: 16, right: 16, bottom: 3.h),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xFF1E1E1E), Color(0xFF1E1E1E)]),
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(80)),
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
                            text_widget("Play Game",
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                            const Icon(Icons.arrow_back,
                                color: Colors.transparent),
                          ],
                        ),
                        SizedBox(height: 3.h),
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            GestureDetector(
                              onTap: resetBoard,
                              child: _topButton(
                                  "Reset",
                                  Colors.white,
                                  const Color(0xFFF86624),
                                  const Color(0xFFF86624)),
                            ),
                            GestureDetector(
                              onTap: checkAnswer,
                              child: _topButton(
                                  "Check Answer",
                                  const Color(0xFFF86624),
                                  Colors.transparent,
                                  Colors.white),
                            ),
                            GestureDetector(
                              onTap: revealLetter,
                              child: _topButton(
                                  "Reveal Letter",
                                  Colors.transparent,
                                  Colors.white,
                                  Colors.white,
                                  border: true),
                            ),
                            GestureDetector(
                              onTap: revealWord,
                              child: _topButton(
                                  "Reveal Word",
                                  Colors.transparent,
                                  const Color(0xFFF86624),
                                  const Color(0xFFF86624),
                                  border: true),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // ── If not available, show message card ───────────────────────────
                  if (!isAvailable) ...[
                    SizedBox(height: 6.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 22),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: const Color(0xFFCFCFCF), width: 1.2),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.info_outline,
                                size: 26.sp, color: const Color(0xFFF86624)),
                            SizedBox(height: 1.2.h),
                            text_widget(
                              statusMessage ??
                                  "Crossword is not available for today.",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 6.h),
                  ]
                  // ── Else show the board + clues ───────────────────────────────────
                  else ...[
                    SizedBox(height: 3.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Column(
                        children: List.generate(7, (row) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                                List.generate(7, (col) => _cell(row, col)),
                          );
                        }),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _clueColumn("Across")),
                          SizedBox(width: 4.w),
                          Expanded(child: _clueColumn("Down")),
                        ],
                      ),
                    ),
                    SizedBox(height: 4.h),
                  ],
                ],
              ),
            ),
    );
  }

  Widget _topButton(String label, Color bg, Color borderColor, Color textColor,
      {bool border = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(30),
        border: border ? Border.all(color: borderColor, width: 1.5) : null,
      ),
      child: text_widget(label,
          color: textColor, fontWeight: FontWeight.w500, fontSize: 16.sp),
    );
  }
}
