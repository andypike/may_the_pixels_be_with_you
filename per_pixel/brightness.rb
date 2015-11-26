require_relative "../image_for_per_pixel"

image = ImageForPerPixel.new

amount = 100

image.each_pixel do |red, green, blue|
  {
    :red   => red + amount,
    :green => green + amount,
    :blue  => blue + amount
  }
end

image.save_and_open("brightness.png")
