import 'package:go_router/go_router.dart';

import '../pages/hero_animation/hero.dart';
import '../pages/timeline/timeline.dart';

final _router = GoRouter(initialLocation: '/', routes: [
  GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => const TimelinePage(
            count: 11,
          )),
  GoRoute(
      name: 'page2',
      path: '/page2',
      builder: (context, state) => HeroAnimtion())
]);
