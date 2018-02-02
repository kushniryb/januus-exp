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

  var $map, coordinates, map, edgePoints;

  var init = function() {
    assignAttributes();

    if ($map.length > 0) {
      mapCoordinates();
      setEdgePoints();
      loadMap();
      drawPolygon();
    }
  };

  var assignAttributes = function() {
    $map        = $(MAP_SELECTOR);
    coordinates = $map.data('coordinates');
  };

  var setEdgePoints = function() {
    edgePoints = EdgePoints.detect(coordinates);
  };

  var mapCoordinates = function() {
    coordinates = coordinates.map(function(line) {
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
      lat: coordinates.length !== 0 ? (edgePoints.minLat + edgePoints.maxLat) / 2 : 0,
      lng: coordinates.length !== 0 ? (edgePoints.minLng + edgePoints.maxLng) / 2 : 0
    }
  };

  var drawPolygon = function() {
    var polygon = new google.maps.Polygon({
      paths:         coordinates,
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
