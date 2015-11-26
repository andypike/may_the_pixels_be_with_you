require_relative "../image_for_resizing"

image = ImageForResizing.new(768, 432)

x_factor = image.original.width.to_f / image.result.width.to_f
y_factor = image.original.height.to_f / image.result.height.to_f

image.each_pixel do |x, y|
  floor_x = (x * x_factor).floor
  floor_y = (y * y_factor).floor
  ceil_x = floor_x + 1
  ceil_y = floor_y + 1

  p1 = image.original_at(floor_x, floor_y)
  p2 = image.original_at(ceil_x, floor_y)
  p3 = image.original_at(floor_x, ceil_y)
  p4 = image.original_at(ceil_x, ceil_y)

  fraction_x = x * x_factor - floor_x
  fraction_y = y * y_factor - floor_y
  one_minus_x = 1.0 - fraction_x
  one_minus_y = 1.0 - fraction_y

  r1 = one_minus_x * p1[:red] + fraction_x * p2[:red]
  r2 = one_minus_x * p3[:red] + fraction_x * p4[:red]
  red = one_minus_y * r1 + fraction_y * r2

  g1 = one_minus_x * p1[:green] + fraction_x * p2[:green]
  g2 = one_minus_x * p3[:green] + fraction_x * p4[:green]
  green = one_minus_y * g1 + fraction_y * g2

  b1 = one_minus_x * p1[:blue] + fraction_x * p2[:blue]
  b2 = one_minus_x * p3[:blue] + fraction_x * p4[:blue]
  blue = one_minus_y * b1 + fraction_y * b2

  {
    :red   => red,
    :green => green,
    :blue  => blue
  }
end

image.save_and_open("bilinear.png")
