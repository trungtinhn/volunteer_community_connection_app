import 'dart:io';

import 'package:get/get.dart';
import 'package:volunteer_community_connection_app/models/community.dart';
import 'package:volunteer_community_connection_app/repositories/community_repository.dart';

class CommunityController extends GetxController {
  static final CommunityController _instance = CommunityController._internal();
  factory CommunityController() => _instance;
  CommunityController._internal();

  final CommunityRepository _communityRepository = CommunityRepository();

  var community = Rx<Community?>(null);

  var communities = Rx<List<Community>?>(null);

  var communitiesNoPublic = Rx<List<Community>?>(null);

  var communitiesRejected = Rx<List<Community>?>(null);

  var communitiesComming = Rx<List<Community>?>(null);

  var communitiesGoing = Rx<List<Community>?>(null);

  var communitiesEnd = Rx<List<Community>?>(null);

  var myCommunities = Rx<List<Community>?>(null);

  var myCommunitiesNoPublic = Rx<List<Community>?>(null);

  var myCommunitiesRejected = Rx<List<Community>?>(null);

  var isUpdating = false.obs;

  Future<void> getCommunities() async {
    communities.value = await _communityRepository.getCommunities();
  }

  Future<void> getCommunityById(int id) async {
    community.value = await _communityRepository.getCommunityById(id);
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

  Future<void> getCommunitiesNoPublic() async {
    communitiesNoPublic.value =
        await _communityRepository.getCommnitiesNoPublic();
  }

  Future<void> getCommnitiesRejected() async {
    communitiesRejected.value =
        await _communityRepository.getCommnitiesRejected();
  }

  Future<void> getMyCommunities(int idUser) async {
    myCommunities.value =
        await _communityRepository.getCommunitiesByAdminId(idUser);
  }

  Future<void> getMyCommunitiesNoPublic(int idUser) async {
    myCommunitiesNoPublic.value =
        await _communityRepository.getCommunitiesByAdminIdNoPublic(idUser);
  }

  Future<void> getMyCommunitiesRejected(int idUser) async {
    myCommunitiesRejected.value =
        await _communityRepository.getCommunitiesByAdminIdReject(idUser);
  }

  Future<bool> publishCommunity(int id) async {
    isUpdating.value = true;
    try {
      final result = await _communityRepository.publishCommunity(id);
      return result; // Trả về true nếu thành công
    } catch (e) {
      return false; // Trả về false nếu thất bại
    } finally {
      isUpdating.value = false;
    }
  }

  Future<bool> unpublishCommunity(int id) async {
    isUpdating.value = true;
    try {
      final result = await _communityRepository.unpublishCommunity(id);
      return result; // Trả về true nếu thành công
    } catch (e) {
      return false; // Trả về false nếu thất bại
    } finally {
      isUpdating.value = false;
    }
  }

  Future<bool> rejectCommunity(int id) async {
    isUpdating.value = true;
    try {
      final result = await _communityRepository.rejectCommunity(id);
      return result; // Trả về true niflower
    } catch (e) {
      return false; // Trả về false niflower
    } finally {
      isUpdating.value = false;
    }
  }

  Future<bool> deleteCommunity(int id) async {
    isUpdating.value = true;
    try {
      final result = await _communityRepository.deleteCommunity(id);
      return result; // Trả về true niflower
    } catch (e) {
      return false; // Trả về false niflower
    } finally {
      isUpdating.value = false;
    }
  }
}
