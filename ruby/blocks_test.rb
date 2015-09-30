require 'minitest/autorun'

# read http://www.reactive.io/tips/2008/12/21/understanding-ruby-blocks-procs-and-lambdas/
# noinspection RubyDeadCode
class BlocksTest < Minitest::Test

  def test_even_map
    input = [11, -2, 32, 14, -5, 26]
    expected = [22, 64, -10]

    assert_equal(expected, input.even_map { |item| item * 2 })
  end

  def test_even_reduce
    input = [11, -2, 32, 14, -5, 26]
    expected = 38

    assert_equal(expected, input.even_reduce(0) { |acc, item| acc + item })
  end

  def test_even_reduce_arg
    input = [11, -2, 32, 14, -5, 26]
    expected = 38

    assert_equal(expected, input.even_reduce_arg(0, lambda { |acc, item| acc + item }))
  end

  def test_map_with_siblings
    input = [1, 2, 3]
    expected = [[nil, 1, 2], [1, 2, 3], [2, 3, nil]]

    assert_equal(expected, input.map_with_siblings { |prev, current, nextt| [prev, current, nextt] })
  end
end

class Array

  # Map only elements with even indexes
  # Method accepts only blocks
  # @yield [item] Gives array element to block
  # @return [Array]
  def even_map
    result=[]
    self.each_with_index do |item, i|
      if i%2==0
        result.push(yield(item))
      end
    end
    return result
  end

  # Reduce only elements with even indexes
  # Method accepts only blocks
  # @yield [item] Gives array element to block
  # @return [Fixnum]
  def even_reduce(acc)
    self.each_with_index do |item, i|
      if i%2==0
      acc = yield(acc, item)
      end
    end
    return acc
  end

  # Reduce only elements with even indexes
  # Method accepts lambdas and Procs
  # @param [lambda]
  # @return [Fixnum]
  def even_reduce_arg(acc, func)
    self.each_with_index do |item, i|
      if i%2==0
        acc = func.call(acc, item)
      end
    end
    return acc
  end
  # Map elements
  # Method accepts only blocks
  # @yield [prev, current, nexts] Gives current and sibling elements to block
  # @return [Fixnum]
  def map_with_siblings
    result = []
    self.each_with_index do |item, i|
      puts item
      prev = self[i-1]
      if i==0
        prev = nil
      end
      current = item
      nextt = self[i+1]
      if i == self.size-1
        nextt = nil
      end
      result.push(yield(prev, current, nextt))
    end
    return result
  end

end

