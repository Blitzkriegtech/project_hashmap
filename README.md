# project_hashmap
# HashMap Implementation in Ruby 🐍💡

This project is a custom implementation of a basic **HashMap** in Ruby that supports essential key-value operations, including:

- Insertion (`#set`)
- Retrieval (`#get`)
- Update
- Deletion (`#remove`)
- Lookup (`#has?`)
- Resizing when the load factor is exceeded

It also provides utilities for accessing keys, values, and all entries in the hash map.

---

## 🧱 Features

- Uses **separate chaining** (arrays inside buckets) for collision resolution.
- Automatically **resizes** when the number of stored elements exceeds the load factor.
- Handles string keys only (simplified for learning purposes).
- Offers essential methods to manipulate and query the hash map.

---

## 🛠 Methods Overview

### ✅ `set(key, value)`
- Adds a new key-value pair.
- Updates the value if the key already exists.
- Triggers a resize if load factor threshold is crossed.

### 🔍 `get(key)`
- Retrieves the value associated with the given key.
- Returns `'nil'` if the key is not found.

### ❓ `has?(key)`
- Returns `true` if the key exists, `false` otherwise.

### ❌ `remove(key)`
- Deletes the key-value pair and returns the removed value.
- Returns `'nil'` if the key is not found.

### 📏 `length`
- Prints the current number of entries stored.

### 🧹 `clear`
- Clears all entries from the hash map.

### 🔑 `keys`
- Prints an array of all keys.

### 🎁 `values`
- Prints an array of all values.

### 📦 `entries`
- Prints an array of all `[key, value]` pairs.

---

## ⚙️ Internal Details

### Hashing
Uses a simple hash function based on the polynomial rolling hash:
```ruby
hash_code = 31 * hash_code + char.ord
