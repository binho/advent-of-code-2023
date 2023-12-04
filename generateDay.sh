#!/bin/bash

name=Day0$1
nameTests=${name}Tests

if test -f "Sources/$name.swift"; then
    echo "$name already exists."
    exit 0
fi

echo "Creating $name..."

cp Sources/Day00.swift Sources/$name.swift
cp Tests/Day00.swift Tests/$name.swift
touch Sources/Data/$name.txt

sed -i '' "s/Day00/${name}/g" Sources/$name.swift
sed -i '' "s/Day00Tests/${nameTests}/g" Tests/$name.swift
sed -i '' "s/Day00/${name}/g" Tests/$name.swift