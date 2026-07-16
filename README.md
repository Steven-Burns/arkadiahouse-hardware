# arkadiahouse-hardware
Circuit board, enclosures, and firmware for Arkadia House.

This repo hosts both ESPHome firmware configuration and KiCad circuit diagram "source code," along with Sketchup models.  As the bulk of the "programming" happens with the firmware, the devcontainer setup is oriented toward coding/building/debugging with ESPHome.

# pre-reqs

1. Host computer running Docker Desktop.
1. Host computer has cloned the repo on the host's local disk somewhere.
1. VSCode is installed on the host computer.

# bootstrap prep

Complete these steps once, before the steps in the section 'startup.'

Create a docker named volume named "arkadiahouse-docker-volume".

```DOS
docker volume create arkadiahouse-docker-volume
```

Clone the repo into that volume at a folder named arkdiahouse-hardware. That folder will be mounted as /workspace when the container is run.

```DOS
docker run --interactive --user root --volume arkadiahouse-docker-volume:/clone-destination --rm cleanstart/git:latest clone https://github.com/Steven-Burns/arkadiahouse-hardware.git /clone-destination/arkadiahouse-hardware --verbose
```

The devcontainer.json file checked into this repo assumes that the above have been completed before VS Code attempts to open the project in a container.

# startup

Start docker desktop on the docker host computer.

Open VSCode on the host computer.

Refresh the host computer's repo

```DOS
git pull origin main 
```

Use VSCode "Reopen in container" to attach to a container that will have a mount to the named volume created in the 'bootstrapping prep' step.  If opening in container fails, check to make sure you cloned the repo in the named volume exactly as described in 'the bootstrapping prep' step.

The devcontainer will offer a powershell (pwsh) terminal window option. That terminal configuration provides a command line in which ESPHome code can be built, deployed, etc.

# bootstrap coda

Complete this step once, after starting up the VS Code session at least once.

Copy/create the secrets.yaml file to /include/secrets.yaml (in the container volume's cloned repo). There is a template example /include/secrets.example.yaml in case you need to create a new one from scratch. The actual secrets.yaml is not version-controlled and is git-ignored.

If you have a secrets.yaml file on a cloned repo outside the container, note that the devcontainer.json configures a volume mount to the host's c:\temp folder.  The mount is /host/temp

# batch building

PowerShell to the rescue.

```DOS
dir ???-*.yaml | % { esphome compile $_ }
```

# flashing

## option 1

Use esphome's over-the-air updater: esphome upload or esphome run to flash a single device.

## option 2

Flash the "factory" .bin file (the one that has "factory" in the filename) with esptool.  Run this on the host to which the board is connected via USB.  This will flash to the first detected COM port with an ESP32 attached.

```DOS
esptool write-flash 0 <flash-factory-file.bin>
```

## option 3

Use https://adafruit.github.io/Adafruit_WebSerial_ESPTool/ to write a particular .bin via a COM port.  This is a useful option for 'bricked' devices that are not responding to over-the-air updates

# updating the esphome version on an existing cloned repo

## option 1

pip3 install esphome --upgrade

## option 2

some docker incantation that will rebuild the container image. That might even be preferable to option 1 for hygenic reasons.

Since the repo is cloned to a docker named volume, rebuilding the image should not torch the cloned repo.