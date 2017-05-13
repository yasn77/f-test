#!/bin/sh
/usr/local/bin/gunicorn --bind 0.0.0.0:8000 --chdir /f_test f_test.wsgi
