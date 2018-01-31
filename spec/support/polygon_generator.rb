module PolygonGenerator
  MIN_POINTS     = 1
  MAX_POINTS     = 10
  MIN_COORDINATE = -10.0
  MAX_COORDINATE = 10.0

  class << self
    def random_polygon
      loop { return wkt_polygon if RGeo::Cartesian.factory.parse_wkt(wkt_polygon) }
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
  end
end
