import 'package:flutter/material.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stellar_demo/Repository/crowd_funding_repository.dart';
import 'package:stellar_demo/Repository/project_model.dart';

part 'state.g.dart';

@Riverpod(keepAlive: true)
class ProjectState extends _$ProjectState {
  @override
  Future<List<Projectt?>> build() async {
    try {
      return await CrowdFundingRepository.getProjects();
    } catch (e) {
      return [];
    }
  }
}
