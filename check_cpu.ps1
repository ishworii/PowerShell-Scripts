function GetTemperature {
   $Objects = Get-WmiObject -Query "SELECT * FROM Win32_PerfFormattedData_Counters_ThermalZoneInformation" -Namespace "root/CIMV2"
   foreach ($Obj in $Objects) {
      $HiPrec = $Obj.HighPrecisionTemperature
      $Temp = [math]::round($HiPrec / 100.0 , 1)
   }
   return $Temp;
}

try {
   Write-Progress "Querying CPU details..."
   $Celsius = GetTemperature
   $Details = Get-WmiObject -Class Win32_Processor
   $CPUName = $Details.Name.trim()
   $DeviceID = "$($Details.DeviceID), "
   $ClockSpeed = "$($Details.MaxClockSpeed) MHz, "
   $Socket = "$($Details.SocketDesignation) socket, "
   $Cores = [System.Environment]::ProcessorCount
   Write-Progress -Completed "done..."
   Write-Host "$CPUName ($Cores cores, $($DeviceID)$($ClockSpeed)$($Socket)$Celsius C)"
}
catch {
   "Error in Line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
   exit 1
}