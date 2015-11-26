require_relative "../image_for_per_pixel"

image = ImageForPerPixel.new

image.each_pixel do |red, green, blue|
  grey = (red + green + blue) / 3                               # Average
  # grey = ((red * 0.3) + (green * 0.59) + (blue * 0.11)).round # Human eye correcting (cones)
  # grey = [red, green, blue].min                               # Lowest channel per pixel
  # grey = [red, green, blue].max                               # Highest channel per pixel
  # grey = green                                                # Use one channel (cameras)

  # Limit to only a few shades of grey
  # num_of_shades = 5
  # conversion_factor = 255 / (num_of_shades - 1)
  # average = (red + green + blue) / 3
  # grey = ((average / conversion_factor) * conversion_factor).round

  {
    :red   => grey,
    :green => grey,
    :blue  => grey
  }
end

image.save_and_open("greyscale.png")
