require_relative "../image_for_per_pixel"

image = ImageForPerPixel.new

wave = 10

image.each_pixel do |red, green, blue, x, y|
  x_shift = wave * Math.sin(2.0 * 3.1415 * y.to_f / 128.0)
  y_shift = wave * Math.cos(2.0 * 3.1415 * x.to_f / 128.0)

  new_x = x + x_shift
  new_y = y + y_shift

  pixel = image.original_at(new_x, new_y)

  {
    :red   => pixel[:red],
    :green => pixel[:green],
    :blue  => pixel[:blue]
  }
end

image.save_and_open("water.png")
