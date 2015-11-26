require_relative "../image_for_per_pixel"

image = ImageForPerPixel.new("bb8.png")

chars = ["##", "WW", "KK", "EE", "DD", "GG", "LL", "ff", "jj", "tt", "ii", ";;", "::", ",,", "..", "  "]

save_path = File.join(File.dirname(__FILE__), "..", "output", "bb8.txt")

File.open(save_path, "w") do |result|
  image.each_pixel do |red, green, blue, x, y|
    grey = (red + green + blue) / 3

    index = (grey / 16.0).floor
    character = chars[index]

    result.print("\n") if x.zero?

    result.print(character)

    { :red => 0, :green => 0, :blue => 0 }
  end
end
