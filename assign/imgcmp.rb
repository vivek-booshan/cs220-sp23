#! /usr/bin/env ruby

require 'oily_png'

class Pixel
  def initialize(value)
    raise "no" if value.nil?
    @value = value
  end

  def r
    return ChunkyPNG::Color.r(@value)
  end

  def g
    return ChunkyPNG::Color.g(@value)
  end

  def b
    return ChunkyPNG::Color.b(@value)
  end

  def a
    return ChunkyPNG::Color.a(@value)
  end
end

def usage
  puts "Usage: imgcmp.rb <max delta> <file1> <file2>"
  exit 1
end

def compare_components(c1, c2, max_delta)
  delta = (c1 - c2).abs
  return delta <= max_delta
end

def compare_pixels(p1, p2, max_delta)
  p1 = Pixel.new(p1)
  p2 = Pixel.new(p2)
  return (compare_components(p1.r, p2.r, max_delta) and compare_components(p1.g, p2.g, max_delta) and compare_components(p1.b, p2.b, max_delta) and compare_components(p1.a, p2.a, max_delta))
end

usage() if ARGV.length != 3

max_delta = ARGV[0].to_i
file1 = ARGV[1]
file2 = ARGV[2]

im1 = ChunkyPNG::Image.from_file(file1)
im2 = ChunkyPNG::Image.from_file(file2)

if im1.width != im2.width or im1.height != im2.height
  puts "Image dimensions differ"
  exit 1
end

mismatches = 0

(0..im1.height-1).each do |i|
  (0..im1.width-1).each do |j|
    p1 = im1[j, i]
    p2 = im2[j, i]
    if !compare_pixels(p1, p2, max_delta)
      puts "Mismatch at col=#{j}, row=#{i}"
      mismatches += 1
    end
  end
end

puts "Mismatched pixels: #{mismatches}"

exit (mismatches == 0) ? 0 : 1
