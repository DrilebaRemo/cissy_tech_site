# --- Configuration ---
OUTPUT_FILE="combined_flutter_code.txt"

# Exclude specific directories by path. Add more if needed.
# We exclude platform-specific folders by default. Remove if needed.
EXCLUDE_PATHS=(
    -path './.git'
    -o -path './build'
    -o -path './.dart_tool'
    -o -path './.vscode'
    -o -path './ios'
    -o -path './android'
    -o -path './web'
    -o -path './linux'
    -o -path './macos'
    -o -path './windows'
    -o -path './coverage'
    -o -path './assets' # Exclude assets unless they contain relevant config
)

# Exclude specific file patterns (like generated code)
EXCLUDE_NAMES=(
    -name '*.g.dart'      # Common pattern for generated files (build_runner)
    -o -name '*.freezed.dart' # Common pattern for freezed generated files
    -o -name '*.log'
    # Add other patterns like '*.config.dart' if you have specific generated files
)

# Include specific files (like pubspec.yaml) and patterns (.dart)
INCLUDE_ITEMS=(
    -path './pubspec.yaml' # Crucial project config and dependencies
    -o -path './README.md' # Often useful project overview
    -o -name '*.dart'      # All Dart source code files
    # Add -o -name '*.yaml' if you have other important YAML config files
)

# --- Command ---
# Clear the output file first
> "$OUTPUT_FILE"

echo "Starting code combination..."

# Find files:
# 1. Prune excluded directories.
# 2. Prune excluded file name patterns.
# 3. Find and print included files/patterns.
find . \( -type d \( "${EXCLUDE_PATHS[@]}" \) -prune \) \
       -o \( -type f \( "${EXCLUDE_NAMES[@]}" \) -prune \) \
       -o \( \( "${INCLUDE_ITEMS[@]}" \) -type f -print \) | while IFS= read -r file; do
  # Add a separator and the file path
  echo "--- File: $file ---" >> "$OUTPUT_FILE"
  # Append the file content
  cat "$file" >> "$OUTPUT_FILE"
  # Add a blank line after the file content for readability
  echo "" >> "$OUTPUT_FILE"
done

# Check if the file was created and has content
if [ -s "$OUTPUT_FILE" ]; then
  echo "-----------------------------------------------------"
  echo "Success! Combined code written to '$OUTPUT_FILE'"
  echo "Included: .dart files, pubspec.yaml, README.md (if exists)"
  echo "Excluded common directories (build, .dart_tool, .git, .vscode, platform folders, etc.)"
  echo "Excluded generated files: *.g.dart, *.freezed.dart"
  echo "-----------------------------------------------------"
  echo "You can find '$OUTPUT_FILE' in the file explorer."
  echo "Copy its content and paste it into Google Gemini."
  echo "Remember to review the file size if your project is extremely large."
else
  echo "-----------------------------------------------------"
  echo "Warning: '$OUTPUT_FILE' was created but is empty or the command failed."
  echo "Check if the include/exclude patterns match files in your project."
  echo "Are you in the correct project root directory?"
  echo "-----------------------------------------------------"
fi