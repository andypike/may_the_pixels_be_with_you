require "chunky_png"

class ImageForResizing
  attr_reader :original, :width, :height, :result

  def initialize(width, height)
    file_path = File.join(File.dirname(__FILE__), "poster-large.png")
    @original = ChunkyPNG::Image.from_file(file_path)

    @width  = width
    @height = height

    @result = ChunkyPNG::Image.new(width, height, ChunkyPNG::Color::TRANSPARENT)
  end

  def each_pixel
    0.upto(width - 1) do |x|
      0.upto(height - 1) do |y|
        rgb = yield(x, y)

        result[x, y] = ChunkyPNG::Color.rgb(
          clamp(rgb[:red]),
          clamp(rgb[:green]),
          clamp(rgb[:blue])
        )
      end
    end
  end

  def original_at(x, y)
    pixel = original[x, y]

    {
      :red   => ChunkyPNG::Color.r(pixel),
      :green => ChunkyPNG::Color.g(pixel),
      :blue  => ChunkyPNG::Color.b(pixel)
    }
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
