// https://web.archive.org/web/20131124234800/http://huddledmasses.org/clipexe-and-the-missing-pasteexe
// %WINDIR%\Microsoft.NET\Framework\v2.0.50727\csc.exe /out:vlip.exe paste.cs
// %WINDIR%\Microsoft.NET\Framework\v4.0.30319\csc.exe /out:vlip.exe paste.cs

using System;
using System.Threading;
using System.Windows.Forms;

public class Program
{
	[STAThread]
	static void Main(string[] args)
	{
		string[] lines = Clipboard.GetText().Split(new string[] { "\r\n", "\n" }, StringSplitOptions.None);
		foreach (string line in lines)
		{
			Console.WriteLine(line);
		}
	}
}
