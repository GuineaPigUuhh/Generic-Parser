package;

import sys.io.File;
import generic_parser.GenericParser; 

class Main
{
    public static function main()
    {
        var content = File.getContent("testFile.txt");
        var coolParse = GenericParser.parse(content);
        trace(coolParse);
    }    
}