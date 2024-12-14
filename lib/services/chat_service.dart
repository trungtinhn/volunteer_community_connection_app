import 'package:shared_preferences/shared_preferences.dart';
import 'package:volunteer_community_connection_app/services/api_service.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

class ChatService {
  late HubConnection hubConnection;

  static final ChatService _instance = ChatService._internal();
  factory ChatService() => _instance;
  ChatService._internal();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> initConnection(int userId) async {
    final SharedPreferences prefs = await _prefs;

    String? token = prefs.getString('token');

    hubConnection = HubConnectionBuilder()
        .withUrl('${ApiService.API_URL}/chatHub',
            options: HttpConnectionOptions(
              accessTokenFactory: () async => token!,
            ))
        .build();

    await hubConnection.start();
    print('Connection started');

    hubConnection.on('ReceiveMessage', (arguments) {
      print(
          'Message received: SenderId=${arguments?[0]}, Content=${arguments?[1]}, SentAt=${arguments?[2]}');
    });
  }

  Future<void> sendMessage(int senderId, int receiverId, String content) async {
    await hubConnection
        .invoke('SendMessage', args: [senderId, receiverId, content]);
  }
}
