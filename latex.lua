#!/usr/bin/bash

# Überprüfen, ob die Eingabedatei angegeben ist
#if [ "$#" -ne 2 ]; then
#    echo "Usage: $0 <input_file>"
#    exit 1
#fi

input_file="Misc/version.txt"
output_file="Misc/version.tex"

# Überprüfen, ob die Eingabedatei existiert
if [ ! -f "$input_file" ]; then
	echo "Datei wird neu angelegt"
    echo "Version: 0" > "$input_file"
fi

# Auslesen der Datei und Parsen der Version
version=$(grep "Version" "$input_file" | awk -F': ' '{print $2}')
ver2=$(($version+1))

# Überprüfen, ob eine Version gefunden wurde
if [ -z "$version" ]; then
    echo "Keine Version gefunden."
    exit 1
fi

echo "Version: $ver2" > "$input_file"

# Schreiben der Version in die Ausgabedatei
echo "\\newcommand\major{0}" > "$output_file"
echo "\\newcommand\minor{1}" >> "$output_file"
echo "\\newcommand\build{$ver2}" >> "$output_file"
act_date=$(date "+%d %b %Y")
echo "\\newcommand\actdate{$act_date}" >> "$output_file"


rm Arcana\ Mechanica\ -\ Magischer\ Kompass.aux
rm Arcana\ Mechanica\ -\ Magischer\ Kompass.out
lualatex Arcana\ Mechanica\ -\ Magischer\ Kompass.tex
makeindex Arcana\ Mechanica\ -\ Magischer\ Kompass.idx
lualatex Arcana\ Mechanica\ -\ Magischer\ Kompass.tex
lualatex Arcana\ Mechanica\ -\ Magischer\ Kompass.tex
