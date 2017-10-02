defmodule Utils do
  def fastFileRenamer(newFileName) do
    File.ls!
      |> Enum.filter(&File.regular?/1)
      |> Enum.with_index
      |> Enum.each(&rename_with_index &1, newFileName)
  end

  defp rename_with_index({fileName, idx}, newFileName) do
    ext = fileName
      |> String.replace(~r/^.*\./, "")

    File.rename "#{fileName}", "#{newFileName}-#{idx + 1}.#{ext}"
  end
end

IO.puts "Hola, would you like continue to rename some files? If NOT tap ctrl + c"
newFileName = IO.gets "What is your new file name?\n"
newFileName = String.replace(newFileName, "\n", "")

Utils.fastFileRenamer(newFileName)

IO.puts "\nFiles have been weel renamed.\n"
File.ls!
  |> Enum.filter(&File.regular?/1)
  |> Enum.map(&IO.puts/1)
