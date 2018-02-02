var EdgePoints = (function() {
  const DEFAULT_MIN_COORDINATE = 9999999;
  const DEFAULT_MAX_COORDINATE = -9999999;
  const MAX_VALUE_TYPE         = 'max';
  const MIN_VALUE_TYPE         = 'min';

  var edgePoints;

  var detect = function(coordinates) {
    reset();
    find(coordinates);

    return edgePoints;
  };

  var reset = function() {
    edgePoints = {
      maxLat: DEFAULT_MAX_COORDINATE,
      maxLng: DEFAULT_MAX_COORDINATE,
      minLat: DEFAULT_MIN_COORDINATE,
      minLng: DEFAULT_MIN_COORDINATE
    };
  };

  var find = function(coordinates) {
    coordinates.forEach(function(line) {
      var latValues = line.map(function(point) { return point.lat }),
          lngValues = line.map(function(point) { return point.lng }),
          maxLat    = Math.max(...latValues),
          maxLng    = Math.max(...lngValues),
          minLat    = Math.min(...latValues),
          minLng    = Math.min(...lngValues);

      replaceEdgePoint('maxLat', MAX_VALUE_TYPE, maxLat);
      replaceEdgePoint('maxLng', MAX_VALUE_TYPE, maxLng);
      replaceEdgePoint('minLat', MIN_VALUE_TYPE, minLat);
      replaceEdgePoint('minLng', MIN_VALUE_TYPE, minLng);
    })
  };

  var replaceEdgePoint = function(key, valueType, value) {
    var comparison = valueType === 'max' ? edgePoints[key] < value : edgePoints[key] > value;

    if (comparison) {
      edgePoints[key] = value;
    }
  };

  return {
    detect: detect
  }
})();
