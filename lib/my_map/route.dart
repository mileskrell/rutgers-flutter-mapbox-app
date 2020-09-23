// To parse this JSON data, do
//
//     final routes = routesFromJson(jsonString);

import 'dart:convert';

class Route {
  Route({
    this.description,
    this.shortName,
    this.routeId,
    this.color,
    this.isActive,
    this.agencyId,
    this.textColor,
    this.longName,
    this.url,
    this.isHidden,
    this.type,
    this.stops,
    this.vehicles,
  });

  final String description;
  final String shortName;
  final String routeId;
  final String color;
  final bool isActive;
  final int agencyId;
  final String textColor;
  final String longName;
  final String url;
  final bool isHidden;
  final String type;
  final List<Stop> stops;
  final List<Vehicle> vehicles;

  factory Route.fromRawJson(String str) =>
      Route.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  factory Route.fromJson(Map<String, dynamic> json) => Route(
        description: json["description"] as String,
        shortName: json["short_name"] as String,
        routeId: json["route_id"] as String,
        color: json["color"] as String,
        isActive: json["is_active"] as bool,
        agencyId: json["agency_id"] as int,
        textColor: json["text_color"] as String,
        longName: json["long_name"] as String,
        url: json["url"] as String,
        isHidden: json["is_hidden"] as bool,
        type: json["type"] as String,
        stops: List<Stop>.from((json["stops"] as Iterable<dynamic>)
            .map<Stop>((x) => Stop.fromJson(x))),
        vehicles: List<Vehicle>.from(
            (json["vehicles"] as Iterable<Map<String, dynamic>>)
                .map<Vehicle>((Map<String, dynamic> x) => Vehicle.fromJson(x))),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "description": description,
        "short_name": shortName,
        "route_id": routeId,
        "color": color,
        "is_active": isActive,
        "agency_id": agencyId,
        "text_color": textColor,
        "long_name": longName,
        "url": url,
        "is_hidden": isHidden,
        "type": type,
        "stops": List<dynamic>.from(
            stops.map<Map<String, dynamic>>((x) => x.toJson())),
        "vehicles": List<dynamic>.from(
            vehicles.map<Map<String, dynamic>>((x) => x.toJson())),
      };
}

class Stop {
  Stop({
    this.code,
    this.description,
    this.url,
    this.parentStationId,
    this.agencyIds,
    this.stationId,
    this.locationType,
    this.location,
    this.stopId,
    this.routes,
    this.name,
    this.arrivals,
  });

  final String code;
  final String description;
  final String url;
  final String parentStationId;
  final List<String> agencyIds;
  final dynamic stationId;
  final String locationType;
  final Location location;
  final String stopId;
  final List<String> routes;
  final String name;
  final List<Arrival> arrivals;

  factory Stop.fromRawJson(String str) =>
      Stop.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  factory Stop.fromJson(Map<String, dynamic> json) {
    print("");
    return Stop(
        code: json["code"] as String,
        description: json["description"] as String,
        url: json["url"] as String,
        parentStationId: json["parent_station_id"] as String,
        agencyIds: json["agency_ids"] as List<dynamic>,
        stationId: json["station_id"],
        locationType: json["location_type"] as String,
        location: Location.fromJson(json["location"] as Map<String, dynamic>),
        stopId: json["stop_id"] as String,
        routes: List<String>.from(json["routes"].map((x) => x)),
        name: json["name"] as String,
        arrivals: json["arrivals"] == null
            ? null
            : List<Arrival>.from(
                json["arrivals"].map((x) => Arrival.fromJson(x))),
      );
  }

  Map<String, dynamic> toJson() => {
        "code": code,
        "description": description,
        "url": url,
        "parent_station_id": parentStationId,
        "agency_ids": List<dynamic>.from(agencyIds.map((x) => x)),
        "station_id": stationId,
        "location_type": locationType,
        "location": location.toJson(),
        "stop_id": stopId,
        "routes": List<dynamic>.from(routes.map((x) => x)),
        "name": name,
        "arrivals": arrivals == null
            ? null
            : List<dynamic>.from(arrivals.map((x) => x.toJson())),
      };
}

