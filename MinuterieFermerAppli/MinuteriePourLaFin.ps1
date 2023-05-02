
param([int]$Seconds = 0, [string]$FullProgramName = "", [string]$ProgramName = "chrome", [string]$ProgramAliasName = "")

try {
	if ($Seconds -eq 0 ) { 
		[string]$ProgramName = Read-Host "Quel est le programme à fermer ?"
		[int]$Seconds = read-host "En combien de minutes?"
		$Seconds *= 60
	}

	for ($i = $Seconds; $i -gt 0; $i--) {
		Clear-Host
		Write-Output "$i seconds"
		Start-Sleep -seconds 1
	}
	
	##"$Seconds seconds countdown finished"

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
	
	exit 0 # success
} catch {
	"Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}


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
