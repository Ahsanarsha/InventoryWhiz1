import 'package:card_club/resources/repoitory.dart';

class GroupBloc {
  final _repository = Repository();

  var _createGroupRequest;
  var _updateGroupAPI;
  var _getAllGroupsRequest;
  var _getSingleGroupDetailRequest;
  var _getNotAddedContactsRequest;
  var _delGroupsRequest;

  dynamic get createGroupModel => _createGroupRequest;

  dynamic get updateGroupModel => _updateGroupAPI;

  dynamic get getAllGroupsModel => _getAllGroupsRequest;

  dynamic get getNotAddedContactsModel => _getNotAddedContactsRequest;

  dynamic get getSingleGroupDetailModel => _getSingleGroupDetailRequest;

  dynamic get delGroupsModel => _delGroupsRequest;

  createGroupAPI(
    List<String> contacts,
    var groupsName,
    String imagePath,
  ) async {
    dynamic createGroupModel = await _repository.createGroupAPI(
      contacts,
      groupsName,
      imagePath,
    );
    _createGroupRequest = createGroupModel;
  }

  updateGroupAPI(int groupID, List<String> contacts, var groupsName,
      String imagePath) async {
    dynamic updateGroupModel = await _repository.updateGroupAPI(
        groupID, contacts, groupsName, imagePath);
    _updateGroupAPI = updateGroupModel;
  }

  getAllGroupsRequest() async {
    dynamic getAllGroupsModel = await _repository.getAllGroupRequest();
    _getAllGroupsRequest = getAllGroupsModel;
  }

  getNotAddedContactsAPI(String endPoint,int id) async {
    dynamic getNotAddedContactsModel =
        await _repository.getNotAddedContactsAPI(endPoint,id);
    _getNotAddedContactsRequest = getNotAddedContactsModel;
  }

  getSingleGroupDetailAPI(int groupID) async {
    dynamic getSingleGroupDetailModel =
        await _repository.getSingleGroupDetailAPI(groupID);
    _getSingleGroupDetailRequest = getSingleGroupDetailModel;
  }

  delGroupsRequest(List<String> listIds) async {
    dynamic delGroupsModel = await _repository.delGroupsRequest(listIds);
    _delGroupsRequest = delGroupsModel;
  }

  dispose() {
    _createGroupRequest.close();
    _updateGroupAPI.close();
    _getAllGroupsRequest.close();
    _getSingleGroupDetailRequest.close();
    _getNotAddedContactsRequest.close();
    _delGroupsRequest.close();
  }
}

final groupBloc = GroupBloc();
