# frozen_string_literal: true

# hashmap
class HashMap
  attr_reader :load_factor, :size, :capacity

  def initialize(capacity = 16, load_factor = 0.75)
    @capacity = capacity
    @load_factor = load_factor
    @size = 0
    @buckets = Array.new(@capacity) { [] }
  end

  # creates hash code
  def hash(key)
    hash_code = 0
    prime_no = 31

    key.each_char { |char| hash_code = prime_no * hash_code + char.ord }
    hash_code
  end

  # bucket index finder
  def bucket_index(key)
    index = hash(key) % @capacity
    raise IndexError if index.negative? || index >= @buckets.length

    index
  end

  # sets a key-value pair, if already exists, updates the old value with the new one
  def set(key, value)
    index = bucket_index(key)
    bucket = @buckets[index]

    # check if the key already exist, update if it exist otherwise add [key, value] in the bucket
    existing_entry = bucket.find { |entry| entry[0] == key }
    if existing_entry
      existing_entry[1] = value
    else
      bucket << [key, value]
      @size += 1
      # check if the buckets capacity needs to grow
      grow! if @size.to_f / @capacity > @load_factor
    end
  end

  # returns the value of a key
  def get(key)
    index = bucket_index(key)
    bucket = @buckets[index]

    bucket.each do |entry|
      return entry[1] if entry[0] == key
    end
    'nil'
  end
end

test = HashMap.new
test.set('apple', 'red')
puts test.get('apple')
puts test.get('mango')
puts test.get('strawberry')
