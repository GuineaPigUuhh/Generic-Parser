import sys.io.File;
import generic_parser.GenericParser;

class Test
{
	static function main()
	{
		var data:Dynamic = {};
		data = GenericParser.parseFile('testFile.txt');

		for (i in Reflect.fields(data))
		{
			var v = Reflect.getProperty(data, i);
			Sys.println('$i = $v');
		}
	}
}
