import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/bloc/portfolio_bloc.dart';
import 'package:portfolio/ui/portfolio_screen.dart';
import 'dart:html' if (dart.library.html) 'dart:html';
void main() {
  runApp(BlocProvider(
    create: (context) => PortfolioBloc(),
    child: const PortfolioApp(),
  ));
}
