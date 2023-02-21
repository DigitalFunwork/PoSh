$code = @"
using System;
using System.IO;

namespace ProcessLargeFile
{
    public class Program
    {
        static void ProcessLine(string line)
        {
            return;
        }

        public static void ProcessLogFile(string path) {
            var start_time = DateTime.Now;
            StreamReader sr = new StreamReader(File.Open(path, FileMode.Open));
            try {
                while (!sr.EndOfStream){
                    string line = sr.ReadLine();
                    ProcessLine(line);
                }
            } finally {
                sr.Close();
            }
            var end_time = DateTime.Now;
            var run_time = end_time - start_time;
            string msg = "Completed in " + run_time.Minutes + ":" + run_time.Seconds + "." + run_time.Milliseconds;
            Console.WriteLine(msg);
        }

        static void Main(string[] args)
        {
            ProcessLogFile("c:\\users\\tasaif\\fake.log");
            Console.ReadLine();
        }
    }
}
"@
 
Add-Type -TypeDefinition $code -Language CSharp

<#
Usage:
PS >[ProcessLargeFile.Program]::ProcessLogFile("c:\\temp\\Mylarge10Gb.log")
#>
