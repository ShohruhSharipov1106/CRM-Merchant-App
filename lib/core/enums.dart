enum HttpMethod { get, post, delete }

enum RequestState { all, neww, draft, considered, confirmed, declined }

extension RequestStateExt on RequestState {
  String get name {
    switch (this) {
      case RequestState.all:
        return '';
      case RequestState.neww:
        return 'New';
      case RequestState.declined:
        return 'Declined';
      case RequestState.confirmed:
        return 'Confirmed';
      case RequestState.considered:
        return 'Considered';
      case RequestState.draft:
        return 'Draft';
    }
  }
}

enum RegionState { region, city, street }

extension RegionStateExt on RegionState {
  String get name {
    switch (this) {
      case RegionState.region:
        return "Region";
      case RegionState.city:
        return "City";
      case RegionState.street:
        return "Street";
    }
  }
}
