package generic_parser;

import generic_parser.utils.SimpleUtil;

using StringTools;

class GenericParser
{
	/**
	 * transform a string into a Object
	 * @param content
	 */
	public static function parse(content:String)
	{
		var data:Dynamic = {};
		for (line in content.split(','))
		{
			line = line.trim();
			var inVar = line.split("=");

			var varName:String = inVar[0].trim();
			var varValue:Dynamic = parseVar(inVar[1].trim());

			Reflect.setProperty(data, varName, varValue);
		}
		return data;
	}

     /**
	 * transforms a string into other Classes
	 * @param v Variable
	 */
	static function parseVar(v:String):Dynamic
	{
        switch (v.substring(0, v.length))
        {
            // Variables
            case 'nill': return null;
            case 'true': return true;
            case 'false': return false;
        }
        if (v.startsWith('"') && v.endsWith('"'))
            return v.replace('"', '');
        else if (SimpleUtil.containsArray(v,[0,1,2,3,4,5,6,7,8,9]))
        {
            var number:Dynamic = Std.parseInt(v);
            if (v.contains('.'))
                number = Std.parseFloat(v);
            return number;
        }

        return null;
	}
}
