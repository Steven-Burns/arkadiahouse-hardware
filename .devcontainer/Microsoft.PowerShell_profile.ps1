$VerbosePreference = "Continue"

write-host ("sburns startup script at $PSCommandPath last updated {0:u}" -f (Get-ChildItem $PSCommandPath).LastWriteTime)

function global:rdir { Get-ChildItem -path . -recurse -include $args }

function global:fs { fgrep $args }
function global:rfs { fgrep -recurse $args }

$global:nogit=$true; try { $global:nogit = $(git --version).Length -eq 0 } catch {}

function prompt 
{
	$local:rawui = $host.ui.rawui
	$local:path = $(get-location).ToString()
	$local:maxPath = [int] $local:rawui.WindowSize.Width - 1
	if ($local:maxPath -lt 0) 
	{
		# will be -1 for powershell ISE
		$local:maxPath = 120
	}

	$local:rawui.ForegroundColor = "Gray"
	if ($local:path.length -gt $local:maxPath) 
	{ 
		$local:x = [int] [System.Math]::Max(0, $([int] $local:maxPath - 3))
		$local:path = '...' + $local:path.Substring(($local:path.length - $local:x), $local:x )
	}

	$local:counter = $(get-history -count 1 | foreach-object { $_.Id })
	$local:counter += 1

	if ($global:nestedPromptLevel -ne $() -and $global:nestedPromptLevel -ne 0)
	{
		$local:promptPrefix = '[{0}] ' -f $global:nestedPromptLevel
	}
	else
	{
		$local:promptPrefix = ''
	}

	$local:currentBranch = if (-not $global:nogit) { 
		$(git branch 2>$null | Where-Object { $_.StartsWith('*') })
	}

	if ($local:rawui.cursorposition.x -ne 0) { $host.ui.WriteLine() }
	$host.ui.Write(
		[ConsoleColor]::Yellow, 
		$local:rawui.BackgroundColor, 
		$("{2}{0:d} {3:yyyy-MM-dd HH:mm:ss K} ({4}) {1}`n>" -f $local:counter, $local:path, $local:promptPrefix, [datetime]::Now, $local:currentBranch) ) 
	' '
}

function global:ll { Get-ChildItem -Force $args }

#
# coda
#

$global:sburnsProfileRun = $true
write-host "sburns startup script done."


