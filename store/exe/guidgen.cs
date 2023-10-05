// https://stackoverflow.com/a/4313468/58678
// %WINDIR%\Microsoft.NET\Framework\v2.0.50727\csc.exe guidgen.cs
// %WINDIR%\Microsoft.NET\Framework\v4.0.30319\csc.exe guidgen.cs

using System;
using System.Text;

class Program
{
    static void Main(string[] args)
    {
        string format = GetFormat(args);
        Console.WriteLine(Format(Guid.NewGuid(), format));
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

    private static string Format(Guid guid, string format)
    {
        if (string.Equals(format, "64u", StringComparison.OrdinalIgnoreCase))
        {
            return guid.ToByteArrayMatchingStringRepresentation().Base64UrlEncode();
        }
        if (string.Equals(format, "64", StringComparison.OrdinalIgnoreCase))
        {
            return guid.ToByteArrayMatchingStringRepresentation().Base64Encode();
        }
        return guid.ToString(format);
    }
}

/// <summary>
/// Guid extensions.
/// </summary>
public static class GuidExtension
{
    /// <summary>
    /// Returns a 16-element byte array that contains the value of this instance
    /// matching its string representation (endian-agnostic).
    /// <para></para>
    /// See https://stackoverflow.com/questions/9195551/why-does-guid-tobytearray-order-the-bytes-the-way-it-does
    /// <remarks>
    /// <para></para>
    /// Note: The byte[] returned by <see cref="ToByteArrayMatchingStringRepresentation(Guid)"/> will not yield
    /// the original Guid with <see cref="Guid(byte[])"/> ctor.
    /// </remarks>
    /// </summary>
    public static byte[] ToByteArrayMatchingStringRepresentation(this Guid guid)
    {
        var bytes = guid.ToByteArray();
        TweakOrderOfGuidBytesToMatchStringRepresentation(bytes);
        return bytes;
    }

    /// <summary>
    /// Initializes a new instance of the <see cref="Guid"></see> structure by using the specified array of bytes
    /// matching its string representation (endian-agnostic).
    /// <para></para>
    /// See https://stackoverflow.com/questions/9195551/why-does-guid-tobytearray-order-the-bytes-the-way-it-does
    /// <remarks>
    /// <para></para>
    /// Note: The Guid returned by <see cref="ToGuidMatchingStringRepresentation(byte[])"/> will not yield
    /// the original byte[] with <see cref="Guid.ToByteArray()"/>.
    /// </remarks>
    /// </summary>
    public static Guid ToGuidMatchingStringRepresentation(this byte[] bytes)
    {
        if (bytes == null)
        {
            throw new ArgumentNullException("bytes");
        }
        if (bytes.Length != 16)
        {
            throw new ArgumentException("Length should be 16.", "bytes");
        }
        TweakOrderOfGuidBytesToMatchStringRepresentation(bytes);
        return new Guid(bytes);
    }

    private static void TweakOrderOfGuidBytesToMatchStringRepresentation(byte[] guidBytes)
    {
        if (BitConverter.IsLittleEndian)
        {
            Array.Reverse(guidBytes, 0, 4);
            Array.Reverse(guidBytes, 4, 2);
            Array.Reverse(guidBytes, 6, 2);
        }
    }
}

/// <summary>
/// Base64 extensions.
/// </summary>
public static class Base64Extension
{
    public static string Base64Encode(this byte[] bytes)
    {
        return Convert.ToBase64String(bytes);
    }

    public static byte[] Base64Decode(this string base64)
    {
        return Convert.FromBase64String(base64);
    }

    public static string Base64UrlEncode(this byte[] bytes)
    {
        var base64 = bytes.Base64Encode();
        return new StringBuilder(base64)
            .Replace('+', '-')
            .Replace('/', '_')
            .Replace("=", "")
            .ToString();
    }

    public static byte[] Base64UrlDecode(this string base64Url)
    {
        const int maxPad = 4;
        var pad = new string('=', (maxPad - (base64Url.Length %maxPad)) %maxPad);
        return new StringBuilder(base64Url)
            .Replace('-', '+')
            .Replace('_', '/')
            .Append(pad)
            .ToString()
            .Base64Decode();
    }
}
