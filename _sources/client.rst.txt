Client
======

Software
--------

Grundkonzept
^^^^^^^^^^^^

Die Hauptaufgabe der Client-Software ist es, die Messwerte, wie in :ref:`ClientErlauterung` beschrieben, zu sammeln und
anschließend an den Server zu verschicken.


Helligkeitsmessung
^^^^^^^^^^^^^^^^^^

Die Helligkeit wird gemessen und anschließend in einer lokalen Datenbank hinterlegt. Dieser Vorgang erfolgt alle 5
Sekunden. Da der Server den Durchschnitt eines Tages berechnet, würden Messdaten, die vor dem Sonnenaufgang bzw. nach
dem Sonnenuntergang erhoben wurden, das Ergebnis verfälschen. Um diese Problematik zu lösen werden Messwerte verwendet,
die vom Sonnenaufgang bis zum Sonnenuntergang erhoben wurden. Um diesen Zeitraum zu ermitteln haben wir eine Formel
:cite:`MichelSunriseAndSunset` verwendet, die anhand des Höhen- und Breitengrades, den Sonnenaufgang und den Sonnenuntergang
eines Tages berechnen kann. Diese Berechnung erfolgt alle 5 Minuten in einem eigenen Thread um die CPU-Auslastung zu
senken.


Versenden der Daten
^^^^^^^^^^^^^^^^^^^

Die Datenbank wird im 5 Minuten Intervall ausgelesen und die Daten werden an den Server übermittelt. Anschließend
werden alle Einträge der Datenbank gelöscht. Dieser Vorgang erfolgt jedoch nur dann, wenn auch eine aktive Verbindung
mit dem von uns verwendeten Server über das Internet vorhanden ist. Sollte dies nicht der Fall sein, überspringt die
Software den Vorgang und wartet 5 Minuten bis zum nächsten Versuch.

Probleme
--------

Verwendete Hardware
^^^^^^^^^^^^^^^^^^^

Mit einem Kondensator der mehr Kapazität besitzt, würden die Messergebnisse bei starker Helligkeit (in dem von uns
beobachteten Zeitraum von 11:00 bis 14:00 an sonnigen Tagen) genauer werden, da eine längere Zeit von Nöten wäre um
ihn aufzuladen. Über den oben beschriebenen Zeitraum hatten wir Messwerte von „0“ was „sehr hell“ entspricht. Auf
Grund dessen sind unsere Statistiken teils nicht aussagekräftig.

Auch orientieren sich unsere Messwerte an keiner physikalischen Größe, sodass man diese nicht für andere Zwecke
weiterverwenden könnte. Es gibt jedoch Module, die genauere Messwerte liefern bzw. die Helligkeit in Lux ausgeben
können.

.. _hardware:

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

Helligkeitsverlauf über den Tag
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Das nächste Problem stellt der Helligkeitsverlauf über einen Tag dar: umso rechtwinkliger die Sonne zum Standort,
desto intensiver wird das Licht. Daraus würden fehlerhafte Messdaten hervorgehen, denn z.B. eine Wolke die mittags
die Sonne verdeckt könnte äquivalent zu Sonnenschein nach dem Sonnenaufgang sein. Es muss also eine Justierung der
Messdaten stattfinden. Wir haben eine Formel :cite:`ForumFormelGlobalstrahlung` gefunden, die die absolute Helligkeit unter Angabe des
Standpunktes, des Datums sowie der Zeit, ausgibt. Die Maßeinheit ist Solarimeter (W/m2), welche man zu Lux umrechnen
kann. Die Justierung der Messdaten wurde mangels Zeit nicht implementiert. Unter Verwendung genauerer Messgeräte und
mit Hilfe dieser Formel ließe sich die Problematik lösen.

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

.. figure:: _static/img/Versuchsaufbau_Steckplatine.jpg
    :alt: Raspberry Pi Versuchsaufbau mir Steckplatine und LDR Fototwiderstand
    :align: center
    :scale: 10%

    Raspberry Pi Versuchsaufbau mir Steckplatine und LDR Fototwiderstand :cite:`RaspberryPiLDR`

.. _ClientErlauterung:

Erläuterung
^^^^^^^^^^^

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