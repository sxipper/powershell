Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
//using System.Threading;

public class IdlePrevention 
{
    [DllImport("user32.dll")]
    public static extern void keybd_event(byte bVk, byte bScan, uint dwFlags, UIntPtr dwExtraInfo);

    public const int KEYEVENTF_EXTENDEDKEY = 0x0001;
    public const int KEYEVENTF_KEYUP = 0x0002;

    public static void PreventIdle() 
    {
        keybd_event(0x91, 0, KEYEVENTF_EXTENDEDKEY, UIntPtr.Zero); // Press Scroll Lock
        keybd_event(0x91, 0, KEYEVENTF_EXTENDEDKEY | KEYEVENTF_KEYUP, UIntPtr.Zero); // Release Scroll Lock
        //Thread.Sleep(55000); // Wait for 60 seconds before sending the next keystroke
    }
}
"@
#[int]$i = 0
<#while ((Get-Date).Hour -le 19)
{
    [IdlePrevention]::PreventIdle()
    Start-Sleep -seconds 55
}#>
while (1 -eq 1)
{
    [IdlePrevention]::PreventIdle()
    Start-Sleep -seconds 55
}