This is how the YAML is factored to make it easier to produce 'standardized' builds of various boards, where as much 'standarization' as possible is pushed to the lowest layer (topmost in this diagram).

```mermaid
graph TD;
    esp32-device-baseline-->wemos-d1-mini-baseline;
    wemos-d1-mini-baseline-->wemos-d1-mini-wifi-baseline;
    wemos-d1-mini-baseline-->wemos-d1-mini-wired-baseline;
```

Each layer specializes the previous layer.
