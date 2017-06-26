# Docs

Online Dokumentation:

* https://brightnessmonitor.github.io/
* http://brightness-monitor-docs.readthedocs.io/de/latest/index.html

Quellcode:
* Client: https://github.com/BrightnessMonitor/BrightnessMonitorClient
* Server: https://github.com/BrightnessMonitor/BrightnessMonitorWeb

# Website updaten

```bash
cd docs
./update_html.sh
```

Git Commit & Push anschließend

```bash
git add -A
git commit -m "update html"
git push
```

# Abhänigkeiten installieren

```bash
pip install sphinx
pip install sphinx-autobuild
pip install sphinx_rtd_theme
```

# Restukture Text

Anleitung: http://www.sphinx-doc.org/en/stable/rest.html