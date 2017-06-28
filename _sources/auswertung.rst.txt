Projekt Auswertung
==================

Daten
-----

Die gesammelten Daten reichten nicht für die gezielte Auswertung aus. Da uns die Zeit fehlte um die Probleme von dem
Webserver Datenbank Problem zu lösen (siehe: :ref:`datenbank`).

Es ist nur der Tägliche Druchschnittswert eines jedem Gerätes zu erkennen, es ist aber nicht ab zu lesen wie lange
Licht auf dem Gerät schien oder wie Intensiv, da auch die verwendete Hardware zu ungenau ist (siehe: :ref:`hardware`)

.. index:: Datenbank


Was mit mehr Zeit umgesetzt wäre
--------------------------------

Server Umzug
^^^^^^^^^^^^

Da die Gratis Instanz von `heroku.com`_ eine zu kleine Datenbank enthielt ist eine Bezahlpflichtige `Heroku Postgres`_
unausweichlich oder der Umzug auf dem `HTW Berlin Studie Server`_ bzw. auf das `Kostenloses Kontingent für AWS`_ doch
beide Möglichkeiten würden einen erhöhten Zeitaufwand erzeugen.

.. index:: Heroku.com

.. _heroku.com: https://heroku.com/
.. _Heroku Postgres: https://elements.heroku.com/addons/heroku-postgresql
.. _HTW Berlin Studie Server: https://studi.f4.htw-berlin.de/www/
.. _Kostenloses Kontingent für AWS: https://aws.amazon.com/de/free/

Datenverarbeitung auf Server ausweiten
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Die empfangenden Daten von den Klienten stüdlich automatisch auswerten und dadurch die Datenlast minimieren.

Ausführlichere Grafische Auswertung
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Auf einer `Open Street Map`_ mit dem `Leaflet Bibliothek`_ :cite:`Leaflet` grafisch die Wolkendichte anzeigen und
die Bar Charts eine Stündliche Anzeige integrieren mit der warscheinlichen Wolkendichte.

.. index:: Open Street Map

.. _Open Street Map: http://www.openstreetmap.org/
.. _Leaflet Bibliothek: http://leafletjs.com/reference-1.1.0.html

Client Log funtion integrieren
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Fehler und Status log inteiren um schneller Fehler in Hard & Software aufspüren zu können.

Anpassung der Hardware
^^^^^^^^^^^^^^^^^^^^^^

--> ToDo
genauere Messwerte durch Anpassung der Hardware (Photowiderstand, Kondensator)
