import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_test/app/app.dart';
import 'package:pokemon_test/core/network/dio_client.dart';
import 'package:pokemon_test/core/theme/theme_cubit.dart';
import 'package:pokemon_test/core/storage/hive_manager.dart';
import 'package:pokemon_test/features/pokemon_generation/data/datasources/remote/generation_remote_data_source.dart';
import 'package:pokemon_test/features/pokemon_generation/data/repositories/generation_repository_impl.dart';
import 'package:pokemon_test/features/pokemon_generation/presentation/cubit/generation_cubit_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveManager.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(
          create: (_) => GenerationCubit(
            GenerationRepositoryImpl(GenerationRemoteDataSource(DioClient())),
          )..fetchGenerations(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
