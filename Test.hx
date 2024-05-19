import generic_parser.GenericParser;

class Test
{
	static function main()
	{
		var data:Dynamic = GenericParser.parseFile('testFile.txt');

		for (i in Reflect.fields(data))
		{
			var v = Reflect.getProperty(data, i);
			Sys.println('$i = $v');
		}
		trace(data.object.name);
		trace(data.object.price / 2);
	}
}
