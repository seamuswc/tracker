class Calc

    def initialize(array)
        @array = array
        @i = 0
        case array[1]
        when "c"
            @type = "coin"
            @i = 3
        when "s"
            @type = "stock"
            @i = 3
        else
            @type = "coin"
            @i = 2
        end
    end

    def self.calc(array)
        new(array).calc
    end

    def calc

        if @type == "coin"
            result = Api.new.api(@array[(@i-1)])
        else
            result = Stock.new.api(@array[(@i-1)])
        end

            @array[@i..-1].each_slice(2) do |operator, number|
                
                number = number.to_f 

                case operator 
                    when "+" 
                        result += number 
                    when "-" 
                        result -= number 
                    when "*" 
                        result *= number
                    when "/" 
                        result /= number 
                    else 
                        return "unknown operator found"
                end 

            end 

        return result
    end

end
