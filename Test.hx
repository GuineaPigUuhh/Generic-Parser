import generic_parser.GenericParser;

class Test
{
	static function main()
	{
		var data:Dynamic = GenericParser.parseFile('file.txt');

		for (i in Reflect.fields(data))
			Sys.println('$i: ${Reflect.getProperty(data, i)}');
	}
}
