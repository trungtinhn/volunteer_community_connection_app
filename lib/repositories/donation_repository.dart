import 'package:volunteer_community_connection_app/models/donation.dart';

import '../services/api_service.dart';

class DonationRepository {
  final ApiService _apiService = ApiService();

  Future<List<Donation>> getContributors(int communityId) async {
    final data =
        await _apiService.getAll('/api/Donation/get-contributors/$communityId');
    return List<Donation>.from(data.map((e) => Donation.fromJson(e)));
  }

  Future<bool> addDonation(Map<String, String> donation) async {
    try {
      await _apiService.post('/api/Donation', donation);
      return true;
    } catch (e) {
      return false;
    }
  }
}
