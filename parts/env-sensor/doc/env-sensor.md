# env-sensor
WiFi sensor unit to measure temperature, humidity, air pressure, and light level. Remotely powered from a Sensor Hub unit.

Why a separate (wireless) networked device? The sensor module uses a wire protocol that is not designed to work over long distances (greater than a couple of feet).  It is cheaper and easier to make a self-contained microcontroller+sensor unit than to find or invent a wire protocol that can run the lengths needed.  The MCU used is cheaper than the RS-485 modules used in the DMX controller part, for example.

That economics argument fails when the hardware to make the unit wired Ethernet is added -- the Ethernet module is among the more expensive modules.  Considering that the unit is a passive sensor (never needs to take action), and that dropped samples due to connectivity transience is not a mission-critical need, WiFi seems acceptable.