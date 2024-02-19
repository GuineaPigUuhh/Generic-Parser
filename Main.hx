package;

import sys.io.File;
import generic_parser.GenericParser; 

typedef Chars = {
    var dog:Bool;
    var cat:Bool;
} 

class Main
{
    public static function main()
    {
        var content = File.getContent("testFile.txt");
        var coolParse = GenericParser.parse(content);
        trace(coolParse);
    }    
}