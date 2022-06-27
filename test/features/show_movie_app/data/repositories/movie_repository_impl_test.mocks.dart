// Mocks generated by Mockito 5.2.0 from annotations
// in show_movie_app/test/features/show_movie_app/data/repositories/movie_repository_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:show_movie_app/app/core/network/network_info.dart' as _i7;
import 'package:show_movie_app/app/features/show_movie_app/data/datasources/movie_local_datasource.dart'
    as _i5;
import 'package:show_movie_app/app/features/show_movie_app/data/datasources/movie_remote_datasource.dart'
    as _i2;
import 'package:show_movie_app/app/features/show_movie_app/data/models/movie_model.dart'
    as _i4;
import 'package:show_movie_app/app/features/show_movie_app/domain/entities/movie_entity.dart'
    as _i6;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

/// A class which mocks [MovieRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRemoteDataSource extends _i1.Mock
    implements _i2.MovieRemoteDataSource {
  MockMovieRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.MovieModel>> getMoviePopular() => (super.noSuchMethod(
          Invocation.method(#getMoviePopular, []),
          returnValue: Future<List<_i4.MovieModel>>.value(<_i4.MovieModel>[]))
      as _i3.Future<List<_i4.MovieModel>>);
  @override
  _i3.Future<List<_i4.MovieModel>> getMovieFreeToWatch() => (super.noSuchMethod(
          Invocation.method(#getMovieFreeToWatch, []),
          returnValue: Future<List<_i4.MovieModel>>.value(<_i4.MovieModel>[]))
      as _i3.Future<List<_i4.MovieModel>>);
}

/// A class which mocks [MovieLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieLocalDataSource extends _i1.Mock
    implements _i5.MovieLocalDataSource {
  MockMovieLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.MovieModel>> getLastMovies() => (super.noSuchMethod(
          Invocation.method(#getLastMovies, []),
          returnValue: Future<List<_i4.MovieModel>>.value(<_i4.MovieModel>[]))
      as _i3.Future<List<_i4.MovieModel>>);
  @override
  _i3.Future<void> cacheMovies(List<_i6.MovieEntity>? movieToCache) =>
      (super.noSuchMethod(Invocation.method(#cacheMovies, [movieToCache]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i3.Future<void>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i7.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<bool> get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected),
          returnValue: Future<bool>.value(false)) as _i3.Future<bool>);
}
