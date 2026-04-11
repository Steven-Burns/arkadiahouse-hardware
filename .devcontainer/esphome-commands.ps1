function do-esphome-command 
{
	param
	(
		[Parameter(Mandatory = $true, Position = 0)]
		[string]
		$command,
		
		[Parameter(Mandatory = $true, ValueFromRemainingArguments = $true, Position = 1)]
		[string[]]
		$args
	)

	if ($args.Count -eq 0 -or $command -notin @("compile", "run", "config")) 
	{
		throw "Usage: esphome-<command> <device yaml file> [<device yaml file> ...]"
	}

	foreach ($arg in $args)
	{
		$file = get-item $arg
		if ($file -eq $null)
		{
			throw "File $arg not found."	
		}
		write-host "Processing ESPHome configuration file $file"

		# derive the hostname from the file name, which is expected to be in the format <hostname>.yaml
		$hostname = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)

		esphome -s device_hostname $hostname $command $file
		if ($?) 
		{
			write-host "Successfully processed $file"
			copy-item -verbose -path "$($file.DirectoryName)\.esphome\build\$hostname\.pioenvs\$hostname\firmware.ota.bin" -destination "./fab/$hostname.bin" -force
		}
		else
		{
			throw "Failed to process $file"
		}
	}
}

function esphome-compile
{
	param
	(
		[Parameter(Mandatory = $true, ValueFromRemainingArguments = $true, Position = 0)]
		[string[]]
		$args
	)

	do-esphome-command "compile" $args
}

function esphome-run
{
	param
	(
		[Parameter(Mandatory = $true, ValueFromRemainingArguments = $true, Position = 0)]
		[string[]]
		$args
	)

	do-esphome-command "run" $args
}

function esphome-config
{
	param
	(
		[Parameter(Mandatory = $true, ValueFromRemainingArguments = $true, Position = 0)]
		[string[]]
		$args
	)

	do-esphome-command "config" $args
}
