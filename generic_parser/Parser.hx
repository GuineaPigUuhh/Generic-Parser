package generic_parser;

import sys.io.File;

using StringTools;

class Parser
{
	public var content:String = null;

	private var charI:Int = -1;

	private final endPrefix:String = ';';
	private final valuePrefix:String = ':';

	public function new(content:String)
	{
		this.content = content;
	}

	public function parseFile()
	{
		try
		{
			content = File.getContent(content);
		}
		catch (e)
		{
			trace('file not found: $e');
		}
		return parse();
	}

	public function parse()
	{
		var data:Dynamic = {};

		var this_variable:String = '';
		while (++charI <= content.length)
		{
			var char = content.charAt(charI);

			if (char == endPrefix)
			{
				this_variable = "";
				continue;
			}
			if (char == valuePrefix)
			{
				Reflect.setProperty(data, this_variable.trim(), parseValue());
				this_variable = "";
				continue;
			}

			this_variable += char;
		}

		return data;
	}

	var numberRegex = ~/[0-9]/;

	private function parseValue():Dynamic
	{
		var this_str:String = '';

		var isString:Bool = false;
		var stringNUM:Int = 0;
		while (++charI <= content.length)
		{
			var char = content.charAt(charI);
			if (char == "'")
			{
				stringNUM++;
				if (stringNUM == 2)
					isString = true;
				continue;
			}
			if (stringNUM == 0 || stringNUM == 2)
				if (char == endPrefix)
					break;
			this_str += char;
		}

		if (isString)
			return this_str.trim();

		var lown = this_str.toLowerCase().trim();
		if (lown == "true")
			return true;
		else if (lown == "false")
			return false;

		if (lown == "nil")
			return null;

		if (numberRegex.match(this_str))
			return Std.parseFloat(this_str);

		return null;
	}
}
