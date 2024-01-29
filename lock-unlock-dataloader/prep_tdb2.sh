#!/bin/bash

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
    FILENAME=$OUT_DIR/$(basename "$FILENAME" .gz)
fi


if [[ "$FILENAME" == *.zip ]]; then
    value_list_files() {
        ls $OUT_DIR | grep .trig | xargs printf $OUT_DIR'/%s '
    }
    echo "Unzipping dataset"
    unzip $OUT_DIR/$FILENAME -d $OUT_DIR
    FILENAME=$(value_list_files)
fi

# ----------------- Load data -----------------
echo "Loading: $FILENAME"
/jena/bin/tdb2.tdbloader --loc $OUT_DIR $FILENAME
# rm $OUT_DIR/$FILENAME
