package generic_parser;

using StringTools;

class GenericParser
{


    /**
     * transform a string into a Data
     * @param content
     */
    public static function parse(content:String)
    {
        var data:Dynamic = {};
        
        var split = content.split(',');
        for(line in split)
        {
            line = line.trim();
            var inVar = line.split("=");
            if (inVar.length <= 1)
                return {};

            var varName:String = inVar[0].trim();
            var varValue:Dynamic = inVar[1].trim();
            var varType:String = indentifyType(varValue);

            switch (varType)
            {
                default:
                    varValue = formatVarInParse(varType, cast varValue);
                case 'array':
            }
            Reflect.setProperty(data, varName, varValue);
        }    

        return data;
    }
    
    static function formatVarInParse(type:String, vString:String):Dynamic {
        switch (type)
        {
            case "string":
                return vString.replace('"', '');
            case "bool":
                return cast (vString == "true");
            case "number":
                if(vString.contains("."))
                    return cast Std.parseFloat(vString);  
                else
                    return cast Std.parseInt(vString);
        }
        trace("Error on Parse the String");
        return vString = "Error on Parse the String";
    }

    static function indentifyType(v:Dynamic)
    {   
        var v_s:String = cast v;

        if (v_s.startsWith('"') && v_s.endsWith('"'))
            return "string";
        else if (v_s == "true" || v_s == "false")
            return "bool";
        else if (v_s.startsWith('[') && v_s.endsWith(']'))
            return "array";
        else 
        {
            for (i in 0...9)
            {
                if (v_s.startsWith(Std.string(i)))
                {
                    return "number";
                }    
            }    
        }
        return "unknown";
    }    
}