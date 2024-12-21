import 'dart:io';

import 'package:get/get.dart';
import 'package:volunteer_community_connection_app/models/community.dart';
import 'package:volunteer_community_connection_app/repositories/community_repository.dart';

class CommunityController extends GetxController {
  static final CommunityController _instance = CommunityController._internal();
  factory CommunityController() => _instance;
  CommunityController._internal();

  final CommunityRepository _communityRepository = CommunityRepository();

  var communities = Rx<List<Community>?>(null);

  var communitiesComming = Rx<List<Community>?>(null);

  var communitiesGoing = Rx<List<Community>?>(null);

  var communitiesEnd = Rx<List<Community>?>(null);

  Future<void> getCommunities() async {
    communities.value = await _communityRepository.getCommunities();
  }

  Future<Community> getCommunityById(int id) async {
    return await _communityRepository.getCommunityById(id);
  }

  Future<void> getCommunitiesCommingSoon() async {
    communitiesComming.value =
        await _communityRepository.getCommunitiesCommingSoon();
  }

  Future<void> getCommunitiesGoingOn() async {
    communitiesGoing.value = await _communityRepository.getCommunitiesGoingOn();
  }

  Future<void> getCommunitiesEnded() async {
    communitiesEnd.value = await _communityRepository.getCommunitiesEnded();
  }

  Future<void> createCommunityWithImage(
      Map<String, String> communityData, File? image) async {
    await _communityRepository.createCommunityWithImage(communityData, image);
  }
}
