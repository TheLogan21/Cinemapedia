import 'package:cinemapedia/Presentation/providers/movies/movies_repository_provider.dart';
import 'package:cinemapedia/domain/Entities/movies.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>(
  (ref) {
    final fetchMoreMovie = ref.watch(movieRepositoryProvier).getNowPlaying;
    return MoviesNotifier(fetchMoreMovies: fetchMoreMovie);
  },
);

typedef MovieCallBack = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  MovieCallBack fetchMoreMovies;
  MoviesNotifier({required this.fetchMoreMovies}) : super([]);

  Future<void> loadNextPage() async {
    currentPage++;

    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...movies];
  }
}
