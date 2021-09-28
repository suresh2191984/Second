using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Security.Cryptography;
using System.Web.Services;

/// <summary>
/// Summary description for OTP
/// </summary>
public class OTP
{
    public OTP()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public static readonly DateTime utc = new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc);
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public static string GetOTP(string userId)
    {
        long iteration = (long)(DateTime.UtcNow - utc).TotalSeconds;
        return GenerateOTP(userId, iteration);
    }

    public static string GenerateOTP(string userId, long iterationNumber)
    {
        int digits = 6;
        byte[] iterationNumberByte = BitConverter.GetBytes(iterationNumber);
        if (BitConverter.IsLittleEndian) Array.Reverse(iterationNumberByte);

        byte[] userIdByte = Encoding.ASCII.GetBytes(userId);
        HMACSHA1 userIdHMAC = new HMACSHA1(userIdByte, true);
        byte[] hash = userIdHMAC.ComputeHash(iterationNumberByte);

        int offset = hash[hash.Length - 1] & 0xf;
        int binary =
            ((hash[offset] & 0x7f) << 24)
            | ((hash[offset + 1] & 0xff) << 16)
            | ((hash[offset + 2] & 0xff) << 8)
            | (hash[offset + 3] & 0xff);

        int password = binary % (int)Math.Pow(10, digits);
        return password.ToString(new string('0', digits));
    }
}
