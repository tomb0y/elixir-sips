defmodule DirectionsTest do
  use ExUnit.Case

  test "#reduce: empty list of directions" do
    assert Directions.reduce([]) == []
  end

  test "#reduce: north - south" do
    assert Directions.reduce(~w[NORTH SOUTH]) == []
  end

  test "#reduce: south - north" do
    assert Directions.reduce(~w[SOUTH NORTH]) == []
  end

  test "#reduce: east - west" do
    assert Directions.reduce(~w[EAST WEST]) == []
  end

  test "#reduce: west - east" do
    assert Directions.reduce(~w[WEST EAST]) == []
  end

  test "#reduce: north" do
    assert Directions.reduce(~w[NORTH]) == ~w[NORTH]
  end

  test "#reduce: south" do
    assert Directions.reduce(~w[SOUTH]) == ~w[SOUTH]
  end

  test "#reduce: east" do
    assert Directions.reduce(~w[EAST]) == ~w[EAST]
  end

  test "#reduce: west" do
    assert Directions.reduce(~w[WEST]) == ~w[WEST]
  end

  test "#reduce: directions" do
    directions = ~w[NORTH SOUTH SOUTH EAST WEST NORTH WEST]
    assert Directions.reduce(directions) == ~w[WEST]
  end

  test "#reduce: unreducable directions" do
    unreducable_directions = ~w[NORTH WEST SOUTH EAST]
    assert Directions.reduce(unreducable_directions) == unreducable_directions
  end
end
