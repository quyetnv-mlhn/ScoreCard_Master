import 'package:score_card_master/data/models/score_board_model.dart';
import 'package:score_card_master/di/service_locator.dart';
import 'package:score_card_master/domain/repositories/board_game_repository.dart';
import 'package:score_card_master/features/game_detail/view/game_detail_page.dart';
import 'package:score_card_master/features/history/bloc/history_bloc.dart';
import 'package:score_card_master/features/history/widgets/history_item.dart';
import 'package:score_card_master/features/new_game/view/new_game_page.dart';
import 'package:score_card_master/widgets/general_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          HistoryBloc(boardGameRepository: getIt<BoardGameRepository>())
            ..add(const FetchHistoryEvent()),
      child: const HistoryView(),
    );
  }
}

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GeneralAppBar(title: 'History'),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const NewGamePage()),
        ),
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HistoryLoadSuccess) {
            return GroupListHistory(listScoreBoard: state.games);
          } else {
            return const Text('Failed to load games');
          }
        },
      ),
    );
  }
}

class GroupListHistory extends StatelessWidget {
  const GroupListHistory({super.key, required this.listScoreBoard});

  final List<ScoreBoard> listScoreBoard;

  @override
  Widget build(BuildContext context) {
    return GroupedListView(
      elements: listScoreBoard,
      groupBy: (element) => DateFormat('dd/MM').format(element.timestamp),
      groupComparator: (value1, value2) => value1.compareTo(value2),
      itemComparator: (item1, item2) =>
          item1.timestamp.compareTo(item2.timestamp),
      order: GroupedListOrder.DESC,
      useStickyGroupSeparators: true,
      groupSeparatorBuilder: (String value) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      itemBuilder: (c, element) => HistoryItem(
        scoreBoard: element,
        onTap: () {
          Navigator.of(c).pushReplacement(
            MaterialPageRoute(
              builder: (c) => GameDetailPage(scoreBoard: element),
            ),
          );
        },
      ),
    );
  }
}
