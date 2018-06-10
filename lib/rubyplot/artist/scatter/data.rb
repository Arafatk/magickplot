class Rubyplot::Scatter < Rubyplot::Artist
  # The first parameter is the name of the dataset.  The next two are the
  # x and y axis data points contain in their own array in that respective
  # order.  The final parameter is the color.
  #
  # Can be called multiple times with different datasets for a multi-valued
  # graph.
  #
  # If the color argument is nil, the next color from the default theme will
  # be used.
  #
  # ==== Parameters
  # name:: String or Symbol containing the name of the dataset.
  # x_data_points:: An Array of of x-axis data points.
  # y_data_points:: An Array of of y-axis data points.
  # color:: The hex string for the color of the dataset.  Defaults to nil.
  #
  # ==== Exceptions
  # Data points contain nil values::
  #   This error will get raised if either the x or y axis data points array
  #   contains a <tt>nil</tt> value.  The graph will not make an assumption
  #   as how to graph <tt>nil</tt>
  # x_data_points is empty::
  #   This error is raised when the array for the x-axis points are empty
  # y_data_points is empty::
  #   This error is raised when the array for the y-axis points are empty
  # x_data_points.length != y_data_points.length::
  #   Error means that the x and y axis point arrays do not match in length
  #
  # ==== Examples
  # g = Rubyplot::Scatter.new
  # g.data(:apples, [1,2,3], [3,2,1])
  # g.data('oranges', [1,1,1], [2,3,4])
  # g.data('bitter_melon', [3,5,6], [6,7,8], '#000000')
  #
  def data(name, x_data_points = [], y_data_points = [], _color = nil)
    raise ArgumentError, 'Data Points contain nil Value!' if x_data_points.include?(nil) || y_data_points.include?(nil)
    raise ArgumentError, 'x_data_points is empty!' if x_data_points.empty?
    raise ArgumentError, 'y_data_points is empty!' if y_data_points.empty?
    raise ArgumentError, 'x_data_points.length != y_data_points.length!' if x_data_points.length != y_data_points.length

    # Call the existing data routine for the y axis data
    super(name, y_data_points)

    # append the x data to the last entry that was just added in the @data member
    last_elem = @data.length - 1
    @data[last_elem] << x_data_points

    if @maximum_x_value.nil? && @minimum_x_value.nil?
      @maximum_x_value = @minimum_x_value = x_data_points.first
    end

    @maximum_x_value = x_data_points.max > @maximum_x_value ?
                        x_data_points.max : @maximum_x_value
    @minimum_x_value = x_data_points.min < @minimum_x_value ?
                        x_data_points.min : @minimum_x_value
  end

  def calculate_spread #:nodoc:
    super
    @x_spread = @maximum_x_value.to_f - @minimum_x_value.to_f
    @x_spread = @x_spread > 0 ? @x_spread : 1
  end

  def normalize(force = nil)
    if @norm_data.nil? || force
      @norm_data = []
      return unless @has_data

      @data.each do |data_row|
        norm_data_points = [data_row[DATA_LABEL_INDEX]]
        norm_data_points << data_row[DATA_VALUES_INDEX].map do |r|
          (r.to_f - @minimum_value.to_f) / @spread
        end

        norm_data_points << data_row[DATA_COLOR_INDEX]
        norm_data_points << data_row[DATA_VALUES_X_INDEX].map do |r|
          (r.to_f - @minimum_x_value.to_f) / @x_spread
        end
        @norm_data << norm_data_points
      end
    end
    # ~ @norm_y_baseline = (@baseline_y_value.to_f / @maximum_value.to_f) if @baseline_y_value
    # ~ @norm_x_baseline = (@baseline_x_value.to_f / @maximum_x_value.to_f) if @baseline_x_value
  end
end
