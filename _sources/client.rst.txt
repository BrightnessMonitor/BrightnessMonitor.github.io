Client
======

Client Software Design
----------------------

Das Project wurde mit einem Boilerplate :cite:`MendesPythonBoilerplate` gestartet. Und als installierbares Python
Paket entwickelt. Um den Client leicht zu installieren und zu updaten.
--> Todo Samu weiter machen

Verwendete Hardware
-------------------

--> Todo Smau

.. figure:: _static/img/raspberry-pi_01.jpg
    :alt: Software Design
    :align: center
    :scale: 10%

    Raspberry Pi mit Sensor

.. figure:: _static/img/raspberry-pi_02.jpg
    :alt: Software Design
    :align: center
    :scale: 10%

    Raspberry Pi mit Sensor

.. figure:: _static/img/raspberry-pi_03.jpg
    :alt: Software Design
    :align: center
    :scale: 10%

    Raspberry Pi mit Sensor

.. figure:: _static/img/hardware_01.jpg
    :alt: Software Design
    :align: center
    :scale: 10%

    Raspberry Pi mit Sensor


Sensoabfrage
------------

Aufbau
^^^^^^

Um die derzeitige Helligkeit zu erfassen wurde in unserem Versuchsaufbau ein Fotowiderstand GL5528 LDR, ein Kondensator
mit der Kapazität von einem Mikrofarad und 50 Volt Maximalspannung benutzt. Die negative Seite des Kondensators ist mit
der Masse des Raspberry Pi’s (im folgendem schwarzes Kabel) verbunden, die positive Seite ist mit einer Seite des
Fotowiderstands verbunden sowie an einen „GPIO“-Pin des Raspberry Pi’s (im folgendem blaues Kabel). Die andere Seite
des Fotowiderstands ist mit einem „GPIO’-Pin verbunden an dem eine 3,3 Volt Spannung anliegt (im folgendem rotes Kabel).
:cite:`RaspberryPiLDR`

.. figure:: _static/img/raspberry-pi-ldr-fotowiderstand.png
    :alt: Raspberry Pi LDR Fototwiderstand
    :align: center
    :scale: 100%

    Raspberry Pi LDR Fototwiderstand :cite:`RaspberryPiLDR`
    Quelle: http://krausix.de/raspberry-pi-ldr-fotowiderstand/

ErläuterungErläuterung
^^^^^^^^^^^^^^^^^^^^^^

Der Widerstand des Fotowiderstandes ist lichtabhängig und verändert sich bei unterschiedlicher Helligkeit. In einem
hellen Zustand ist der Widerstand größer (bei 10 Lux 8 ~ 20 K). In einem dunklen Zustand ist der Widerstand sehr gering
(bei 0 Lux 1 M Minimum).


Ein Kondensator im Gleichstromkreis lädt sich auf, bis seine Kapazität erreicht ist. Ist der Kondensator geladen
fließt kein Strom.

Funktionsweise
^^^^^^^^^^^^^^

Es läuft nun ein Strom durch den Fotowiderstand in den Kondensator, dieser lädt sich ungefähr bis zu ¾ seiner Kapazität
auf. Während dieses Vorgangs liegt kein Strom an blau an. In diesem Zeitraum wird ein Wert hochgezählt der später als
Ausgabe der Funktion gilt. Ist der Kondensator nun zu ¾ geladen, wird der Widerstand größer und der Strom beginnt über
das blaue Kabel zu fließen. Dies bemerkt der Raspberry Pi sofort und bricht den Vorgang ab. Der gezählte Wert wird in
unserem Fall in eine Datenbank zusammen mit der aktuellen Zeit abgelegt und wird später in den nächsten Ablaufschritt
übergeben.

.. code-block:: python
    :caption: Code-Ausschnitt Messwerterfassung :cite:`RaspberryPiLDR`
    :emphasize-lines: 3,5

    #!/usr/bin/env python

    timing = 0
    GPIOPIN = 11
    GPIO.setmode(GPIO.BCM)

    def RCtime (RCpin):
        reading = 0
        GPIO.setup(RCpin, GPIO.OUT)
        GPIO.output(RCpin, GPIO.LOW)
        time.sleep(0.1)

        GPIO.setup(RCpin, GPIO.IN)
        while (GPIO.input(RCpin) == GPIO.LOW):
            reading += 1
        return reading


Probleme
--------
--> Todo Samu

.. _hardware:

Verwendete Hardware
^^^^^^^^^^^^^^^^^^^

Das erste Problem stellt der Helligkeitsverlauf über einen Tag dar: umso rechtwinkliger die Sonne zum Standort, desto
intensiver wird das Licht. Daraus würden fehlerhafte Messdaten hervorgehen, denn z.B. eine Wolke die mittags die Sonne
verdeckt könnte äquivalent zu Sonnenschein nach dem Sonnenaufgang sein. Es muss also eine Justierung der Messdaten
stattfinden.