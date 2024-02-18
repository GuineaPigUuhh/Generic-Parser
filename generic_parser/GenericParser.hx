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
        
        var split = content.split(",");
        for(line in split)
        {
            line = line.trim();
            var inVar = line.split("=");

            var varName:String = inVar[0].trim();
            var varValue:Dynamic = inVar[1].trim();
            var varType:String = indentifyType(varValue);

            var v_s:String = cast varValue;
            varValue = v_s.replace(',', '');
            switch (varType)
            {
                case "string":
                    var remakeString = v_s.replace('"', '');
                    varValue = remakeString;
                case "bool":
                    var v_b:Bool = cast (varValue == "true");
                    varValue = v_b;
                case "number":
                    if(v_s.contains("."))
                    {    
                        var v_n:Float = cast Std.parseFloat(varValue);
                        varValue = v_n; 
                    }    
                    else
                    {
                        var v_n:Int = cast Std.parseInt(varValue);
                        varValue = v_n; 
                    }   
            }
            Reflect.setProperty(data, varName, varValue);
        }    

        return data;
    }

    static function indentifyType(v:Dynamic)
    {   
        var v_s:String = cast v;

        if (v_s.startsWith('"') && v_s.endsWith('"'))
            return "string";
        else if (v_s == "true" || v_s == "false")
            return "bool";
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