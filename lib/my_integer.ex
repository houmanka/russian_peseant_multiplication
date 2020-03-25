defmodule MyInteger do
  defguard is_valid(value) when is_number(value) and value > 0
end
