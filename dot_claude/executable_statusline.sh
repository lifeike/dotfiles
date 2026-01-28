#!/bin/bash
# Claude Code Status Line Script
# Displays: Model | Directory | Git Branch | Cost | Context Usage

input=$(cat)

# Parse JSON input
MODEL=$(echo "$input" | jq -r '.model.display_name // "Claude"')
CURRENT_DIR=$(echo "$input" | jq -r '.workspace.current_dir // "~"')
COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
CONTEXT_USED=$(echo "$input" | jq -r '.context_window.used_percentage // 0')
LINES_ADDED=$(echo "$input" | jq -r '.cost.total_lines_added // 0')
LINES_REMOVED=$(echo "$input" | jq -r '.cost.total_lines_removed // 0')

# Get basename of current directory
DIR_NAME=$(basename "$CURRENT_DIR")

# Check for git branch
GIT_BRANCH=""
if [ -d "$CURRENT_DIR/.git" ] || git -C "$CURRENT_DIR" rev-parse --git-dir >/dev/null 2>&1; then
    GIT_BRANCH=$(git -C "$CURRENT_DIR" branch --show-current 2>/dev/null)
fi

# ANSI color codes
CYAN='\033[36m'
GREEN='\033[32m'
YELLOW='\033[33m'
MAGENTA='\033[35m'
RED='\033[31m'
RESET='\033[0m'
DIM='\033[2m'

# Format cost
COST_FMT=$(printf "%.4f" "$COST")

# Format context with color based on usage
if (( $(echo "$CONTEXT_USED > 80" | bc -l) )); then
    CTX_COLOR=$RED
elif (( $(echo "$CONTEXT_USED > 50" | bc -l) )); then
    CTX_COLOR=$YELLOW
else
    CTX_COLOR=$GREEN
fi
CTX_FMT=$(printf "%.0f%%" "$CONTEXT_USED")

# Build output
OUTPUT="${CYAN}${MODEL}${RESET}"
OUTPUT+=" ${DIM}|${RESET} ${GREEN}${DIR_NAME}${RESET}"

if [ -n "$GIT_BRANCH" ]; then
    OUTPUT+=" ${DIM}|${RESET} ${MAGENTA}${GIT_BRANCH}${RESET}"
fi

OUTPUT+=" ${DIM}|${RESET} ${YELLOW}\$${COST_FMT}${RESET}"
OUTPUT+=" ${DIM}|${RESET} ${CTX_COLOR}ctx:${CTX_FMT}${RESET}"

if [ "$LINES_ADDED" -gt 0 ] || [ "$LINES_REMOVED" -gt 0 ]; then
    OUTPUT+=" ${DIM}|${RESET} ${GREEN}+${LINES_ADDED}${RESET}/${RED}-${LINES_REMOVED}${RESET}"
fi

echo -e "$OUTPUT"
