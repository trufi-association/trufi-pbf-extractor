#!/bin/bash
set -e

# Validate required environment variables
if [ -z "$CITY_NAME" ]; then
    echo "ERROR: CITY_NAME environment variable is not set"
    exit 1
fi

if [ -z "$BBOX" ]; then
    echo "ERROR: BBOX environment variable is not set"
    exit 1
fi

if [ -z "$GEOFABRIK_URL_PATH" ]; then
    echo "ERROR: GEOFABRIK_URL_PATH environment variable is not set"
    exit 1
fi

echo "========================================="
echo "Trufi PBF Extractor"
echo "========================================="
echo "City: $CITY_NAME"
echo "Bounding box: $BBOX"
echo "Source: https://download.geofabrik.de$GEOFABRIK_URL_PATH"
echo "========================================="

# Clean up previous files
echo "[1/4] Cleaning up previous files..."
rm -f ./country.osm.pbf ./output.osm.pbf

# Download country PBF
echo "[2/4] Downloading PBF file from Geofabrik..."
wget -O ./country.osm.pbf "https://download.geofabrik.de$GEOFABRIK_URL_PATH"

# Extract region using bounding box
echo "[3/4] Extracting region with osmium..."
osmium extract --bbox="$BBOX" --set-bounds ./country.osm.pbf --output "./output.osm.pbf"

# Copy to output directory with city name
echo "[4/4] Copying to output directory..."
cp -f ./output.osm.pbf "./out/${CITY_NAME}.osm.pbf"

# Show result
echo "========================================="
echo "Done! Output file:"
ls -lh "./out/${CITY_NAME}.osm.pbf"
echo "========================================="
