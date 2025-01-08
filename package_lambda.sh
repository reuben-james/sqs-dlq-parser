#!/bin/bash

cp -rp lambda_function/ build
cd build
pip install -r requirements.txt -t .

zip -r ../terraform/lambda_function.zip .
cd ..

rm -rf build/