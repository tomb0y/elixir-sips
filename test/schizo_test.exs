defmodule SchizoTest do
  use ExUnit.Case
  doctest Schizo

  describe "uppercase" do
    test "it will not uppercase the first word" do
      assert Schizo.uppercase("foo") == "foo"
    end

    test "it will uppercase the second word" do
      assert Schizo.uppercase("foo bar") == "foo BAR"
    end

    test "it will uppercase every other word" do
      assert Schizo.uppercase("foo bar baz wee") == "foo BAR baz WEE"
    end
  end

  describe "unvowel" do
    test "it will not change the first word" do
      assert Schizo.unvowel("foo") == "foo"
    end

    test "it will remove the vowels from the second word" do
      assert Schizo.unvowel("foo bar") == "foo br"
    end

    test "it will remove the vowels from every other word" do
      assert Schizo.unvowel("foo bar baz wee") == "foo br baz w"
    end
  end
end
