Website
=======

Aufgabe des Servers
-------------------

Das Ziel des Server war es eine Zentrale Instanz zu erstellen, wo alle Daten gesammelt und Zentral ausgewertet werden
können. Auch war es wichtig möglichst kosten effektiv zu arbeiten und Resourcen schonend zu designen.

Verwendete Software & Hoster
----------------------------

Als Software wurde das Python Framework `Django`_ eingesetzt mit dem `Django REST Framework`_ :cite:`DjangoRestApiDoc`
um eine Api Schnittstelle zu erzeugen. Die auswahl des Hoster fiel auf `heroku.com`_, da Heroku für Entwickler eine
Gratis Instanz für Python Websites anbietet welche sich nach 30 Minuten inaktivität automatisch herunter fährt und
eine `PostgreSQL`_ Datenbank mit 10.000 Zeilen enthält. Der Quellcode ist auf `github.com`_ gehostet und mit einem
`Webhook`_ :cite:`HerokuWebhook` verbunden, dadurch wird mit jedem Git push auf dem `Master Branch`_ der aktuelle
Quellcode auf der Heroku Instanz gesendet.

.. index:: Heroku.com

.. _Django: https://www.djangoproject.com/
.. _Django REST Framework: http://www.django-rest-framework.org/
.. _heroku.com: https://heroku.com/
.. _PostgreSQL: https://www.postgresql.org/
.. _github.com: https://github.com/
.. _Webhook: https://developer.github.com/webhooks/
.. _Master Branch: https://github.com/BrightnessMonitor/BrightnessMonitorWeb


Bestandteile der Server Software
--------------------------------

Models - Datenbank
^^^^^^^^^^^^^^^^^^

Die Datenbank besteht aus 3 großen Komponenten, dem User, Device (Raspberry Pi) und den täglichen Werten.

.. figure:: _static/img/Models.png
    :alt: Datenbank Model
    :align: center
    :scale: 45%

    Datenbank Model

.. index:: Datenbank

API - Schnittstelle
^^^^^^^^^^^^^^^^^^^

Die Schnittstelle gibt bei einer leeren anfrage Value anfrage die latitude und longitude Koordinaten des gesicherten
Device aus und wenn ein Wert mit gegeben wird, wird in der Datenbank überprüft ob der User mit dem gesendeten Auth Token
das Device mit der gesendeten UUID gehört, wenn ja wird der gesendete Wert mit dem gesendeten Datum in der Datenbank
gesichert.

.. index:: API

View - Ausgabe
^^^^^^^^^^^^^^

Die Ausgabe umfasst 2 Seiten, die Landingpage gibt auf einer `Open Street Map`_ :cite:`Leaflet` grafisch wieder, wo sich die Geräte befinden,
die Karte wird automatisch zentriert damit alle Geräte sichtbar sind.
Auf der zweiten Seite unter ``/stats`` befinden sich Bar Charts :cite:`GoogleBarChart` welche alle Geräte den täglichen durchschnitts Wert ausgibt.

.. _Open Street Map: http://www.openstreetmap.org/

.. index:: Open Street Map

Deployment
^^^^^^^^^^

Um ein möglichst einfaches und stabiles deployment zu ermöglichen, wurde das Heroku Django Template :cite:`HerokuDjangoTemplate`
als Grundgerüst verwendet und mit hilfe der Dokumentation von Heroku :cite:`HerokuDeployingDjango`. In Kombination
mit einem Github Webhook :cite:`HerokuWebhook` ist das Deployment ausgeführt, sobald der `Master Branch`_ ein git push
empfängt.

.. |Heroku_Deployment| image:: _static/img/Heroku_deployment.png
    :scale: 35%

Außerdem wurde in der Repo Readme ein |Heroku_Deployment| :cite:`DeployToHeroku` Button eingesetzt. Um auch dritten
die Möglichkeit zu geben, schnell und leicht diese Software auf ihrer Privaten Heroku Instanz einsetzen zu können.

Probleme
--------

.. _datenbank:

Zu kleine Datenbank
^^^^^^^^^^^^^^^^^^^

Da dei Gratis Instanz von Heroku nur eine 10.000 Zeilen `PostgreSQL`_ Datenbank erlaubt war die Datenbank innerhalb
der ersten Tagen zu 100% voll und das Design musste Resourcen sparender geändert werden. Dadurch wurden mit jedem Datenupload
die Werte zusammengefasst zu einen Tages durchschnitts Wert

.. index:: Datenbank

Schnittstelle Absichern vor dritten
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Das Ziel war das nur die Personen Daten hochladen dürfen, die den richtigen Auth Token + Device UUID senden. Dadurch aber
das der Auth Token vom `Django REST Framework`_ integriert worden war, war es nur mit hilfe vom ausführlichen lesen der
Dokumentation :cite:`DjangoRestApiDoc` möglich heraus zu finden, welcher User sich hinter welchen Request sich verbirgt.

.. index:: API