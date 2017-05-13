#!/bin/bash

this_dir=$(dirname $0)

pip install -r ${this_dir}/requirements.txt
python ${this_dir}/deploy.py
