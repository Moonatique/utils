IO.puts "Hola, would you like to rename some .jpg file?"
newFileName = IO.gets "What is your new file name?\n"
newFileName = String.replace(newFileName, "\n", "")

lastIndex = IO.gets "What is the last index you want start? just tap enter if 0\n"
lastIndex = String.replace(lastIndex, "\n", "")
lastIndex = cond do
  lastIndex == "" ->
    0
  true ->
    lastIndex |> Integer.parse |> elem(0)
end

File.ls!
  |> Enum.filter(&File.regular?/1)
  |> Enum.filter(
    fn fileName ->
      idx = fileName
        |> String.replace(~r/^.*-|\.jpg/, "")

      idx = case Integer.parse(idx) do
        {num, _} -> num
        _ -> -1
      end

      idx == -1 || idx >= lastIndex
    end
  )
  |> Enum.with_index
  |> Enum.each(
    fn {fileName, idx} ->
      File.rename "#{fileName}", "#{newFileName}-#{idx + lastIndex}.jpg"
    end
  )
