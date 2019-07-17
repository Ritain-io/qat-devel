
# implements the class calculator

class Calculator


  # Make the push
  def push(n)
    @args ||= []
    @args << n
  end

  # Get the numbers as arguments and add them
  def add
    desc 'add numbers'
    @result = @args.shift
    @args.each do |n|
      @result += n
    end
    @args = [@result]
  end
  # Get the numbers as arguments and subtract them
  def sub
    @result = @args.shift
    @args.each do |n|
      @result = @result - n
    end
    @args = [@result]
  end

  # Get the numbers as arguments and multiply them
  def mult
    @result = @args.shift
    @args.each do |n|
      @result = @result * n
    end
    @args = [@result]
  end

  # Get the numbers as arguments and divide them
  def div
    @result = @args.shift
    @args.each do |n|
      @result = @result / n
    end

    @args = [@result]
  end

  # Returns the operation value
  def val
    @result
  end
end