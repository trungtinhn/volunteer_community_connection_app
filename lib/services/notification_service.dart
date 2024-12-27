import 'package:shared_preferences/shared_preferences.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:volunteer_community_connection_app/services/api_service.dart';

class NotificationService {
  late HubConnection hubConnection;

  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> initConnection(int userId) async {
    final SharedPreferences prefs = await _prefs;

    String? token = prefs.getString('token');

    hubConnection = HubConnectionBuilder()
        .withUrl('${ApiService.API_URL}/notificationHub',
            options: HttpConnectionOptions(
              accessTokenFactory: () async => token!,
            ))
        .build();

    await hubConnection.start();
    print('Connection started');

    hubConnection.on('ReceiveNotification', (arguments) {
      print('Notification received: ');
    });
  }
}
