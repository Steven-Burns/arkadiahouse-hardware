# stuff to do, someday

Revise the design of the keypad to use the interrupt-driven feature of the pin extender.  See https://esphome.io/changelog/2026.4.0/#gpio-expander-interrupt-support

Figure out the KiCad command line and do fully automated command-line builds using the KiCad container.  See https://hub.docker.com/r/kicad/kicad

Automate the workflow for a "release" -- probably something along the lines of:
    * creating a git branch representing the release
    * building in some build pipeline workflow thingy , 
    * doing some sort of testing (heh), 
    * checking in the built binaries for archival
    * flashing all the devices

Using some fancypants internet-hosted workflow engine like GitHub or Azure DevOps or whatever would be the trendy thing to do, but more dependencies that I will forget the details of maintaining does not seem like a win over a locally run script.
 