# iex -r myElixirFile.exs

defmodule Elixir_Intro do

#------------------------------- fib(n)
		def fib(0) do 0 end
		def fib(1) do 1 end
    def fib(n) do
        fibHelper(1, 1, n-2)
    end

    def fibHelper(current_fib, next_fib, n) do
        case n do
            0 ->
                next_fib
            _ ->
                fibHelper(next_fib, current_fib + next_fib, n-1)
        end
    end

#------------------------------- area(shape, shape_info)
		def area(:rectangle, shape_info) do
				elem(shape_info, 0) * elem(shape_info, 1)
		end

		def area(:square, shape_info) do
				shape_info * shape_info
		end

		def area(:circle, shape_info) do
				(shape_info * shape_info) * :math.pi
		end

		def area(:triangle, shape_info) do
				elem(shape_info, 0) * elem(shape_info, 1) / 2
		end

#------------------------------- sqrList(nums)
    def sqrList(nums) do
        sqrListHelper(nums)
    end

    def sqrListHelper([head | tail]) do
        [head * head | sqrListHelper(tail)]
    end

    def sqrListHelper([]) do
        []
    end

#------------------------------- calcTotals(inventory)
#******************************************************************************************** Check this with TAs
# Elixir_Intro.calcTotals([{:apple, 3, 2}, {:pear, 5, 1}, {:pumpkin, 1, 10}])

    def calcTotals(inventory) do
        calcTotalsHelper(inventory)
    end

    def calcTotalsHelper([head | tail]) do
        [{elem(head, 0), elem(head, 1) * elem(head,2)} | calcTotalsHelper(tail)]
    end

    def calcTotalsHelper([]) do
        []
    end



#------------------------------- map(function,vals)
    def map(function, vals) do
        mapHelper(function, vals)
    end

    def mapHelper(function, [head | tail]) do
        [ function.(head) | mapHelper(function, tail)]
    end

    def mapHelper(_function, []) do
        []
    end


#------------------------------- quickSortServer()
		def quickSortServer() do
			receive do
				{message, pid} -> send(pid, {quickSort(message), self()})
			end
			quickSortServer()
		end

		def quickSort([]) do
				[]
		end

		def quickSort(list) do
			pivotIndex = :random.uniform(length(list)) - 1
			pivot = Enum.at(list, pivotIndex)
			editedList = List.delete_at(list, pivotIndex)
			{upper, lower} = Enum.split_with(editedList, &(&1 < pivot))
			quickSort(upper) ++ [pivot] ++ quickSort(lower)
		end

end

#------------------------------- Client
# Client.callServer(spawn(&Elixir_Intro.quickSortServer/0),[5,4,3,2,1])
defmodule Client do
    def callServer(pid,nums) do
        send(pid, {nums, self()})
	listen()
    end

    def listen do
      receive do
	    	{sorted, pid} -> sorted
			end
    end
end
