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

  # returns true or false based on whether or not the key exists in the hash map
  def has?(key)
    index = bucket_index(key)
    bucket = @buckets[index]

    bucket.any? { |entry| entry[0] == key }
  end

  # returns the deleted entry's value
  def remove(key)
    index = bucket_index(key)
    bucket = @buckets[index]

    entry_index = bucket.index { |entry| entry[0] == key }
    if entry_index
      removed_key = bucket.delete_at(entry_index)
      @size -= 1
      removed_key[1]
    else
      'nil'
    end
  end

  # returns the number of stored keys in the hash map
  def length
    puts @size
  end

  # removes all entries in the hash map
  def clear
    @buckets = Array.new(@capacity) { [] }
    @size = 0
  end

  # returns an array containing all the keys inside the hash map
  def keys
    puts(@buckets.flatten(1).map { |entry| entry[0] })
  end

  # returns an array containing all the values
  def values
    puts(@buckets.flatten(1).map { |entry| entry[1] })
  end

  # returns an array that contains each key-value pair
  def entries
    @buckets.flatten(1).map { |entry| p entry }
  end
end

# HashSet
class HashSet
  attr_reader :capacity, :size, :load_factor

  def initialize(capacity = 16, load_factor = 0.75)
    @capacity = capacity
    @load_factor = load_factor
    @size = 0
    @buckets = Array.new(@capacity) { [] }
  end

  def hash(key)
    hash_code = 0
    prime_no = 31

    key.each_char { |char| hash_code = prime_no * hash_code + char.ord }
    hash_code
  end

  def bucket_index(key)
    index = hash(key) % @capacity
    raise IndexError if index.negative? || index >= @buckets.length

    index
  end

  def add(key)
    index = buncket_index(key)
    bucket = @buckets[index]

    if bucket.include?(key)
      nil
    else
      bucket << key
      @size += 1
      grow! if @size.to_f / @capacity > @load_factor
    end
  end

  def get(key)
    index = buncket_index(key)
    bucket = @buckets[index]

    bucket.include?(key) ? key : 'nil'
  end

  def remove(key)
    index = buncket_index(key)
    bucket = @buckets[index]

    key_index = bucket.index { |entry| entry == key }
    if bucket.include?(key)
      bucket.delete_at(key_index)
      @size -= 1
      puts key
    else
      puts 'nil'
    end
  end

  def has?(key)
    index = buncket_index(key)
    bucket = @buckets[index]

    p bucket.include?(key)
  end

  def length
    p @size
  end

  def clear
    @capacity = 16
    @size = 0
    @buckets = Array.new(@capacity) { [] }
    puts 'Cleared'
  end

  def keys
    p @buckets.flatten
  end

  private

  def grow!
    old_buckets = @buckets
    @capacity *= 2
    @size = 0
    @buckets = Array.new(@capacity) { [] }

    old_buckets.flatten.each { |key| add(key) }
  end
end

# test = HashMap.new
# test.set('apple', 'red')
# test.set('banana', 'yellow')
# test.set('carrot', 'orange')
# test.set('dog', 'brown')
# test.set('elephant', 'gray')
# test.set('frog', 'green')
# test.set('grape', 'purple')
# test.set('hat', 'black')
# test.set('ice cream', 'white')
# test.set('jacket', 'blue')
# test.set('kite', 'pink')
# test.set('lion', 'golden')
# test.length
# test.keys
# test.values
# test.entries
# test2 = HashSet.new
# test2.add('apple')
# test2.add('grapes')
# test2.add('rock')
# test2.keys
