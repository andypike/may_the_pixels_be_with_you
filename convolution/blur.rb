require_relative "../image_for_per_pixel"

image = ImageForPerPixel.new

filter = [
  [1, 2, 1],
  [2, 4, 2],
  [1, 2, 1]
]
factor = 16.0
offset = 0

image.each_pixel do |red, green, blue, x, y|
  image.apply_convolution(x, y, filter, factor, offset)
end

image.save_and_open("blur.png")
