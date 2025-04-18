#!/bin/bash

# Check if directory argument is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Store directory path
DIR="$1"

# Check if directory exists
if [ ! -d "$DIR" ]; then
    echo "Error: Directory '$DIR' does not exist"
    exit 1
fi

# Install ffmpeg if not already installed
if ! command -v ffmpeg &> /dev/null; then
    echo "ffmpeg is not installed. Installing with Homebrew..."
    if ! command -v brew &> /dev/null; then
        echo "Homebrew is not installed. Please install Homebrew first."
        exit 1
    fi
    brew install ffmpeg
fi

# Find all audio files
find "$DIR" -type f -name "*.mp3" -o -name "*.m4a" -o -name "*.wav" -o -name "*.flac" -o -name "*.aac" | while read -r file; do
    echo "Processing file: $file"
    
    # Extract current metadata
    TITLE=$(ffprobe -v error -show_entries format_tags=title -of default=noprint_wrappers=1:nokey=1 "$file")
    AUTHOR=$(ffprobe -v error -show_entries format_tags=artist -of default=noprint_wrappers=1:nokey=1 "$file")
    
    # If both title and author exist and title doesn't already contain a dash
    if [ -n "$TITLE" ] && [ -n "$AUTHOR" ] && [[ "$TITLE" != *"-"* ]]; then
        NEW_TITLE="$TITLE - $AUTHOR"
        echo "  Updating title from '$TITLE' to '$NEW_TITLE'"
        
        # Create temporary file
        TEMP_FILE="$(dirname "$file")/temp_$(basename "$file")"
        
        # Use ffmpeg to update metadata
        ffmpeg -i "$file" -c copy -metadata title="$NEW_TITLE" "$TEMP_FILE" -y -loglevel error
        
        # Replace original with updated file
        mv "$TEMP_FILE" "$file"
        echo "  Updated successfully"
    else
        echo "  Skipping: Title already contains a dash or missing title/author"
    fi
done

echo "All files processed!"