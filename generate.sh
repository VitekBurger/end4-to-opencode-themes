#!/usr/bin/env bash

OUTPUT_DIR="$HOME/.config/opencode/themes"
OUTPUT_FILE="$OUTPUT_DIR/end4.json"
INPUT_FILE="$HOME/.local/state/quickshell/user/generated/terminal/kitty-theme.conf"

if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: Theme source file not found."
    exit 1
fi

mkdir -p "$OUTPUT_DIR"

BG=$(grep -E "^background[[:space:]]+" "$INPUT_FILE" | awk '{print $2}')
FG=$(grep -E "^foreground[[:space:]]+" "$INPUT_FILE" | awk '{print $2}')

# Material You colors from kitty theme (color248-255)
PRIMARY=$(grep -E "^color255[[:space:]]+" "$INPUT_FILE" | awk '{print $2}')
SECONDARY=$(grep -E "^color253[[:space:]]+" "$INPUT_FILE" | awk '{print $2}')
TERTIARY=$(grep -E "^color251[[:space:]]+" "$INPUT_FILE" | awk '{print $2}')
ERROR=$(grep -E "^color249[[:space:]]+" "$INPUT_FILE" | awk '{print $2}')

accent="${PRIMARY:-#FA46BB}"
secondary="${SECONDARY:-#9DA8D8}"
tertiary="${TERTIARY:-#78C8D4}"
err_col="${ERROR:-#BF616A}"

echo "Select transparency mode:"
echo "  1) No transparency"
echo "  2) Transparent background"
echo "  3) Transparent background + blur on panels and lists"
read -r MODE

case "$MODE" in
    2)
        bg_val="none"
        panel_val="${BG:-#1F191F}"
        border_val="${BG:-#1F191F}"
        element_val="${BG:-#1F191F}"
        ;;
    3)
        bg_val="none"
        panel_val="none"
        border_val="none"
        element_val="none"
        ;;
    *)
        bg_val="${BG:-#1F191F}"
        panel_val="${BG:-#1F191F}"
        border_val="${BG:-#1F191F}"
        element_val="${BG:-#1F191F}"
        ;;
esac

cat <<EOF > "$OUTPUT_FILE"
{
  "\$schema": "https://opencode.ai/theme.json",
  "defs": {
    "end4bg": "${bg_val}",
    "end4fg": "${FG:-#EED1D3}",
    "accent": "${accent}",
    "accentDim": "${accent}44",
    "secondary": "${secondary}",
    "tertiary": "${tertiary}",
    "error": "${err_col}",
    "errorDim": "${err_col}44",
    "panel": "${panel_val}",
    "border": "${border_val}",
    "element": "${element_val}",
    "muted": "#888099"
  },
  "theme": {
    "primary": { "dark": "accent" },
    "secondary": { "dark": "secondary" },
    "accent": { "dark": "accent" },
    "error": { "dark": "error" },
    "warning": { "dark": "tertiary" },
    "success": { "dark": "#A3BE8C" },
    "info": { "dark": "secondary" },
    "text": { "dark": "end4fg" },
    "textMuted": { "dark": "muted" },
    "background": { "dark": "end4bg" },
    "backgroundPanel": { "dark": "panel" },
    "backgroundElement": { "dark": "element" },
    "border": { "dark": "border" },
    "borderActive": { "dark": "accent" },
    "borderSubtle": { "dark": "border" },
    "diffAdded": { "dark": "#A3BE8C" },
    "diffRemoved": { "dark": "error" },
    "diffContext": { "dark": "border" },
    "diffHunkHeader": { "dark": "border" },
    "diffHighlightAdded": { "dark": "#A3BE8C" },
    "diffHighlightRemoved": { "dark": "error" },
    "diffAddedBg": { "dark": "#A3BE8C33" },
    "diffRemovedBg": { "dark": "errorDim" },
    "diffContextBg": { "dark": "panel" },
    "diffLineNumber": { "dark": "muted" },
    "diffAddedLineNumberBg": { "dark": "#A3BE8C22" },
    "diffRemovedLineNumberBg": { "dark": "errorDim" },
    "markdownText": { "dark": "end4fg" },
    "markdownHeading": { "dark": "accent" },
    "markdownLink": { "dark": "secondary" },
    "markdownLinkText": { "dark": "tertiary" },
    "markdownCode": { "dark": "#A3BE8C" },
    "markdownBlockQuote": { "dark": "muted" },
    "markdownEmph": { "dark": "tertiary" },
    "markdownStrong": { "dark": "accent" },
    "markdownHorizontalRule": { "dark": "border" },
    "markdownListItem": { "dark": "accent" },
    "markdownListEnumeration": { "dark": "secondary" },
    "markdownImage": { "dark": "secondary" },
    "markdownImageText": { "dark": "tertiary" },
    "markdownCodeBlock": { "dark": "end4fg" },
    "syntaxComment": { "dark": "muted" },
    "syntaxKeyword": { "dark": "accent" },
    "syntaxFunction": { "dark": "secondary" },
    "syntaxVariable": { "dark": "end4fg" },
    "syntaxString": { "dark": "#A3BE8C" },
    "syntaxNumber": { "dark": "tertiary" },
    "syntaxType": { "dark": "secondary" },
    "syntaxOperator": { "dark": "tertiary" },
    "syntaxPunctuation": { "dark": "end4fg" }
  }
}
EOF

echo "Theme written to $OUTPUT_FILE"
