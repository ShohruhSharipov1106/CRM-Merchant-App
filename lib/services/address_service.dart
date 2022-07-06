import 'package:crm_merchant/models/marketplace/region_model.dart';
import 'package:crm_merchant/models/marketplace/region_model.dart' as rg;

import '../constants/exports.dart';

class AddressRegionService {
  static const String _api = "Region/Get";
  static Future<RegionModel> getRequest(String? parentId) async {
    Map<String, String>? param;

    param = {"Type": "Region"};

    var result = await ApiData().getData(_api, HttpMethod.get, param, false);
    if (result.isSuccess) {
      var region = RegionModel.fromJson(jsonDecode(result.result!));
      if ((region.value?.length ?? 0) > 0) {
        var datas = region.value!.groupBy((p0) => p0.id);
        List<rg.Value> _regions = [];
        for (var r in datas.keys) {
          if (r != null && datas[r] != null) {
            _regions.add(datas[r]!.first);
          }
        }

        var _datas = _regions.groupBy((p0) => p0.name);
        List<rg.Value> _regions_ = [];

        for (var r in _datas.keys) {
          if (r != null && _datas[r] != null) {
            _regions_.add(_datas[r]!.first);
          }
        }

        region.value = _regions_;
      }

      return region;
    } else {
      throw Exception(result.errorMessage);
    }
  }
}

class AddressCityService {
  static const String _api = "Region/Get";
  static Future<RegionModel> getRequest(String? parentId) async {
    Map<String, String>? param;
    param = {"Type": "City", "ParentId": parentId!};

    var result = await ApiData().getData(_api, HttpMethod.get, param, false);
    if (result.isSuccess) {
      var region = RegionModel.fromJson(jsonDecode(result.result!));
      if ((region.value?.length ?? 0) > 0) {
        var datas = region.value!.groupBy((p0) => p0.id);
        List<rg.Value> _regions = [];
        for (var r in datas.keys) {
          if (r != null && datas[r] != null) {
            _regions.add(datas[r]!.first);
          }
        }

        var _datas = _regions.groupBy((p0) => p0.name);
        List<rg.Value> _regions_ = [];

        for (var r in _datas.keys) {
          if (r != null && _datas[r] != null) {
            _regions_.add(_datas[r]!.first);
          }
        }

        region.value = _regions_;
      }

      return region;
    } else {
      throw Exception(result.errorMessage);
    }
  }
}

class AddressStreetService {
  static const String _api = "Region/Get";
  static Future<RegionModel> getRequest(String? parentId) async {
    Map<String, String>? param;
    param = {"Type": "Street", "ParentId": parentId!};

    var result = await ApiData().getData(_api, HttpMethod.get, param, false);
    if (result.isSuccess) {
      var region = RegionModel.fromJson(jsonDecode(result.result!));
      if ((region.value?.length ?? 0) > 0) {
        var datas = region.value!.groupBy((p0) => p0.id);
        List<rg.Value> _regions = [];
        for (var r in datas.keys) {
          if (r != null && datas[r] != null) {
            _regions.add(datas[r]!.first);
          }
        }

        var _datas = _regions.groupBy((p0) => p0.name);
        List<rg.Value> _regions_ = [];

        for (var r in _datas.keys) {
          if (r != null && _datas[r] != null) {
            _regions_.add(_datas[r]!.first);
          }
        }

        region.value = _regions_;
      }

      return region;
    } else {
      throw Exception(result.errorMessage);
    }
  }
}

extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
      <K, List<E>>{},
      (Map<K, List<E>> map, E element) =>
          map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));
}
