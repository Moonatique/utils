IO.puts "Hola, would you like continue to rename some files? If NOT tap ctrl + c"
newFileName = IO.gets "What is your new file name?\n"
newFileName = String.replace(newFileName, "\n", "")

File.ls!
  |> Enum.filter(&File.regular?/1)
  |> Enum.with_index
  |> Enum.each(
    fn {fileName, idx} ->
      ext = fileName
        |> String.replace(~r/^.*\./, "")

      File.rename "#{fileName}", "#{newFileName}-#{idx + 1}.#{ext}"
    end
  )

IO.puts "\nFiles have been weel renamed.\n"
File.ls!
  |> Enum.filter(&File.regular?/1)
  |> Enum.map(&IO.puts &1)
