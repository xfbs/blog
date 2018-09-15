#!/bin/bash

for file in assets/images/*.png; do
  echo "scaling '$file' down to maximally 1600 pixels in width"
  convert -verbose "$file" -resize "1600x>" "$file"

  echo "optimizing '$file' to reduce size"
  optipng "$file"
done
