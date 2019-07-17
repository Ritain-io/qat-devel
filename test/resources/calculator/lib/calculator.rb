class Calculator

  def push(n)

    @args ||=[]
    @args << n
  end

  def add

    @result=@args.shift

    @args.each do
        |n|
      @result+=n
    end
    @args=[@result]
  end

  def sub

    @result=@args.shift

    @args.each do

        |n|

      @result=@result-n

    end
    @args=[@result]
  end

  def mult

    # @result=args[0]
    # @args[1,,-1].each{
    #     |n|
    #   @result=@result*n
    #
    #
    # }

    @result=@args.shift

    @args.each do

        |n|

      @result=@result*n

    end

    @args=[@result]
  end

  def div

    @result=@args.shift

    @args.each do

        |n|

      @result=@result/n

    end

    @args=[@result]
  end



  def val

    @result
  end
end