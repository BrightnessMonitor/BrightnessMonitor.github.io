Einleitung
==========

Idee
----

Es sollen die exakten Sonnenstunden an mehreren Standorten erfasst werden. Dazu wird die Helligkeit mit dem Photowiderstand
gemessen und von einem Raspberry Pi verarbeitet. Als Ausgabe dessen wird sein: Sonne, Wolken mit verminderter
Wolkendichte, Wolken mit verstärkter Wolkendichte, Dunkel. Gleichzeitig wird die Dauer dieser Zustände gemessen und
in einer Datenbank gespeichert.

Umgesetzt wurde
---------------

Ein Programm im Server - Client Verbund, wobei der Client die Licht Intensität misst und diese in 5 Minuten Takt zum
Server weiter sendet. Die Klienten messen nur innerhalb der Zeit in der die Sonne scheint, dafür übergibt der Server
dem Client den genauen Standort womit der Client ausrechnen kann, ob die Sonne scheint oder nicht.

Der Server ist eine Website welche die gesendeten Daten zusammen fasst und sie Grafisch in einer Karte & einem Chart
ausgibt.

.. figure:: _static/img/SoftwareDesign.png
    :alt: Software Design
    :align: center
    :scale: 22%

    Software Design

.. index:: Software Design

Raspberry Pi Client
^^^^^^^^^^^^^^^^^^^

Der Client wurde in Python 2.7 für den Raspberry Pi geschrieben.

- Quellcode : https://github.com/BrightnessMonitor/BrightnessMonitorClient

.. index:: Git
.. index:: Quellcode

.. figure:: _static/img/raspberry-pi_01.jpg
    :alt: Raspberry Pi
    :align: center
    :scale: 10%

    Raspberry Pi Brightness Monitor Client mit WLAN

.. index:: Raspberry Pi

Website
^^^^^^^

Der Server wurde in das Python Web Framework "Django" geschrieben und auf einer gratis Instanz von `heroku.com`_ gehostet.

.. _heroku.com: https://heroku.com/

- Quellcode : https://github.com/BrightnessMonitor/BrightnessMonitorWeb
- Website URL: https://infinite-crag-79176.herokuapp.com/

.. index:: Git
.. index:: Django
.. index:: Heroku.com

.. figure:: _static/img/Heroku_logo.png
    :alt: Heroku.com logo
    :scale: 80%

    Bild Quelle: https://en.wikipedia.org/wiki/Heroku

.. figure:: _static/img/website_01.png
    :alt: Screenshot
    :align: center
    :scale: 15%

    Screenshot von https://infinite-crag-79176.herokuapp.com/

Dokumentation
^^^^^^^^^^^^^

Die Dokumentation wurde mit Sphinx :cite:`SphinxHomepage` erstellt und gehostet auf `readthedocs.io`_  und `github.com`_.

.. _readthedocs.io: https://readthedocs.io/
.. _github.com: https://github.com/

- Quellcode : https://github.com/BrightnessMonitor/BrightnessMonitor.github.io
- Online Dokumentation: https://brightnessmonitor.github.io/
- Read the docs: http://brightness-monitor-docs.readthedocs.io/de/latest/

.. index:: Git
.. index:: Quellcode
.. index:: Online Dokumentation

Präsentation
^^^^^^^^^^^^

Die Präsentation wurde in PowerPoint erstellt und ist auf `github.com`_ gehostst.

.. _github.com: https://github.com/

- Präsentation : :download:`Download Link<source/_static/presentation/Presentation1.pptx>`.

.. index:: PowerPoint
.. index:: Präsentation
