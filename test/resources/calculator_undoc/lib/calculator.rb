class Calculator

  def push(n)
    @args ||= []
    @args << n
  end

  def add
    desc 'add numbers'
    @result = @args.shift
    @args.each do |n|
      @result += n
    end
    @args = [@result]
  end

  def sub
    @result = @args.shift
    @args.each do |n|
      @result = @result - n
    end
    @args = [@result]
  end

  def mult
    @result = @args.shift
    @args.each do |n|
      @result = @result * n
    end
    @args = [@result]
  end

  def div
    @result = @args.shift
    @args.each do |n|
      @result = @result / n
    end

    @args = [@result]
  end


  def val
    @result
  end
end