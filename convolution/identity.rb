require_relative "../image_for_per_pixel"

image = ImageForPerPixel.new

filter = [
  [0, 0, 0],
  [0, 1, 0],
  [0, 0, 0]
]
factor = 1
offset = 0

image.each_pixel do |red, green, blue, x, y|
  image.apply_convolution(x, y, filter, factor, offset)
end

image.save_and_open("identity.png")
