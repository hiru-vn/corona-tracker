import 'dart:async';

import 'package:graphql/client.dart';

import '../../base_config.dart';

class GraphQL {
  static final HttpLink _httpLink = HttpLink(
    uri: 'https://booking-hospital.mcom.app/graphql',
  );

  static final AuthLink _authLink = AuthLink(getToken: () async {
    final token = await SPref.instance.get(CustomString.KEY_TOKEN);
    return "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJwYXlsb2FkIjp7InVzZXJJZCI6IjVlNjM3YmU2ZDUzMWZlNzY4Y2Y4NWZjNSIsInVzZXIiOnsidWlkIjoiYWRtaW4iLCJ1c2VybmFtZSI6ImFkbWluIiwiZnVsbE5hbWUiOiJBZG1pbiIsInJvbGUiOiJhZG1pbiIsInBlcm1pc3Npb25zIjpbXSwiX2lkIjoiNWU2MzdiZTZkNTMxZmU3NjhjZjg1ZmM1IiwidXBkYXRlZEF0IjoiMjAyMC0wMy0wN1QxMDo0ODowNy4zMjVaIiwiY3JlYXRlZEF0IjoiMjAyMC0wMy0wN1QxMDo0ODowNy4zMjVaIn0sInVhIjp7InVhIjoiTW96aWxsYS81LjAgKFgxMTsgTGludXggeDg2XzY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvODEuMC40MDQ0LjEzOCBTYWZhcmkvNTM3LjM2IiwiYnJvd3NlciI6eyJuYW1lIjoiQ2hyb21lIiwidmVyc2lvbiI6IjgxLjAuNDA0NC4xMzgiLCJtYWpvciI6IjgxIn0sImVuZ2luZSI6eyJuYW1lIjoiQmxpbmsiLCJ2ZXJzaW9uIjoiODEuMC40MDQ0LjEzOCJ9LCJvcyI6eyJuYW1lIjoiTGludXgiLCJ2ZXJzaW9uIjoieDg2XzY0In0sImRldmljZSI6e30sImNwdSI6eyJhcmNoaXRlY3R1cmUiOiJhbWQ2NCJ9fX0sImV4cCI6IjIwMjAtMDYtMTFUMDY6NTY6MDEuMTI1WiJ9.N3RfjI04J4cnentx0zhp2Lso-xrYEjvC8AXSzeJ69Dw";
  });

  static final Link _link = _authLink.concat(_httpLink);
  static GraphQLClient _client = GraphQLClient(
    cache: InMemoryCache(),
    link: _link,
  );
  GraphQL._internal();
  static final GraphQL instance = GraphQL._internal();

  GraphQLClient get client => _client;
}

//Set x-token to header

typedef GetToken = FutureOr<String> Function();

class AuthLink extends Link {
  AuthLink({
    this.getToken,
  }) : super(
          request: (Operation operation, [NextLink forward]) {
            StreamController<FetchResult> controller;

            Future<void> onListen() async {
              try {
                final String token = await getToken();
                operation.setContext(<String, Map<String, String>>{
                  'headers': <String, String>{'x-token': token}
                });
              } catch (error) {
                controller.addError(error);
              }
              await controller.addStream(forward(operation));
              await controller.close();
            }

            controller = StreamController<FetchResult>(onListen: onListen);
            return controller.stream;
          },
        );

  GetToken getToken;
}
