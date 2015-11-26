require_relative "../image_for_per_pixel"

image = ImageForPerPixel.new

image.each_pixel do |red, green, blue, x, y|
  new_x = image.original.width - 1 - x
  new_y = image.original.height - 1 - y

  pixel = image.original_at(new_x, new_y)

  {
    :red   => pixel[:red],
    :green => pixel[:green],
    :blue  => pixel[:blue]
  }
end

image.save_and_open("flip.png")
