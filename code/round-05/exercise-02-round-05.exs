defmodule Exercise2 do

  def ok!(what) do
    case what do
      { :ok, data } -> data
      _ -> raise "WTF!"
    end
  end

  def guarded_ok!({ :ok, data }), do: data
  def guarded_ok!(_), do: raise "WTF!"

end
