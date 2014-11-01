require 'prime'

def histogram(string)
  answer = Hash.new(0)
  string.split('').each do |char|
    answer[char] += 1
  end

  answer
end

def histogram(string)
  Hash.new(0).tap do |hash|
    string.split('').each do |char|
      hash[char] += 1
    end
  end
end

def prime?(n)
  # Prime.prime?(n) #one way to do it...
  return false if n <= 1
  2.upto(Math.sqrt(n)) { |x| return false if n % x == 0 }
  true
end

def ordinal(n)
  return "#{n}th" if [11, 12, 13].include?(n % 100)

  case n % 10
  when 1 then "#{n}st"
  when 2 then "#{n}nd"
  when 3 then "#{n}rd"
  else        "#{n}th"
  end
end

def palindrome?(object)
  string = object.to_s.downcase.tr(' ', '')
  string == string.reverse
end

def anagram?(word, other)
  histogram(word.downcase.tr(' ', '')) == histogram(other.downcase.tr(' ', ''))
end

def remove_prefix(string, pattern)
  return if string[0, pattern.length] != pattern
  string[pattern.length, string.length].strip
end

def remove_suffix(string, pattern)
  return if string[-pattern.length, pattern.length] != pattern
  string[0, string.length - pattern.length].strip
end

def digits(n)
  n.to_s.split('').map(&:to_i)
end

def fizzbuzz(range)
  range.map do |x|
    case
    when x % 15 == 0 then :fizzbuzz
    when x % 3 == 0 then :fizz
    when x % 5 == 0 then :buzz
    else x
    end
  end
end

def count(array)
  Hash.new(0).tap do |hash|
    array.each { |element| hash[element] += 1 }
  end
end

def count_words(*sentences)
  Hash.new(0).tap do |hash|
    sentences.each do |sentence|
      sentence.gsub(',|.', '').split.each do |word|
        hash[word] += 1
      end
    end
  end
end
