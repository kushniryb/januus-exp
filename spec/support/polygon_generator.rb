module PolygonGenerator
  MIN_POINTS     = 1
  MAX_POINTS     = 10
  MIN_COORDINATE = -10.0
  MAX_COORDINATE = 10.0

  class << self
    def random_polygon
      RGeo::Cartesian.factory.parse_wkt(wkt_polygon) ? wkt_polygon : default_polygon
    end

    private

    def wkt_polygon
      "POLYGON ((#{points.join(', ')}))"
    end

    def points
      [
        point(MIN_COORDINATE, MIN_COORDINATE),
        *random_points,
        point(MAX_COORDINATE, MIN_COORDINATE)
      ]
    end

    def random_points
      rand(MIN_POINTS..MAX_POINTS).times.to_a.map(&method(:point))
    end

    def point(x, y = random_coordinate)
      "#{x} #{y}"
    end

    def random_coordinate
      rand(MIN_COORDINATE..MAX_COORDINATE).round(5)
    end

    def default_polygon
      'POLYGON ((25.774 -80.190, 18.466 -66.118, 32.321 -64.757, 25.774 -80.190))'
    end
  end
end
