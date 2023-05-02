
param([string]$FullProgramName = "", [string]$ProgramName = "chrome", [string]$ProgramAliasName = "")

try {
	if ($ProgramName -eq "") {
		get-process | where-object {$_.mainWindowTitle} | format-table Id, Name, mainWindowtitle -AutoSize
		$ProgramName = read-host "Enter program name"
	}
	if ($FullProgramName -eq "") {
		$FullProgramName = $ProgramName
	}

	$Processes = get-process -name $ProgramName -errorAction 'silentlycontinue'
	if ($Processes.Count -ne 0) {
		foreach ($Process in $Processes) {
			$Process.CloseMainWindow() | Out-Null
		} 
		Start-Sleep -milliseconds 100
		stop-process -name $ProgramName -force -errorAction 'silentlycontinue'
	} else {
		$Processes = get-process -name $ProgramAliasName -errorAction 'silentlycontinue'
		if ($Processes.Count -eq 0) {
			throw "$FullProgramName isn't running"
		}
		foreach ($Process in $Processes) {
			$_.CloseMainWindow() | Out-Null
		} 
		Start-Sleep -milliseconds 100
		stop-process -name $ProgramName -force -errorAction 'silentlycontinue'
	}
	if ($($Processes.Count) -eq 1) {
		"$FullProgramName closed, 1 process stopped"
	} else {
		"$FullProgramName closed, $($Processes.Count) processes stopped"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}