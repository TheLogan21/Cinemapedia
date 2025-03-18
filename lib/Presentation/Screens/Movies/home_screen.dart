import 'package:cinemapedia/Presentation/providers/providers_barril.dart';

import 'package:cinemapedia/Presentation/widgets/widgets_barril.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  static const name = "home_screen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM').format(now);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

    final nowPlayingMoviesMax6 = ref.watch(moviesSlideShowProvider);

    if (nowPlayingMoviesMax6.isEmpty) return CircularProgressIndicator();

    return Column(
      children: [
        const CustomAppbar(),
        MoviesSlideShow(movies: nowPlayingMoviesMax6),
        MoviesHorizontalListview(
          movies: nowPlayingMovies,
          tittle: "En Cines",
          subtittle: formattedDate,
        )
      ],
    );
  }
}
