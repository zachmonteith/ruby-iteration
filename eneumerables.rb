require 'byebug'
class Array
  def my_each(&blk)
    i = 0

    if blk
      while i < self.length
        blk.call(self[i])
        i += 1
      end
    end

    self
  end

  def my_select(&blk)
    i = 0
    result = []

    if blk
      while i < self.length
        result << self[i] if blk.call(self[i])
        i += 1
      end
    end

    result
  end

  def my_reject(&blk)
    i = 0
    result = []

    if blk
      while i < self.length
        result << self[i] unless blk.call(self[i])
        i += 1
      end
    end

    result
  end

  def my_any?(&blk)
    i = 0

    if blk
      while i < self.length
        return true if blk.call(self[i])
        i += 1
      end
    end

    false
  end

  def my_all?(&blk)
    i = 0

    if blk
      while i < self.length
        if blk.call(self[i])
          true
        else
          return false
        end
        i += 1
      end
    end

    true
  end

  def my_flatten
    result = []
    # debugger
    self.each do |el|
      if el.is_a? (Array)
        result += el.my_flatten
      else
        result << el
      end
    end
    result
  end



  def my_zip(*args)
    i = 0
    result = []
    length_of_args = args.length

    while i < self.length
      result_to_put_into_array = []
      result_to_put_into_array << self[i]
      idx2 = 0

      length_of_args.times do
        result_to_put_into_array << args[idx2][i]
        idx2 += 1
      end

      i += 1
      result << result_to_put_into_array
    end

    result
  end


  def my_rotate(num = 1)

    num = num % self.length

    i = 0
    result = []
    idx2 = 0

    while i < self.length
      if idx2 + num < self.length
        result << self[idx2 + num]
      else
        idx2 = -num
        result << self[idx2 + num]
      end
      idx2 += 1
      i += 1
    end

    result
  end

  def my_join(sep = "")
    string = ""

    self.each do |letter|
      string << letter + sep
    end

    string
  end

  def my_reverse
    i = self.length - 1
    result = []
    while i >= 0
      result << self[i]
      i -= 1
    end
    result
  end
end
