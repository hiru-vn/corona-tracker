import 'dart:async';
import 'package:graphql/client.dart';
import 'package:corona_tracker/base_config/src/spref/spref.dart';

class BaseServices {
  String _module;
  String _name;
  String _fragmentDefault;

  BaseServices({String module, String fragment}) {
    _module = module;
    _name = capitalizeModule();
    _fragmentDefault = parseFragment(fragment);
  }

  capitalizeModule() {
    return '${_module[0].toUpperCase()}${_module.substring(1)}';
  }

  showModule() {
    print('module $_module');
    print('Fragment $_fragmentDefault');
    print('Name $_name');
  }

  parseFragment(String fragment) {
    final a = fragment.split('\n');
    var resData = [];
    for (var item in a) {
      final b = item.split(':');
      resData = [...resData, b[0].replaceAll(' ', '')];
    }
    return resData.join(' ');
  }

  getList(
      {int limit,
      int skip,
      String sort = '{createdAt : -1}',
      String filter,
      String search,
      bool summary = true}) async {
    final String listNode =
        'query GetAll$_name{getAll$_name(q:{limit: $limit, skip: $skip, sort: $sort, filter: $filter, search: $search, summary: $summary }){data{$_fragmentDefault} pagination{total } }}';

    final QueryOptions options = QueryOptions(
      documentNode: gql(listNode),
    );

    final QueryResult result = await GraphQL.instance.client.query(options);

    if (result.hasException) {
      print('getAll$_name ${result.exception.toString()}');
      throw (Exception(result.exception.toString()));
    }

    print("getAll$_name : ${result.data['getAll$_name']}");
    return result.data['getAll$_name'];
  }

  getItem(String id, {String fragment}) async {
    var fragmentGetItem;
    if (fragment == null) {
      fragmentGetItem = _fragmentDefault;
    } else {
      fragmentGetItem = parseFragment(fragment);
    }
    final String listNode =
        'query getItem{get$_name(_id: "$id"){ $fragmentGetItem }}';

    final QueryOptions options = QueryOptions(
      documentNode: gql(listNode),
    );

    final QueryResult result = await GraphQL.instance.client.query(options);

    if (result.hasException) {
      print('getItem ${result.exception.toString()}');
      throw (Exception(result.exception.toString()));
    }
    print("get$_name : ${result.data['get$_name']}");
    return result.data['get$_name'];
  }

  add(String data) async {
    final String addNode = 'mutation { create$_name(data: {$data}) { _id } }';
    print('addNode $addNode');
    final MutationOptions optionsAdd =
        MutationOptions(documentNode: gql(addNode));

    final QueryResult result = await GraphQL.instance.client.mutate(optionsAdd);
    if (result.hasException) {
      print('add$_name ${result.exception.toString()}');
      throw (Exception(result.exception.toString()));
    }
    print(result.data);
    GraphQL.instance.client.cache.reset();
    return result.data['create$_name']['_id'];
  }

  delete(String id) async {
    final String deleteNode = 'mutation { delete$_name(_id: "$id") }';
    final MutationOptions optionsDelete =
        MutationOptions(documentNode: gql(deleteNode));

    final QueryResult result =
        await GraphQL.instance.client.mutate(optionsDelete);
    if (result.hasException) {
      print('delete$_name ${result.exception.toString()}');
      throw (Exception(result.exception.toString()));
    }

    GraphQL.instance.client.cache.reset();
    print('delete$_name result.data');
    return result.data;
  }

  update(String id, String data) async {
    final String deleteNode =
        'mutation { update$_name(_id: "$id", data: {$data}) {_id} }';
    final MutationOptions optionsDelete =
        MutationOptions(documentNode: gql(deleteNode));

    final QueryResult result =
        await GraphQL.instance.client.mutate(optionsDelete);
    if (result.hasException) {
      print('delete$_name ${result.exception.toString()}');
      throw (Exception(result.exception.toString()));
    }
    if (result.data['update$_name'] == null) {
      throw (Exception('Id does not exist'));
    }
    GraphQL.instance.client.cache.reset();
    print('update ${result.data['update$_name']['_id']}');
    return result.data['update$_name']['_id'];
  }

  mutate(String name, String data, {String fragment}) async {
    String mutateNode;
    if (fragment == null)
      mutateNode = 'mutation { $name($data) }';
    else
      mutateNode = 'mutation { $name($data) { $fragment } }';
    print('MutateNode $mutateNode');

    final MutationOptions options =
        MutationOptions(documentNode: gql(mutateNode));

    final QueryResult result = await GraphQL.instance.client.mutate(options);
    if (result.hasException) {
      print('name ${result.exception.toString()}');
      throw (Exception(result.exception.toString()));
    }
    print(result.data);
    GraphQL.instance.client.cache.reset();
    return result.data;
  }
}

class GraphQL {
  static final HttpLink _httpLink = HttpLink(
    uri: 'https://booking-hospital.mcom.app/graphql',
  );

  static final AuthLink _authLink = AuthLink(getToken: () async {
    final token = await SPref.instance.get('x-token');
    return token;
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
