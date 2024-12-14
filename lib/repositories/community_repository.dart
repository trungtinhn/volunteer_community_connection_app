import 'package:volunteer_community_connection_app/models/community.dart';
import 'package:volunteer_community_connection_app/services/api_service.dart';

class CommunityRepository {
  final ApiService _apiService = ApiService();

  Future<List<Community>> getCommunities() async {
    final data = await _apiService.getAll('/Community');
    return List<Community>.from(data.map((e) => Community.fromJson(e)));
  }

  Future<Community> getCommunityById(int id) async {
    final data = await _apiService.get('/Community/$id');
    return Community.fromJson(data);
  }

  Future<List<Community>> getCommunitiesCommingSoon() async {
    final data = await _apiService.getAll('/Community/get-upcoming');
    return List<Community>.from(data.map((e) => Community.fromJson(e)));
  }

  Future<List<Community>> getCommunitiesGoingOn() async {
    final data = await _apiService.getAll('/Community/get-ongoing');
    return List<Community>.from(data.map((e) => Community.fromJson(e)));
  }

  Future<List<Community>> getCommunitiesEnded() async {
    final data = await _apiService.getAll('/Community/get-completed');
    return List<Community>.from(data.map((e) => Community.fromJson(e)));
  }
}
