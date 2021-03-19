# dec
_simple method decorator_

## Installation

`gem install dec`

## Example

```ruby
class Something
  extend Dec

  dec { |r| r + 2 }
  dec { |r| r + 1 }
  def one
    1
  end

  LOG = -> (r) { puts r.upcase; r }

  dec LOG
  def two
    "two"
  end
end

s = Something.new
s.one
# => 4

s.two
TWO
# => "two"
```
