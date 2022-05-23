import 'package:graphql/client.dart';

class GraphQLClientHelper {

  late String websocketEndPoint;
  late WebSocketLink _wsLink;
  late GraphQLClient _client;
  late HttpLink _httpLink;
  
  GraphQLClientHelper(){
    initGraphQLClient();
  }
  GraphQLClient get client => _client;

  void initGraphQLClient() {
  
    websocketEndPoint = "ws://192.168.0.106:4000/graphql";
    _httpLink = HttpLink(
      'http://192.168.0.106:4000/graphql',
    );
    _wsLink = WebSocketLink(
      websocketEndPoint,
      config: SocketClientConfig(
      autoReconnect: true,
      inactivityTimeout: Duration(seconds: 15),
      delayBetweenReconnectionAttempts: Duration(seconds: 10)
      ),
      subProtocol: SocketSubProtocol.graphqlTransportWs
    );
    
    Link _link = Link.split((request) => request.isSubscription, _wsLink, _httpLink);

    final policies = Policies(
      fetch: FetchPolicy.networkOnly,
    );

    _client = GraphQLClient(
      cache: GraphQLCache(),
      link: _link,
      defaultPolicies: DefaultPolicies(
        watchQuery: policies,
        query: policies,
        mutate: policies,
      ),
    );
    
  }
}
