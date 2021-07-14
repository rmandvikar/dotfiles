// https://stackoverflow.com/a/4313468/58678
// %WINDIR%\Microsoft.NET\Framework\v2.0.50727\csc.exe guidgen.cs

class Program
{
	static void Main(string[] args)
	{
		System.Console.WriteLine(System.Guid.NewGuid().ToString());
	}
}
