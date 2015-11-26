require_relative "../image_for_per_pixel"

image = ImageForPerPixel.new

image.each_pixel do |red, green, blue|
  {
    :red   => red,
    :green => 0,
    :blue  => 0
  }
end

image.save_and_open("channel.png")
