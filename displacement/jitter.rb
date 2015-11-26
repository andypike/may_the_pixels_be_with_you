require_relative "../image_for_per_pixel"

image = ImageForPerPixel.new

distance = 10

image.each_pixel do |red, green, blue, x, y|
  new_x = x + rand(distance)
  new_y = y + rand(distance)

  pixel = image.original_at(new_x, new_y)

  {
    :red   => pixel[:red],
    :green => pixel[:green],
    :blue  => pixel[:blue]
  }
end

image.save_and_open("jitter.png")
