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
    ref.read(pupularMoviesProvider.notifier).loadNextPage();
    ref.read(upComingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoandingPage = ref.watch(initialLoadingPorvider);
    if (initialLoandingPage) return const FullScreenLoader();

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM').format(now);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(pupularMoviesProvider);
    final upComingMovies = ref.watch(upComingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    final nowPlayingMoviesMax6 = ref.watch(moviesSlideShowProvider);

    return Visibility(
      visible: !initialLoandingPage,
      child: CustomScrollView(physics: BouncingScrollPhysics(), slivers: [
        SliverAppBar(
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: CustomAppbar(),
          ),
          floating: true,
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return Column(
            children: [
              MoviesSlideShow(movies: nowPlayingMoviesMax6),
              MoviesHorizontalListview(
                  movies: nowPlayingMovies,
                  tittle: "En Cines",
                  subtittle: formattedDate,
                  loadNextpage: () => ref
                      .read(nowPlayingMoviesProvider.notifier)
                      .loadNextPage()),
              MoviesHorizontalListview(
                  movies: upComingMovies,
                  tittle: "Próximmente",
                  subtittle: "Este Mes",
                  loadNextpage: () =>
                      ref.read(upComingMoviesProvider.notifier).loadNextPage()),
              MoviesHorizontalListview(
                  movies: popularMovies,
                  tittle: "Populaes",
                  //subtittle: formattedDate,
                  loadNextpage: () =>
                      ref.read(pupularMoviesProvider.notifier).loadNextPage()),
              MoviesHorizontalListview(
                  movies: topRatedMovies,
                  tittle: "Mejor Calificada",
                  // subtittle: "",
                  loadNextpage: () =>
                      ref.read(topRatedMoviesProvider.notifier).loadNextPage()),
              SizedBox(
                height: 25,
              )
            ],
          );
        }, childCount: 1))
      ]),
    );
  }
}
