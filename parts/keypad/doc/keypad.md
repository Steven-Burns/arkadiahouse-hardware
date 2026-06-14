# keypad

Clicky and retro-styled.


interesting ideas to explore:

- creating a binary sensor that represents the click, double click, and pressed states of each key
(see https://github.com/AeroSteveO/EspDeck/blob/main/espdeck/keypad3.yaml)
- using matrix keypad.  Maybe not applicable to this design, as it would need to run 3x4 wires to the MCU
- using key collector to gather a sequence of keypresses as a command
- using one key as a 'shift' modifier -- hold shift + other keys to increase unique keypresses

    shift + key 1 -- reboot device
    shift + key 2 -- dump more debug info onto the display
    display brightness up/down
    play a test tone
    set mode where tone and tempo indicates proximity like aliens bug radar 