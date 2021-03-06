module Rubyplot
  class ScatterGeometry < Rubyplot::ArtistGeometry
    attr_accessor :baseline_x_color
    attr_accessor :baseline_y_color
    attr_accessor :baseline_x_value
    attr_accessor :baseline_y_value
    attr_accessor :circle_radius
    attr_accessor :disable_significant_rounding_x_axis
    attr_accessor :enable_vertical_line_markers
    attr_accessor :marker_x_count
    attr_accessor :maximum_x_value
    attr_accessor :minimum_x_value
    attr_accessor :stroke_width
    attr_accessor :use_vertical_x_labels
    attr_accessor :x_axis_label_format
    attr_accessor :x_label_margin
    attr_accessor :y_axis_label_format

    def initialize(*)
      super
      @baseline_x_color = @baseline_y_color = 'red'
      @baseline_x_value = @baseline_y_value = nil
      @circle_radius = nil

      @disable_significant_rounding_x_axis = false
      @enable_vertical_line_markers = false

      @marker_x_count = nil
      @maximum_x_value = @minimum_x_value = nil

      @stroke_width = nil
      @use_vertical_x_labels = false
      @x_axis_label_format = nil
      @x_label_margin = nil
      @y_axis_label_format = nil
    end
  end
end
