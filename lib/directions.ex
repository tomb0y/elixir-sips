defmodule Directions do
  @moduledoc false

  @north "NORTH"
  @south "SOUTH"
  @east "EAST"
  @west "WEST"

  def reduce(directions) do
    directions
    |> do_reduce([])
    |> Enum.reverse
  end

  defp do_reduce([], map), do: map
  defp do_reduce([direction], []), do: [direction]
  defp do_reduce([dir_h | dir_tl], []), do: do_reduce(dir_tl, [dir_h])
  defp do_reduce([dir_h | dir_tl], [map_h | map_tl]) do
    if opposite_directions?(dir_h, map_h) do
      do_reduce(dir_tl, map_tl)
    else
      do_reduce(dir_tl, [dir_h] ++ [map_h] ++ map_tl)
    end
  end

  defp opposite_directions?(@north, @south), do: true
  defp opposite_directions?(@south, @north), do: true
  defp opposite_directions?(@east, @west), do: true
  defp opposite_directions?(@west, @east), do: true
  defp opposite_directions?(_, _), do: false
end
