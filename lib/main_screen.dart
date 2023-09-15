import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ubitask_demo/user_model.dart';
import 'extensions.dart';

import 'package:flutter/services.dart' as bundle;

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final ScrollController _scrollController = ScrollController();

  void _startAutoScroll() {
    Timer.periodic(const Duration(milliseconds: 500), (timer) async {
      if (_scrollController.hasClients) {
        if (_scrollController.position.maxScrollExtent ==
                _scrollController.offset ||
            _scrollController.offset >
                _scrollController.position.maxScrollExtent + 50) {
          _scrollController.animateTo(
            0.0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.linear,
          );
        } else {
          if (100 > _scrollController.offset) {
            await Future.delayed(const Duration(seconds: 1));
          }
          _scrollController.animateTo(
            _scrollController.offset + 20.0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.linear,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _startAutoScroll();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Flutter Demo Home Page'),
        ),
        body: FutureBuilder<List<User>>(
            future: bundle.rootBundle.loadString('assets/data.json').then(
                (value) => List<User>.from(
                    json.decode(value).map((x) => User.fromJson(x)))),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.data == null) {
                return const Center(child: Text("No Data"));
              }

              print("length:-${snapshot.data?.length}");

              return SafeArea(
                bottom: true,
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                            child: Center(
                                child: Text("Name",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)))),
                        const VerticalDivider(
                          width: 2,
                          thickness: 1.5,
                        ).addPaddingSymmetric(horizontal: 5),
                        const Expanded(
                            child: Center(
                                child: Text("Email",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)))),
                        const VerticalDivider(
                          width: 2,
                          thickness: 1.5,
                        ).addPaddingSymmetric(horizontal: 5),
                        const Expanded(
                            child: Center(
                                child: Text("Phone",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)))),
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                            children: List.generate(snapshot.data?.length ?? 0,
                                (index) {
                          final user = snapshot.data?[index];

                          return Container(
                            color:
                                index % 2 == 0 ? Colors.green : Colors.yellow,
                            height: 50,
                            child: IntrinsicHeight(
                              child: Row(
                                children: [
                                  Text(
                                    "${index + 1}",
                                    style: const TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.bold),
                                  ).addPadding(8),
                                  Expanded(
                                      child: Center(
                                          child: Text(
                                    user?.name ?? "",
                                    textAlign: TextAlign.center,
                                  ))),
                                  const VerticalDivider(
                                    width: 2,
                                    thickness: 1.5,
                                  ).addPaddingSymmetric(horizontal: 5),
                                  Expanded(
                                      child: Center(
                                          child: Text(
                                    user?.email ?? "",
                                    textAlign: TextAlign.center,
                                  ))),
                                  const VerticalDivider(
                                    width: 2,
                                    thickness: 1.5,
                                  ).addPaddingSymmetric(horizontal: 5),
                                  Expanded(
                                      child: Center(
                                          child: Text(
                                    user?.phone ?? "",
                                    textAlign: TextAlign.center,
                                  ))),
                                ],
                              ),
                            ),
                          );
                        })),
                      ),
                    ),
                  ],
                ),
              );
            }));
  }
}
