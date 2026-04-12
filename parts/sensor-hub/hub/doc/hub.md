# sensor hub
Seems to me that a wired hub-and-spoke topology for a network of sensors is a much better setup than home-running a million wires to a central location, or using unreliable and slow WiFi.


```mermaid
graph TB
    building-central-switch===wall-station-0
    building-central-switch===wall-station-1
    building-central-switch===wall-station-2
    wall-station-0===hub-0
    wall-station-1===hub-1
    wall-station-1===hub-2
    wall-station-2===hub-3
```

```mermaid
graph TB
    building-central-switch==ETH-CAT6A===wall-station-switch

    subgraph Wall Station Enclosure
        wall-station-switch
        DMX-controller
    end
    wall-station-switch==ETH-CAT6A PoE===hub
    wall-station-switch==ETH-CAT6A===DMX-controller

    subgraph Hub Enclosure
        hub
        wiring-harness
        keypad
    end
    hub---wiring-harness
    hub---keypad
    wiring-harness--CAT6A---env-sensor
    wiring-harness--CAT6A---radar0
    wiring-harness--CAT6A---radar1
    wiring-harness--CAT6A---door-sensor0
    wiring-harness--CAT6A---door-sensor1
    wiring-harness--CAT6A---door-lock0
    wiring-harness--CAT6A---door-lock1

    DMX-controller--DMX-CAT6A---DMX-decoder0
    DMX-decoder0---DMX-decoder1
    DMX-decoder1---DMX-decoder2
    DMX-decoder2---DMX-decoder3
    DMX-decoder3-.-DMX-decoderN
```
