function do-esphome-command 
{
	param
	(
		[Parameter(Mandatory = $true, Position = 0)]
		[string]
		$command,

		[Parameter(Mandatory = $false, Position = 1)]
		[bool]
		$copyBinaries = $false,
		
		[Parameter(Mandatory = $true, ValueFromRemainingArguments = $true, Position = 2)]
		[string[]]
		$args
	)

	if ($args.Count -eq 0) 
	{
		throw "Usage: do-esphome-command> -command <command> -copyBinaries <true/false> <device yaml file> [<device yaml file> ...]"
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

		# derive the hostname from the file name, which is expected to be in the format <hostname>.<ignored.><ext>
		# this loop strips off all extensions.
		$before = $file.Name
		$bLen = 0; 
		do 
		{ 
			$bLen = $before.Length
			$after = [System.IO.Path]::GetFileNameWithoutExtension($before)
			$before = $after
		} while ($after.Length -ne $bLen)  
		$hostname = $after
		write-verbose "Derived hostname '$hostname' from file name '$($file.Name)'"

		esphome -s device_hostname $hostname $command $file
		if ($?) 
		{
			write-host "Successfully processed $file"
			if ($copyBinaries)
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
						write-host "No binary files found for $hostname, skipping copy to fab folder."
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

	do-esphome-command -command "compile" -copyBinaries $true $args
}

function esphome-run
{
	param
	(
		[Parameter(Mandatory = $true, ValueFromRemainingArguments = $true, Position = 0)]
		[string[]]
		$args
	)

	do-esphome-command -command "run" -copyBinaries $true $args
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
		throw "No YAML files found in the current folder or subfolders."
	}

	$failed = @()
	foreach ($yamlFile in $yamlFiles)
	{
		write-host "Processing file: $($yamlFile.FullName)"
	
		trap 
		{ 
			write-host "Error processing file: $($yamlFile.FullName). "
			$failed += @($yamlFile.FullName)
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