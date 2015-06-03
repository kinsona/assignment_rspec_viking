class Warmup

 # to test this one, you need to stub out Warmup#gets
 def gets_shout
   gets.chomp.upcase
 end

 # for your spec for this one, pass in a plain old double
 # that can accept a #size method and return something
 def double_size(array)
   return array.size * 2
 end

 # for this method, you want separate tests to show
 # that the string you pass in receives the #upcase!
 # method call, the #reverse! method call,
 # and that your method still returns a totally 
 # different thing
 def calls_some_methods(string)
   string.upcase!
   string.reverse!
   return "hahahaha this is a terrible method"
 end
end
