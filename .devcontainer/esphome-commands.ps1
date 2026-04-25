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

	if ($args.Count -eq 0 -or $command -notin @("compile", "run", "config", "upload")) 
	{
		throw "Usage: esphome-<command> <device yaml file> [<device yaml file> ...]"
	}

	foreach ($arg in $args)
	{
		$file = get-item $arg
		if ([String]::IsNullOrEmpty($file))
		{
			write-host "Skipping null/empty filename"
			continue	
		}
		write-host "Processing ESPHome configuration file $file"

		# derive the hostname from the file name, which is expected to be in the format <hostname>.yaml
		$hostname = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)

		esphome -s device_hostname $hostname $command $file
		if ($?) 
		{
			write-host "Successfully processed $file"
			if ($command -eq "compile")  # somewhat inelegant, so sue me.
			{
				write-host "Looking for compiled binaries for $hostname to copy to fab directory..."
				$binPath = "$($file.DirectoryName)\.esphome\build\$hostname\.pioenvs\$hostname\"
				foreach ($binfile in get-childitem $binPath -filter firmware.*.bin)
				{
					if ($binfile -ne $null) 
					{
						copy-item -verbose -path $binfile -destination "./fab/$hostname.$($binfile.BaseName).bin" -force
					}
					else
					{
						write-host "No binary files found for $hostname, skipping copy to fab directory."
					}
				}
			}
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


function esphome-upload
{
	param
	(
		[Parameter(Mandatory = $true, ValueFromRemainingArguments = $true, Position = 0)]
		[string[]]
		$args
	)

	do-esphome-command "upload" $args
}


function do-all-command
{
	param
	(
		[Parameter(Mandatory = $true, Position = 0)]
		[string]
		$command
	)
	
	$yamlFiles = get-childitem -path . -filter ???-*.yaml -recurse
	if ($yamlFiles.Count -eq 0)
	{
		throw "No YAML files found in the current directory or subdirectories."
	}

	$failed = @()
	foreach ($yamlFile in $yamlFiles)
	{
		write-host "Processing file: $($yamlFile.FullName)"
	
		trap 
		{ 
			write-host "Error processing file: $($yamlFile.FullName). "
			$failed += $yamlFile.FullName
			continue
		}
		do-esphome-command $command $yamlFile.FullName
	}

	if (($null -ne $failed) -and ($failed.Count -gt 0))
	{
		write-host "The following files failed to process:"
		foreach ($fail in $failed)
		{
			write-host $fail
		}
	}
}


function esphome-compile-all
{
	do-all-command "compile"
}	


function esphome-upload-all
{
	do-all-command "upload"
}