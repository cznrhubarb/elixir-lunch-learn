defmodule LoopExample do

  # # ATTEMPT ONE - Recursion for a simple loop?
  # # In functional programming languages, it's much more common to see recursive functions.
  # # A recursive function is one that calls itself.
  # # It's how M.C.Escher would have wrote code if he had been a programmer instead of an artist.
  # # The function below will print the numbers one through n, but you probably guess that by the name
  # # (Also, Elixir usually is written in 'snake_case', where you have underscores between words)
  # #
  # # As a brief example of how this function works, if I pass in the number 10, it will call itself
  # # with the number 9, then 8, etc. When it gets down to 0, it doesn't do anything
  # # At that point, it goes back to where it left off in the previous function call, with n == 1, and prints it
  # # It continues back up until it gets to the first number we sent it (10) and prints that.
  # #
  # # Be careful! Recursive functions are very tricky.
  # # If we didn't have the 'if' check in this function, it would never end! 
  # # It would just continue calling itself forever. Or until you killed the application.

  # def print_numbers_one_through_max(n) do
  #   if n > 0 do
  #     print_numbers_one_through_max(n-1)
  #     IO.puts(n)
  #   end
  # end

  ###################################################################

  # # ATTEMPT TWO - Slightly more idiomatic.
  # # So Elixir doesn't really use 'if' statements all that often. You might never see one actually.
  # # Instead, Elixir will usually use a pattern like the one below. We've now got two copies of the
  # #  same function, with the same name, taking in the same number of parameters.
  # # The difference between the two is that 'when n > 1', which is called a 'guard clause'.
  # # When we call print_numbers_one_through_max, the code will start at the top and try to find a
  # #  function with a guard clause that is a true statement. So if I pass in 10, it uses the top
  # #  version of the function. If I pass in -3, it uses the bottom version.
  # #
  # # For the same example as above, if I pass in 10, it will use the top function. It will then call itself
  # #  with 9, 8, 7, etc. until it gets to 1. Then it will use the bottom version of the function, which
  # #  stops the cycle of calling itself forever until your application crashes.
  # #
  # # This is a little bit of a contrived example, but guard clauses are VERY COMMON in Elixir.
  # # Idiomatic functional programming uses really tiny functions all the time. 
  # #   I'm talking like 1-10 lines, tops.
  # # This is an aid in keeping your functions all tiny so when something goes wrong, it's easy to find out
  # #   who the culprit is.

  # def print_numbers_one_through_max(n) when n > 1 do
  #   print_numbers_one_through_max(n-1)
  #   IO.puts(n)
  # end
  
  # def print_numbers_one_through_max(n) do
  #   IO.puts(n)
  # end

  ###################################################################

  # # ATTEMPT THREE - Tail call recursion
  # # There is a problem with the examples above, and if you've seen recursive 
  # #   functions before, maybe you guessed it.
  # # Every time you call a function (in any language) there is a bit of information that is kept in memory.
  # # If you've heard of a stack trace, you actually know what I'm talking about. All that information in the
  # #   stack trace is what is kept in memory. Any local variables are kept too.
  # # If a recursive function goes on too long, or you have a couple of them nested inside of each other, you
  # #   can chew up a good chunk of your computer's resources on things you aren't using.
  # #
  # # So functional programming languages have a way around this called 'tail call optimization'.
  # # What this means is that if the very last statement in your function is the recursive self call, it can
  # #   clean up all the extra garbage and keep your application running lean and mean.
  # # It's really cool, but it is also a little tricky because you have to solve this extra puzzle of
  # #   'how do I make sure that the function call is last'.
  # # If I was to reorder the statements in the example above, so that IO.puts was called before the
  # #   recursive self call, it will count down instead of up. So we have to get creative here.
  # #
  # # We're going to create two new private methods (only visible from functions inside of this module)
  # #   that we'll use to do our counting now. We'll make them private because they won't really make sense
  # #   outside of the context of helping out our main function.
  # # To make them private we use 'defp' instead of 'def'.
  # #
  # # Our first version of print_numbers_up_to uses a guard clause to stop counting when we get to 'max'.
  # # The second version will happen when our 'current' is equal to 'max'. This will also happen if some
  # #   smart ass (or QA) decides to call print_numbers_one_through_max with a negative number, since 'current'
  # #   starts at 1 and will immediately be more than 'max'.
  # #
  # # One thing you'll notice though, is that the second version of the function doesn't actually need to
  # #   use the 'max' value. We can't omit it though, because then the code won't be able to find a matching
  # #   function if it calls print_numbers_up_to with two parameters and the 'current < max' guard clause fails.
  # # So the parameter still has to be in the function definition, but we can mark it as unused by beginning
  # #   the parameter name with an underscore. This isn't just naming convention: Elixir knows that it
  # #   doesn't have to store this value in memory. You'll often see Elixir code where the variables are
  # #   JUST underscores. This is the same thing.
  # # The single underscore is also often used in things like case statements (same a switch in other languages),
  # #   as a final 'default' case. We'll get to that in a later lesson though.

  # defp print_numbers_up_to(current, max) when current < max do
  #   IO.puts(current)
  #   print_numbers_up_to(current+1, max)
  # end

  # defp print_numbers_up_to(current, _max) do
  #   IO.puts(current)
  # end

  # def print_numbers_one_through_max(n) do
  #   print_numbers_up_to(1, n)
  # end
  
  ###################################################################

  # # ATTEMPT FOUR - There has to be an easier way
  # # OK, so yeah, there is an easier way. While you won't be able to get out of writing recursive
  # #   functions in Elixir, most of the time you need to iterate over a list or something you'll just be
  # #   using one of the functions from the Enum module. Enum is a collection of functions that will let you
  # #   take a collection and transform it, filter it, reduce it, combine it, etc.
  # # First thing we need is a list from 1 to n to iterate over though. For this, we can use the '..' operator.
  # #   The statement '1..n' will give us a range that we can enumerate over containing the numbers from 1 to n.
  # # We will use the function Enum.each() which calls a given function once for each element in the enumeration, 
  # #   passing in that element.
  # # The second parameter of Enum.each() is the function we want to call. Here we will be using a local
  # #   function (known as a lambda). The syntax for these is as shown below.
  # # 'fn' is the keyword for function, '(x)' is the parameter list, the '->' stands in place 
  # #   of the 'do' keyword we've seen earlier, then we have our function body, and 'end' to close the function

  # def print_numbers_one_through_max(n) do
  #   Enum.each(1..n, fn(x) -> IO.puts(x) end)
  # end
  
  ###################################################################

  # # ATTEMPT FIVE - Why bother with a lambda?
  # # If you already have a function that takes the right number of parameters though, (like we
  # #   do with IO.puts) you can just use that function directly. The syntax is a little weird though.
  # # First, we use the '&' operator (capture operator) to allow the function to be used as a variable.
  # #   (The 'fn' keyword does this for us automatically)
  # # Next, the '/1' tells the program what 'arity' of the function we want to use. In Elixir, every
  # #   function is known not only by its name, but its 'arity', or number of parameters. In fact, any
  # #   time you see a function referenced in Elixir docs, you'll see it with a '/number' after it.
  # #   Yes, even if there is only one version of it.

  # def print_numbers_one_through_max(n) do
  #   Enum.each(1..n, &IO.puts/1)
  # end

  ###################################################################

  # # ATTEMPT SIX - OK, Elixir does actually have a for statement
  # # It just doesn't get used that often. It's another thing you might never see someone else write in Elixir.
  # # If you think about it, most time you are using a 'for' in other languages, it's because you're
  # #   looping over some collection of things, right? And if you're going to do that in Elixir,
  # #   you'll most likely be much better off using one of the very powerful methods from the Enum module.
  # #
  # # For fun, I also threw in a slightly different syntax you may see for single line functions
  # # The syntax changes by putting a comma before your 'do', changing the 'do' to an atom by adding the ':',
  # #   and omitting the 'end' statement you would normally have to write. This only works for single statement
  # #   functions though.
  # #
  # #   The statement below could also be written as:
  # #     for x <- 1..n do IO.puts(x) end
  # #
  # # I wouldn't worry too much about this syntax, but it's good if you know it exists. You'll probably
  # #   see other people write it, and it's helpful to know it's just a shortcut people like.
  # # Not only can it be used for 'for' statements, but it can be whole function definitions. The def below
  # #   could also be written like so:
  # #     def print_numbers_one_through_max(n), do: for x <- 1..n, do: IO.puts(x)
  # # That's pretty gnarly, and you won't see them written like that.
  # # But you might see the terminating statement of our previous print_numbers_up_to' method written that way:
  # #     defp print_numbers_up_to(current, _max), do: IO.puts(current)

  def print_numbers_one_through_max(n) do
    for x <- 1..n, do: IO.puts(x)
  end
end