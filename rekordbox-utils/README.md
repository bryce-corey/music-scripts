# 🎵 Audio Metadata Enhancer

A bash script that intelligently processes audio files to improve their metadata by combining title and artist information.

## 📋 Overview

This tool automatically scans a directory for audio files (MP3, M4A, WAV, FLAC, AAC) and updates their title metadata to include the artist name when appropriate. It's perfect for organizing music collections where you want the artist name to be part of the displayed title.

## ✨ Features

- Recursively processes all audio files in a specified directory
- Intelligently combines title and artist metadata (only when they exist separately)
- Preserves files that already have properly formatted titles
- Automatically installs dependencies (requires Homebrew)
- Provides detailed logging of all operations

## 🛠️ Requirements

- macOS with Homebrew installed (or ffmpeg pre-installed)
- Bash shell

## ⚙️ Installation

1. Download the script
2. Make it executable:
   ```bash
   chmod +x audio-metadata-enhancer.sh
   ```

## 🚀 Usage

```bash
./audio-metadata-enhancer.sh /path/to/your/audio/files
```

### Example

```bash
./audio-metadata-enhancer.sh ~/Music/MyCollection
```

## 🔍 How It Works

1. Verifies the directory exists
2. Checks for and installs ffmpeg if needed
3. Finds all supported audio files in the directory
4. For each file:
   - Extracts current title and artist metadata
   - If both exist and the title doesn't already contain a dash:
     - Updates the title to "Title - Artist" format
   - Skips files with missing metadata or already correctly formatted titles

## 🔄 Processing Logic

The script only modifies files where:
- Both title and artist metadata exist
- The title doesn't already contain a dash (indicating it might already be formatted correctly)

## 📝 Example Transformations

| Before | After |
|--------|-------|
| Title: "Imagine"<br>Artist: "John Lennon" | Title: "Imagine - John Lennon" |
| Title: "Hey Jude - Beatles"<br>Artist: "The Beatles" | No change (already has dash) |
| Title: "Yesterday"<br>Artist: "" | No change (missing artist) |

## ⚠️ Caution

This script modifies files in-place. Consider backing up your audio collection before running it on valuable files.

## 📜 License

[MIT License](LICENSE)

## 🤝 Contributing

Contributions are welcome! Feel free to open issues or submit pull requests.
