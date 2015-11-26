require_relative "../image_for_resizing"

image = ImageForResizing.new(768, 432)

x_factor = image.original.width.to_f / image.result.width.to_f
y_factor = image.original.height.to_f / image.result.height.to_f

image.each_pixel do |x, y|
  nearest_x = (x * x_factor).floor
  nearest_y = (y * y_factor).floor

  pixel = image.original_at(nearest_x, nearest_y)

  {
    :red   => pixel[:red],
    :green => pixel[:green],
    :blue  => pixel[:blue]
  }
end

image.save_and_open("nearest_neighbour.png")
