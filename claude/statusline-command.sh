#!/bin/sh
# Claude Code status line - based on shell PS1 from ~/dotfiles/shell/git-prompt.sh

input=$(cat)
cwd=$(echo "$input" | jq -r '.cwd')

# Colors
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
RESET='\033[0m'

# Get git branch and dirty status
git_branch=""
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
  branch=$(git -C "$cwd" branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
  if [ -n "$branch" ]; then
    dirty=""
    if [ "$(git -C "$cwd" status --porcelain 2>/dev/null)" != "" ]; then
      dirty="*"
    fi
    git_branch="[${branch}${dirty}]"
  fi
fi

# Line 1: directory + git branch
if [ -n "$git_branch" ]; then
  printf "${GREEN}%s${RESET}${YELLOW}%s${RESET}" "$cwd" "$git_branch"
else
  printf "${GREEN}%s${RESET}" "$cwd"
fi

# Line 2: token info — only shown when current_usage data is available
input_tokens=$(echo "$input" | jq -r '.context_window.current_usage.input_tokens // empty')
output_tokens=$(echo "$input" | jq -r '.context_window.current_usage.output_tokens // empty')
session_input=$(echo "$input" | jq -r '.context_window.total_input_tokens // empty')
session_output=$(echo "$input" | jq -r '.context_window.total_output_tokens // empty')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

if [ -n "$input_tokens" ] && [ -n "$output_tokens" ] && [ -n "$used_pct" ]; then
  total_tokens=$((input_tokens + output_tokens))
  if [ "$total_tokens" -ge 1000 ]; then
    total_display="$(echo "$total_tokens" | awk '{printf "%.1fk", $1/1000}')"
  else
    total_display="${total_tokens}"
  fi

  session_display=""
  if [ -n "$session_input" ] && [ -n "$session_output" ]; then
    session_total=$((session_input + session_output))
    if [ "$session_total" -ge 1000 ]; then
      session_display="$(echo "$session_total" | awk '{printf "%.1fk", $1/1000}')"
    else
      session_display="${session_total}"
    fi
  fi

  used_pct_int=$(printf "%.0f" "$used_pct")
  if [ -n "$session_display" ]; then
    printf "\n${CYAN}last call: %s | session: %s | ctx: %s%%${RESET}" "$total_display" "$session_display" "$used_pct_int"
  else
    printf "\n${CYAN}last call: %s | ctx: %s%%${RESET}" "$total_display" "$used_pct_int"
  fi
fi
