# arkadiahouse-hardware
Circuit board, enclosures, and firmware for Arkadia House.

# pre-reqs

1. Host computer running Docker Desktop.
1. Host computer has cloned the repo on the host's local disk somewhere.
1. VSCode is installed on the host computer.

# bootstrapping

Create a docker named volume named "arkadiahouse-docker-volume"
```DOS
docker volume create arkadiahouse-docker-volume
```
Clone the repo into that volume at a folder named arkdiahouse-hardware. That folder will be mounted as /workspace when the container is run.

```DOS
docker run --interactive --user root --volume arkadiahouse-docker-volume:/clone-destination --rm cleanstart/git:latest clone https://github.com/Steven-Burns/arkadiahouse-hardware.git /clone-destination/arkadiahouse-hardware --verbose
```

(The above steps are assumed to have been completed by the devcontainer.json file checked into this repo.)

# startup

Start docker desktop on the docker host computer.

Open VSCode on the host computer.

Refresh the host computer's repo

```DOS
git pull origin main 
```

Use VSCode "Reopen in container" to attach to a container that will have a mount to the named volume created in the 'bootstrapping' step.

The devcontainer will offer a powershell (pwsh) terminal window option. That terminal configuration provides a command line in which ESPHome code can be built, deployed, etc.

