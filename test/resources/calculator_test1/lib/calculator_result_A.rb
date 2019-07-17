# It's a Calculator
class CalculatorResultA
  def initialize
    @args   = []
    @result = 0
  end

  def push(number)
    @args << number
  end

  def add
    @args = [do_operation(0, @args, :+)]
  end

  def sub
    first = @args.shift

    @args = [do_operation(first, @args, :-)]
  end

  def mult
    first = @args.shift

    @args = [do_operation(first, @args, :*)]
  end

  def div
    first = @args.shift

    @args = [do_operation(first, @args, :/)]
  end

  def val
    @result
  end

  private
  def do_operation(initial_value, values, operator)
    values.inject(initial_value) { |number, result| number.method(operator).call(result) }
  end
end