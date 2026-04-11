# arkadiahouse-hardware
Circuit board and enclosure designs for Arkadia House

# pre-reqs

1. host computer running docker desktop.
1. host computer has cloned the repo on the host's local disk somewhere.
1. VSCode is installed on the host computer.

# bootstrapping

1. create a docker named volume named "arkadiahouse-docker-volume"
1. clone the repo into that volume at a folder named arkdiahouse-hardware
1. (The above steps are assumed to have been completed by the devcontainer.json file checked into this repo.)

# startup

1. Start docker desktop on the docker host computer.
1. Open VSCode on the host computer.
1. git pull origin main to refresh the host computer's repo
1. Use VSCode "Reopen in container" to attach to a container that will have a mount to the named volume created in the 'bootstrapping' step.
1. The devcontainer will offer a powershell (pwsh) terminal window option. That terminal configuration provides a command line in which ESPHome code can be built, deployed, etc.