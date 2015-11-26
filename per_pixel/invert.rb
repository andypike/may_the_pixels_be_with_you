require_relative "../image_for_per_pixel"

image = ImageForPerPixel.new

image.each_pixel do |red, green, blue|
  {
    :red   => 255 - red,
    :green => 255 - green,
    :blue  => 255 - blue
  }
end

image.save_and_open("invert.png")
