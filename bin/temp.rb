#!/usr/bin/env ruby
#
require_relative '../lib/problem_helper'

helper = ProblemHelper.new

destinations = { 0 => [31/64r,-5/64r],
                 1 => [26/64r,-18/64r],
                 2 => [31/64r,1/4r],
                 3 => [33/64r,1/4r],
                 4 => [15/64r,0],
                 5 => [49/64r,0],
                 6 => [15/64r,-5/64r],
                 7 => [26/64r,-2/64r],
                 'n7' => [49/64r,-2/64r],
                 'n8' => [33/64r,-18/64r],
               }
points = [
  [[0,0],destinations[0]],
  [[1,0],destinations[1]],
  [[1,1],destinations[1]],
  [[0,1],destinations[0]],
  [[21/64r,0],destinations[2]],
  [[23/64r,0],destinations[3]],
  [[0,1/4r],destinations[6]],
  [[5/64r,1/4r],destinations[4]],
  [[39/64r,1/4r],destinations[5]],
  [[1,1/4r],destinations[7]],
  [ [0,1/2r] ,destinations[0]],
  [ [21/64r,1/2r] ,destinations[2]],
  [ [23/64r,1/2r] ,destinations[3]],
  [ [1,1/2r] ,destinations[1]],
  [ [0,3/4r] ,destinations[6]],
  [ [5/64r,3/4r] ,destinations[4]],
  [ [39/64r,3/4r] ,destinations[5]],
  [ [1,3/4r] ,destinations[7]],
  [ [21/64r,1] ,destinations[2]],
  [ [23/64r,1] ,destinations[3]],

  [ [57/64r,0] ,destinations['n8']],
  
  [ [41/64r,1/4r] ,destinations['n7']],

  [ [57/64r,1/2r] ,destinations['n8']],

  [ [41/64r,3/4r] ,destinations['n7']],

  [ [57/64r,1] ,destinations['n8']]
]
points.each { |p|
  helper.add_vertex(*p)
}

polygons = [
  "0 6 7 4",
  "4 7 8 5",
  "6 10 11 7",
  "7 11 12 8",
  "10 14 15 11",
  "11 15 16 12",
  "14 3 18 15",
  "15 18 19 16",
  "5 8 21 20",
  "21 9 1 20",
  "8 12 22 21",
  "21 22 13 9",
  "12 16 23 22",
  "22 23 17 13",
  "16 19 24 23",
  "23 24 2 17"
]

polygons.each { |v| helper.add_polygon(v) }

#while (x = gets.strip) != "done"
#  helper.add_polygon(x)
#end
puts helper.to_s

