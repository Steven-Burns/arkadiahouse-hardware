# sensor hub
Seems to me that a wired hub-and-spoke topology for a network of sensors is a much better setup than home-running a million wires to a central location, or using unreliable and slow WiFi.

```mermaid
graph TB;
    building-central-switch===wire((CAT6A))
    wire===wall-station
    wall-station===poe((CAT6A PoE))
    poe===hub
    hub---wiring-harness
    hub---keypad
    wiring-harness---env-sensor
    wiring-harness---radar0
    wiring-harness---radar1
    wiring-harness---door-sensor0
    wiring-harness---door-sensor1
    wiring-harness---door-lock0
    wiring-harness---door-lock1
    subgraph Hub Enclosure
        hub
        wiring-harness
        keypad
    end
```