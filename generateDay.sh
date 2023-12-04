#!/bin/bash

name=Day0$1
nameTests=${name}Tests

if test -f "Sources/$name.swift"; then
    echo "$name already exists."
    exit 0
fi

echo "Creating $name..."

cp Sources/DayTemplate.swift Sources/$name.swift
cp Tests/DayTemplate.swift Tests/$name.swift
touch Sources/Data/$name.txt

sed -i '' "s/DayTemplate/${name}/g" Sources/$name.swift
sed -i '' "s/DayTemplateTests/${nameTests}/g" Tests/$name.swift
sed -i '' "s/DayTemplate/${name}/g" Tests/$name.swift