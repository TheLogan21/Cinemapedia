import 'package:cinemapedia/Presentation/Screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: "/", routes: [
  GoRoute(
    path: "/home_screen",
    name: HomeScreen.name,
    builder: (context, state) => HomeScreen(),
  )
]);
