package generic_parser;

using StringTools;

class GenericParser
{
	public static function parse(content:String):Dynamic
	{
		return new Parser(content).parse();
	}

	public static function parseFile(file:String):Dynamic
	{
		return new Parser(file).parseFile();
	}
}