class Arrival {
  Arrival({
    this.routeId,
    this.vehicleId,
    this.arrivalAt,
    this.type,
  });

  final String routeId;
  final String vehicleId;
  final DateTime arrivalAt;
  final String type;

  factory Arrival.fromRawJson(String str) => Arrival.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Arrival.fromJson(Map<String, dynamic> json) => Arrival(
        routeId: json["route_id"],
        vehicleId: json["vehicle_id"],
        arrivalAt: DateTime.parse(json["arrival_at"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "route_id": routeId,
        "vehicle_id": vehicleId,
        "arrival_at": arrivalAt.toIso8601String(),
        "type": type,
      };
}

class Location {
  Location({
    this.lat,
    this.lng,
  });

  final double lat;
  final double lng;

  factory Location.fromRawJson(String str) =>
      Location.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}

class Vehicle {
  Vehicle({
    this.standingCapacity,
    this.description,
    this.seatingCapacity,
    this.lastUpdatedOn,
    this.callName,
    this.speed,
    this.vehicleId,
    this.segmentId,
    this.passengerLoad,
    this.routeId,
    this.arrivalEstimates,
    this.trackingStatus,
    this.location,
    this.heading,
  });

  final dynamic standingCapacity;
  final dynamic description;
  final dynamic seatingCapacity;
  final DateTime lastUpdatedOn;
  final String callName;
  final double speed;
  final String vehicleId;
  final String segmentId;
  final double passengerLoad;
  final String routeId;
  final List<ArrivalEstimate> arrivalEstimates;
  final String trackingStatus;
  final Location location;
  final int heading;

  factory Vehicle.fromRawJson(String str) => Vehicle.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        standingCapacity: json["standing_capacity"],
        description: json["description"],
        seatingCapacity: json["seating_capacity"],
        lastUpdatedOn: DateTime.parse(json["last_updated_on"]),
        callName: json["call_name"],
        speed: json["speed"].toDouble(),
        vehicleId: json["vehicle_id"],
        segmentId: json["segment_id"] == null ? null : json["segment_id"],
        passengerLoad: json["passenger_load"].toDouble(),
        routeId: json["route_id"],
        arrivalEstimates: List<ArrivalEstimate>.from(
            json["arrival_estimates"].map((x) => ArrivalEstimate.fromJson(x))),
        trackingStatus: json["tracking_status"],
        location: Location.fromJson(json["location"]),
        heading: json["heading"],
      );

  Map<String, dynamic> toJson() => {
        "standing_capacity": standingCapacity,
        "description": description,
        "seating_capacity": seatingCapacity,
        "last_updated_on": lastUpdatedOn.toIso8601String(),
        "call_name": callName,
        "speed": speed,
        "vehicle_id": vehicleId,
        "segment_id": segmentId == null ? null : segmentId,
        "passenger_load": passengerLoad,
        "route_id": routeId,
        "arrival_estimates":
            List<dynamic>.from(arrivalEstimates.map((x) => x.toJson())),
        "tracking_status": trackingStatus,
        "location": location.toJson(),
        "heading": heading,
      };
}

class ArrivalEstimate {
  ArrivalEstimate({
    this.routeId,
    this.arrivalAt,
    this.stopId,
    this.name,
  });

  final String routeId;
  final DateTime arrivalAt;
  final String stopId;
  final String name;

  factory ArrivalEstimate.fromRawJson(String str) =>
      ArrivalEstimate.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ArrivalEstimate.fromJson(Map<String, dynamic> json) =>
      ArrivalEstimate(
        routeId: json["route_id"],
        arrivalAt: DateTime.parse(json["arrival_at"]),
        stopId: json["stop_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "route_id": routeId,
        "arrival_at": arrivalAt.toIso8601String(),
        "stop_id": stopId,
        "name": name,
      };
}
