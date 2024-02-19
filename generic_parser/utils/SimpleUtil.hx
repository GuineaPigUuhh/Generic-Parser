package generic_parser.utils;

using StringTools;

class SimpleUtil {
    public static function containsArray(s:String, array:Array<Dynamic>):Bool
    {
        for (i in array)
        {
            i = Std.string(i);
            if(s.contains(i))
            {
                return true;
            }    
        }    
        return false;
    }    
}