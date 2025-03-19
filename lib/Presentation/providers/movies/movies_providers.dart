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

final pupularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>(
  (ref) {
    final fetchMoreMovie = ref.watch(movieRepositoryProvier).getPopularMovies;
    return MoviesNotifier(fetchMoreMovies: fetchMoreMovie);
  },
);

final upComingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>(
  (ref) {
    final fetchMoreMovie = ref.watch(movieRepositoryProvier).getUpCominMovies;
    return MoviesNotifier(fetchMoreMovies: fetchMoreMovie);
  },
);
final topRatedMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>(
  (ref) {
    final fetchMoreMovie = ref.watch(movieRepositoryProvier).getTopRatedMovies;
    return MoviesNotifier(fetchMoreMovies: fetchMoreMovie);
  },
);

typedef MovieCallBack = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  bool isLoading = false;
  int currentPage = 0;
  MovieCallBack fetchMoreMovies;
  MoviesNotifier({required this.fetchMoreMovies}) : super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;
    isLoading = true;
    currentPage++;

    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...movies];

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }
}
