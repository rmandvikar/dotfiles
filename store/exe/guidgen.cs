// https://stackoverflow.com/a/4313468/58678
// %WINDIR%\Microsoft.NET\Framework\v2.0.50727\csc.exe guidgen.cs
// %WINDIR%\Microsoft.NET\Framework\v4.0.30319\csc.exe guidgen.cs

using System;

class Program
{
    static void Main(string[] args)
    {
        string format = GetFormat(args);
        Console.WriteLine(Guid.NewGuid().ToString(format));
    }

    private static string GetFormat(string[] args)
    {
        string format = "D";
        if (args.Length >= 1)
        {
            string arg = args[0];
            if (arg.StartsWith("-"))
            {
                arg = arg.Substring(1);
            }

            format = arg;
        }
        return format;
    }
}
