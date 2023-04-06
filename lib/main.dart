import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/common/colors/app_colors.dart';
import 'package:news/feature/presentation/bloc/bookmark_bloc/bookmark_bloc.dart';
import 'package:news/feature/presentation/bloc/news_bloc/news_bloc.dart';
import 'package:news/locator_service.dart';
import 'package:news/ui/widgets/bottom_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const News());
}

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsBloc>(
          create: (context) => sl<NewsBloc>(),
        ),
        BlocProvider<BookmarkBloc>(
          create: (context) => sl<BookmarkBloc>(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
            fontFamily: 'Lato',
            scaffoldBackgroundColor: AppColors.mainBackground,
            colorScheme: const ColorScheme.dark()),
        home: const BottomNavigation(),
      ),
    );
  }
}
