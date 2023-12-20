#!/bin/sh

if [ -z "$FILE_URL" ]; then
    echo "Error: Environment variable FILE_URL is not set or is empty" >&2
    exit 1
fi

FILENAME=$(basename "$FILE_URL")

if [ -z "$OUT_DIR" ]; then
    OUT_DIR=/database
fi

# ----------------- Download  -----------------
echo "Going to download $FILE_URL"
curl $FILE_URL -o $OUT_DIR/$FILENAME

# -----------------  Unpack   -----------------
if [[ "$FILENAME" == *.gz ]]; then
    echo "Unzipping dataset"
    gzip -d $OUT_DIR/$FILENAME
    FILENAME=$(basename "$FILENAME" .gz)
fi

# ----------------- Load data -----------------
/jena/bin/tdb2.tdbloader --loc $OUT_DIR $OUT_DIR/$FILENAME
rm $OUT_DIR/$FILENAME
