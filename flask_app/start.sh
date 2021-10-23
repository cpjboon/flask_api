#!/usr/bin/env bash

nginx
/home/appuser/.local/bin/uwsgi --ini uswsgi.ini
