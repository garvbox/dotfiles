#!/usr/bin/env bash
# Claude Code status line — mirrors tokyonight Starship theme

input=$(cat)

user=$(whoami)
dir=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
dir_short=$(echo "$dir" | sed "s|$HOME|~|")

git_branch=""
if git_out=$(GIT_OPTIONAL_LOCKS=0 git -C "$dir" symbolic-ref --short HEAD 2>/dev/null); then
  git_branch=" $git_out"
fi

model=$(echo "$input"       | jq -r '.model.display_name // ""')
used=$(echo "$input"        | jq -r '.context_window.used_percentage // empty')
ctx_size=$(echo "$input"    | jq -r '.context_window.context_window_size // 0')
lines_added=$(echo "$input" | jq -r '.cost.total_lines_added // 0')
lines_removed=$(echo "$input" | jq -r '.cost.total_lines_removed // 0')

# tokyonight colours
os_bg="\033[48;2;163;174;210m"   # #a3aed2
os_fg="\033[38;2;9;12;12m"       # #090c0c
dir_bg="\033[48;2;118;159;240m"  # #769ff0
dir_fg="\033[38;2;227;229;229m"  # #e3e5e5
git_bg="\033[48;2;57;66;96m"     # #394260
git_fg="\033[38;2;118;159;240m"  # #769ff0
time_bg="\033[48;2;29;34;48m"    # #1d2230
time_fg="\033[38;2;160;169;203m" # #a0a9cb
bar_fg="\033[38;2;118;159;240m"  # #769ff0 filled
bar_empty="\033[38;2;57;66;96m"  # #394260 empty
warn_fg="\033[38;2;255;158;100m" # #ff9e64 orange warning
crit_fg="\033[38;2;247;118;142m" # #f7768e red critical
green_fg="\033[38;2;115;218;141m" # #73da8d git added
red_fg="\033[38;2;247;118;142m"   # #f7768e git removed
reset="\033[0m"

# Separator characters (powerline)
sep_right=""   # U+E0B0
sep_left=""    # U+E0B2

# ── Line 1: user / dir / git / model ──────────────────────────────────────────
printf "${os_bg}${os_fg} ${user} ${reset}"
printf "${os_fg}${dir_bg}${sep_right}${reset}"
printf "${dir_bg}${dir_fg} ${dir_short} ${reset}"
if [ -n "$git_branch" ]; then
  printf "${dir_fg}${git_bg}${sep_right}${reset}"
  printf "${git_bg}${git_fg}${git_branch} ${reset}"
fi
printf "${time_bg}${time_fg} ${model} ${reset}"
if [ "$lines_added" -gt 0 ] || [ "$lines_removed" -gt 0 ]; then
  printf " ${green_fg}+${lines_added}${reset} ${red_fg}-${lines_removed}${reset}"
fi
printf "\n"

# ── Helpers ───────────────────────────────────────────────────────────────────
fmt_k() { echo $(( ($1 + 500) / 1000 ))k; }

make_bar() {
  local pct=$1 width=$2
  local filled=$(( width * pct / 100 ))
  local empty=$(( width - filled ))
  local colour
  if [ "$pct" -ge 90 ]; then
    colour="$crit_fg"
  elif [ "$pct" -ge 70 ]; then
    colour="$warn_fg"
  else
    colour="$bar_fg"
  fi
  local bar_f bar_e
  bar_f=$(printf '%0.s█' $(seq 1 $filled) 2>/dev/null || true)
  bar_e=$(printf '%0.s░' $(seq 1 $empty)  2>/dev/null || true)
  printf "${colour}${bar_f}${bar_empty}${bar_e}${reset}"
}

# ── Line 2: context window progress bar ───────────────────────────────────────
if [ -n "$used" ]; then
  ctx_fmt=$(fmt_k "$ctx_size")
  printf "${time_fg} ctx ${reset}"
  make_bar "${used%.*}" 20
  printf "${time_fg} ${used}%% of ${ctx_fmt}${reset}"
  printf "\n"
fi
