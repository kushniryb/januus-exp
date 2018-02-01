module Kaminari
  module Helpers
    class Paginator
      def render(&block)
        instance_eval(&block) unless @options[:total_pages].to_i.zero?

        @output_buffer
      end
    end
  end
end
