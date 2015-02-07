module ApplicationHelper
	def line_to_color(name)
		{
			"456" => "green",
			"123" => "red",
			"7" => "purple",
			"ACE" => "blue",
			"BDFM" => "orange",
			"G" => "light-green",
			"JZ" => "brown",
			"L" => "grey",
			"NQR" => "yellow",
			"S" => "grey",
			"SIR" => "blue"
			}[name]
	end
end
