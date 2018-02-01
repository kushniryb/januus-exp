//= require components/edge_points

var TicketsShow = (function() {
  const MAP_SELECTOR           = '#map';
  const DEFAULT_ZOOM           = 5;
  const MAP_TYPE_ID            = 'terrain';
  const POLYGON_BORDER_COLOR   = '#FF0000';
  const POLYGON_COLOR          = '#FF0000';
  const POLYGON_STROKE_OPACITY = 0.8;
  const POLYGON_STROKE_WEIGHT  = 2;
  const POLYGON_FILL_OPACITY   = 0.35;

  var $map, locations, map, edgePoints;

  var init = function() {
    assignAttributes();

    if ($map.length > 0) {
      mapLocations();
      setEdgePoints();
      loadMap();
      drawPolygon();
    }
  };

  var assignAttributes = function() {
    $map      = $(MAP_SELECTOR);
    locations = $map.data('locations');
  };

  var setEdgePoints = function() {
    edgePoints = EdgePoints.detect(locations);
  };

  var mapLocations = function() {
    locations = locations.map(function(line) {
      return line.map(function(coordinates) {
        return {
          lat: coordinates[0],
          lng: coordinates[1]
        }
      })
    })
  };

  var loadMap = function() {
    map = new google.maps.Map($map[0], {
      zoom:      DEFAULT_ZOOM,
      center:    viewCenter(),
      mapTypeId: MAP_TYPE_ID
    });
  };

  var viewCenter = function() {
    return {
      lat: locations.length !== 0 ? (edgePoints.minLat + edgePoints.maxLat) / 2 : 0,
      lng: locations.length !== 0 ? (edgePoints.minLng + edgePoints.maxLng) / 2 : 0
    }
  };

  var drawPolygon = function() {
    var polygon = new google.maps.Polygon({
      paths:         locations,
      strokeColor:   POLYGON_BORDER_COLOR,
      strokeOpacity: POLYGON_STROKE_OPACITY,
      strokeWeight:  POLYGON_STROKE_WEIGHT,
      fillColor:     POLYGON_COLOR,
      fillOpacity:   POLYGON_FILL_OPACITY
    });

    polygon.setMap(map);
  };

  return {
    init: init
  }
})();

$(document).on('turbolinks:load', function() {
  TicketsShow.init();
});
