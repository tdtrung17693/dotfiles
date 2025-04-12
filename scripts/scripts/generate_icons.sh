#!/bin/bash

# Check if ImageMagick is installed
if ! command -v convert &> /dev/null; then
    echo "Error: ImageMagick is not installed. Please install it first."
    echo "On Fedora: sudo dnf install ImageMagick"
    echo "On Ubuntu: sudo apt-get install imagemagick"
    exit 1
fi

# Check if source image is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <source_image>"
    echo "Source image should be at least 1024x1024 pixels"
    exit 1
fi

SOURCE_IMAGE="$1"
ICON_NAME="$(basename "${SOURCE_IMAGE%.*}")"
OUTPUT_DIR="hicolor"

# Create directory structure
mkdir -p "${OUTPUT_DIR}/16x16/apps"
mkdir -p "${OUTPUT_DIR}/22x22/apps"
mkdir -p "${OUTPUT_DIR}/24x24/apps"
mkdir -p "${OUTPUT_DIR}/32x32/apps"
mkdir -p "${OUTPUT_DIR}/48x48/apps"
mkdir -p "${OUTPUT_DIR}/64x64/apps"
mkdir -p "${OUTPUT_DIR}/128x128/apps"
mkdir -p "${OUTPUT_DIR}/256x256/apps"
mkdir -p "${OUTPUT_DIR}/512x512/apps"
mkdir -p "${OUTPUT_DIR}/scalable/apps"

# Generate icons in various sizes
echo "Generating icons..."
convert "$SOURCE_IMAGE" -resize 16x16 "${OUTPUT_DIR}/16x16/apps/${ICON_NAME}.png"
convert "$SOURCE_IMAGE" -resize 22x22 "${OUTPUT_DIR}/22x22/apps/${ICON_NAME}.png"
convert "$SOURCE_IMAGE" -resize 24x24 "${OUTPUT_DIR}/24x24/apps/${ICON_NAME}.png"
convert "$SOURCE_IMAGE" -resize 32x32 "${OUTPUT_DIR}/32x32/apps/${ICON_NAME}.png"
convert "$SOURCE_IMAGE" -resize 48x48 "${OUTPUT_DIR}/48x48/apps/${ICON_NAME}.png"
convert "$SOURCE_IMAGE" -resize 64x64 "${OUTPUT_DIR}/64x64/apps/${ICON_NAME}.png"
convert "$SOURCE_IMAGE" -resize 128x128 "${OUTPUT_DIR}/128x128/apps/${ICON_NAME}.png"
convert "$SOURCE_IMAGE" -resize 256x256 "${OUTPUT_DIR}/256x256/apps/${ICON_NAME}.png"
convert "$SOURCE_IMAGE" -resize 512x512 "${OUTPUT_DIR}/512x512/apps/${ICON_NAME}.png"

# Copy source image as scalable icon if it's SVG
if [[ "$SOURCE_IMAGE" == *.svg ]]; then
    cp "$SOURCE_IMAGE" "${OUTPUT_DIR}/scalable/apps/${ICON_NAME}.svg"
fi

echo "Icons generated successfully in the '${OUTPUT_DIR}' directory."
echo "To install these icons, copy the '${OUTPUT_DIR}' directory to:"
echo "~/.local/share/icons/"
echo "or system-wide to:"
echo "/usr/share/icons/" 
