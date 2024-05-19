package generic_parser;

import sys.io.File;

using StringTools;

class Parser
{
	public var content = '';

	private var i = -1;

	private final endPrefix = ';';
	private final valuePrefix = ':';

	public var variables:Map<String, Dynamic> = ["true" => true, "false" => false, "nil" => null];

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

		var str:String = '';
		while (++i <= content.length)
		{
			var char = content.charAt(i);

			if (char == valuePrefix)
			{
				Reflect.setProperty(data, str.trim(), parseValue());
				str = "";
				continue;
			}
			str += char;
		}

		return data;
	}

	private function parseValue():Dynamic
	{
		var str:String = '';

		var realArray:Array<Dynamic> = [];
		while (++i <= content.length)
		{
			var char = content.charAt(i);

			if (char == endPrefix)
			{
				if (content.charAt(i - 1) == ']')
					return parseArray(str);
				return parseLiteral(str);
			}
			str += char;
		}
		return null;
	}

	var numberRegex = ~/[0-9]/;

	private function parseLiteral(str:String):Dynamic
	{
		str = str.trim();

		if (variables.exists(str))
			return variables.get(str);
		if ((str.charAt(0) == '"' || str.charAt(0) == "'") && str.charAt(str.length - 1) == str.charAt(0))
			return str.substr(1, str.length - 2);
		if (numberRegex.match(str))
			return Std.parseFloat(str);

		return str;
	}

	private function parseArray(str:String):Array<Dynamic>
	{
		str = str.trim();
		var strList = str.substr(1, str.length - 2).split(',');
		return [for (i in strList) parseLiteral(i)];
	}
}
