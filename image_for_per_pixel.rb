require "chunky_png"

class ImageForPerPixel
  attr_reader :original, :width, :height, :result

  def initialize(file_name = "poster.png")
    file_path = File.join(File.dirname(__FILE__), file_name)
    @original = ChunkyPNG::Image.from_file(file_path)

    @width  = original.width
    @height = original.height

    @result = ChunkyPNG::Image.new(width, height, ChunkyPNG::Color::TRANSPARENT)
  end

  def each_pixel
    0.upto(height - 1) do |y|
      0.upto(width - 1) do |x|
        pixel = original_at(x, y)

        rgb = yield(pixel[:red], pixel[:green], pixel[:blue], x, y)

        result[x, y] = ChunkyPNG::Color.rgb(
          clamp(rgb[:red]),
          clamp(rgb[:green]),
          clamp(rgb[:blue])
        )
      end
    end
  end

  def original_at(x, y)
    x = x.round
    y = y.round

    x = 0 if x < 0
    y = 0 if y < 0
    x = original.width - 1 if x >= original.width
    y = original.height - 1 if y >= original.height

    pixel = original[x, y]

    {
      :red   => ChunkyPNG::Color.r(pixel),
      :green => ChunkyPNG::Color.g(pixel),
      :blue  => ChunkyPNG::Color.b(pixel)
    }
  end

  def apply_convolution(x, y, filter, factor, offset)
    p1 = original_at(x - 1, y - 1)
    p2 = original_at(x    , y - 1)
    p3 = original_at(x + 1, y - 1)
    p4 = original_at(x - 1, y    )
    p5 = original_at(x    , y    ) # Pixel being processed
    p6 = original_at(x + 1, y    )
    p7 = original_at(x - 1, y + 1)
    p8 = original_at(x    , y + 1)
    p9 = original_at(x + 1, y + 1)

    r = (((p1[:red] * filter[0][0]) +
          (p2[:red] * filter[0][1]) +
          (p3[:red] * filter[0][2]) +
          (p4[:red] * filter[1][0]) +
          (p5[:red] * filter[1][1]) +
          (p6[:red] * filter[1][2]) +
          (p7[:red] * filter[2][0]) +
          (p8[:red] * filter[2][1]) +
          (p9[:red] * filter[2][2])) / factor) + offset

    g = (((p1[:green] * filter[0][0]) +
          (p2[:green] * filter[0][1]) +
          (p3[:green] * filter[0][2]) +
          (p4[:green] * filter[1][0]) +
          (p5[:green] * filter[1][1]) +
          (p6[:green] * filter[1][2]) +
          (p7[:green] * filter[2][0]) +
          (p8[:green] * filter[2][1]) +
          (p9[:green] * filter[2][2])) / factor) + offset

    b = (((p1[:blue] * filter[0][0]) +
          (p2[:blue] * filter[0][1]) +
          (p3[:blue] * filter[0][2]) +
          (p4[:blue] * filter[1][0]) +
          (p5[:blue] * filter[1][1]) +
          (p6[:blue] * filter[1][2]) +
          (p7[:blue] * filter[2][0]) +
          (p8[:blue] * filter[2][1]) +
          (p9[:blue] * filter[2][2])) / factor) + offset

    { :red => r, :green => g, :blue => b }
  end

  def save_and_open(file_name)
    file_path = File.join(File.dirname(__FILE__), "output", file_name)

    result.save(file_path, :fast_rgba)

    `open #{file_path}`
  end

  private

  def clamp(number)
    return 0 if number < 0
    return 255 if number > 255

    number.round
  end
end
