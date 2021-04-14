letters = ("a".."z").to_a
vowels = ["a", "e", "i", "o", "u", "y"]

vowels_hash = {}

letters.each.with_index(1) do |letter, index|
  vowels_hash[letter] = index if vowels.include?(letter)
end

puts vowels_hash
