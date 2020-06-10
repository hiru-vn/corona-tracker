import 'package:graphql/client.dart';
import 'package:corona_tracker/base_config/src/base/graphql.dart';

class BaseService {
  String _module;
  String _name;
  String _fragmentDefault;

  BaseService({String module, String fragment}) {
    print(module);
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
      String sort,
      String filter,
      String search,
      bool summary = true}) async {
    final String listNode =
        'query GetAll$_name{getAll$_name(q:{limit: $limit, skip: $skip, sort: $sort, filter: $filter, search: $search, summary: $summary }){data{$_fragmentDefault} pagination{total next prev } }}';
    print("Query: " + listNode);

    final QueryOptions options = QueryOptions(
      documentNode: gql(listNode),
    );

    final QueryResult result = await GraphQL.instance.client.query(options);

    if (result.hasException) {
      print('getAll$_name ${result.exception.toString()}');
      throw (Exception(result.exception.toString()));
    }
    GraphQL.instance.client.cache.reset();
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

    print("Query: " + listNode);
    final QueryOptions options = QueryOptions(
      documentNode: gql(listNode),
    );

    final QueryResult result = await GraphQL.instance.client.query(options);

    if (result.hasException) {
      print('getItem ${result.exception.toString()}');
      throw (Exception(result.exception.toString()));
    }
    print("get$_name : ${result.data['get$_name']}");
    GraphQL.instance.client.cache.reset();
    return result.data['get$_name'];
  }

  getInfo({String fragment}) async {
    var fragmentGetItem;
    if (fragment == null) {
      fragmentGetItem = _fragmentDefault;
    } else {
      fragmentGetItem = parseFragment(fragment);
    }
    final String listNode =
        'query getItem{get${_name}Info{ $fragmentGetItem }}';

    print("Query: " + listNode);
    final QueryOptions options = QueryOptions(
      documentNode: gql(listNode),
    );

    final QueryResult result = await GraphQL.instance.client.query(options);

    if (result.hasException) {
      print('getItem ${result.exception.toString()}');
      throw (Exception(result.exception.toString()));
    }
    print("get$_name : ${result.data['get${_name}Info']}");
    GraphQL.instance.client.cache.reset();
    return result.data['get${_name}Info'];
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

  update({String id, String data, String fragment}) async {
    var fragmentGetItem;
    if (fragment == null) {
      fragmentGetItem = _fragmentDefault;
    } else {
      fragmentGetItem = parseFragment(fragment);
    }
    final String deleteNode =
        'mutation { update$_name(_id: "$id", data: {$data}) {$fragmentGetItem} }';
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
    return result.data['update$_name'];
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

class UserService extends BaseService {
  UserService() : super(module: 'doctor', fragment: '''_id: ID
  name: String
  code: String''');
}

class SlotSrv extends BaseService {
  SlotSrv() : super(module: 'slot', fragment: '''
  _id: ID
  createdAt: DateTime
  updatedAt: DateTime
  packageId: String
  branchId: String
  roomId: String
  timeFrameId: String
  doctorId: String
  doctorEventId: String
  patientId: String
  userId: String
  name: String
  examDate: String
  examTime: DateTime
  reason: String
  phone: String
  amount: Int
  refCode: String
  checkinAt: DateTime
  note: String
  paymentMethod: String
  paymentStatus: String
  transId: String
  paidAt: String
  refundedAt: DateTime
  canceledAt: DateTime
  status: String
  package{_id name}: Package
  branch{_id}: Branch
  room{_id name}: Room
  doctor{_id d}: Doctor
  doctorEvent: DoctorEvent
  patient: Patient
  ''');
}
