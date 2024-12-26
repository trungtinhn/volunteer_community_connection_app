import 'package:get/get.dart';
import 'package:volunteer_community_connection_app/repositories/donation_repository.dart';

import '../models/donation.dart';

class DonationController extends GetxController {
  static final DonationController _instance = DonationController._internal();
  factory DonationController() => _instance;
  DonationController._internal();

  final DonationRepository _donationRepository = DonationRepository();

  RxList<Donation> loadedDonations = <Donation>[].obs;

  Future<List<Donation>> getContributors(int communityId) async {
    return await _donationRepository.getContributors(communityId);
  }
}
