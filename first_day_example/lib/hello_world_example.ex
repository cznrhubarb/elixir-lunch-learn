defmodule FirstDayExample do

  # # First things first, comments are marked using the pound sign (hash tag for you young folks)
  # # There are no block comments, just use a lot of pounds.

  # # ATTEMPT ONE - Hello world!
  # # 'def' is used to declare a function, 
  # #   and 'do' is like an open curly brace: the start of the function body
  # # IO.puts is one of the ways to get things written to the output stream.
  # # 'end' is like the closing curly brace: the end of the function body

  # def show_prompt() do
  #   IO.puts("Hello world!")
  # end
  
  ###################################################################

  # # ATTEMPT TWO - Get info and respond
  # # We can also get information from the input stream using IO.gets
  # # It displays a prompt, then waits for input.
  # #   Hitting enter will cause what you typed to be returned from the IO.gets function
  # # Next we can print it back out to the screen in a formatted message by using the 
  # #   string concatenation operator '<>'.
  # # (Fun fact, the '=' operator in Elixir is called the 'match operator' and not the 'assignment operator'.
  # #   There's a good reason for this, but it's outside of the scope of what I'm teaching right now)

  # def show_prompt() do
  #   IO.puts("Hello world!")
  #   name = IO.gets("Who are you? ")
  #   IO.puts("Howdy " <> name <> "!")
  # end

  ###################################################################

  # # ATTEMPT THREE - Clean up
  # # Unfortunately, when you hit the enter key, the new line from the input stream comes along.
  # #   Since Elixir is a functional programming language, there are no objects. So in some other languages
  # #   I might be able to type 'name.trim()', here I have to use one of the functions from the String module.
  # #   (Trim takes all the whitespace (spaces, tabs, newlines, etc) off the left and right side of a string)

  # def show_prompt() do
  #   IO.puts("Hello world!")
  #   name = IO.gets("Who are you? ")
  #   trimmed_name = String.trim(name)
  #   IO.puts("Howdy " <> trimmed_name <> "!")
  # end

  ###################################################################

  # # ATTEMPT FOUR - Pipes!
  # # One of the cool syntactic sugar things that Elixir has is the pipe operator (|>)
  # # This takes the value on the left side and pushes it into the function on the right side
  # #   as its first parameter. You'll often see this written over multiple lines, like in the NEXT example.

  # def show_prompt() do
  #   IO.puts("Hello world!")
  #   name = IO.gets("Who are you? ") |> String.trim
  #   IO.puts("Howdy " <> name <> "!")
  # end

  ###################################################################

  # # ATTEMPT FIVE - String interpolation
  # # String interpolation is a way of simplying string concatenation. It's becoming pretty common in languages
  # #   nowadays, and here is what it looks like in Elixir. That "howdy" line is exactly the same as the
  # #   "howdy" line from the example above.

  def show_prompt() do
    IO.puts("Hello world!")
    name = IO.gets("Who are you? ") 
    |> String.trim
    IO.puts("Howdy #{name}!")
  end
end
