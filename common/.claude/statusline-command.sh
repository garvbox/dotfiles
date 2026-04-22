#!/usr/bin/env bash
# Claude Code status line — carbonfox theme

input=$(cat)

dir=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
dir_short=$(echo "$dir" | sed "s|$HOME|~|")
if [ "$(echo "$dir_short" | awk -F'/' '{print NF}')" -gt 3 ]; then
  dir_short="…/$(echo "$dir_short" | rev | cut -d'/' -f1-2 | rev)"
fi

git_branch=""
if git_out=$(GIT_OPTIONAL_LOCKS=0 git -C "$dir" symbolic-ref --short HEAD 2>/dev/null); then
  if [ ${#git_out} -gt 28 ]; then
    git_out="$(echo "$git_out" | cut -c1-27)…"
  fi
  git_branch=" $git_out"
fi

model=$(echo "$input"       | jq -r '.model.display_name // ""')
used=$(echo "$input"        | jq -r '.context_window.used_percentage // empty | if . != "" then (. * 10 | round / 10) else . end')
ctx_size=$(echo "$input"    | jq -r '.context_window.context_window_size // 0')
lines_added=$(echo "$input" | jq -r '.cost.total_lines_added // 0')
lines_removed=$(echo "$input" | jq -r '.cost.total_lines_removed // 0')
rate_used=$(echo "$input"    | jq -r '.rate_limits.five_hour.used_percentage // empty | if . != "" then (. * 10 | round / 10) else . end')
rate_resets=$(echo "$input"  | jq -r '.rate_limits.five_hour.resets_at // empty')

# carbonfox colours
dir_bg="\033[48;2;190;149;255m"  # #be95ff purple — distinct from Starship's blue dir
dir_fg="\033[38;2;22;22;22m"     # #161616
git_bg="\033[48;2;72;72;72m"     # #484848
git_fg="\033[38;2;190;149;255m"  # #be95ff
time_bg="\033[48;2;40;40;40m"    # #282828
time_fg="\033[38;2;223;223;224m" # #dfdfe0
bar_fg="\033[38;2;120;169;255m"  # #78a9ff filled
bar_empty="\033[38;2;72;72;72m"  # #484848 empty
warn_fg="\033[38;2;61;219;217m"  # #3ddbd9 teal warning
crit_fg="\033[38;2;238;83;150m"  # #ee5396 pink critical
green_fg="\033[38;2;37;190;106m" # #25be6a added
red_fg="\033[38;2;238;83;150m"   # #ee5396 removed
reset="\033[0m"

sep_open=$(printf '\xee\x82\xb6')    # U+E0B6 rounded left cap
sep_close=$(printf '\xee\x82\xb4')   # U+E0B4 rounded right cap
sep_angle=$(printf '\xee\x82\xb0')   # U+E0B0 angled transition

printf "\033[38;2;190;149;255m${sep_open}${reset}"
printf "${dir_bg}${dir_fg} ◈ ${dir_short} ${reset}"
if [ -n "$git_branch" ]; then
  printf "\033[38;2;190;149;255m${git_bg}${sep_angle}${reset}"
  printf "${git_bg}${git_fg}${git_branch} ${reset}"
  printf "\033[38;2;72;72;72m${time_bg}${sep_angle}${reset}"
else
  printf "\033[38;2;190;149;255m${time_bg}${sep_angle}${reset}"
fi
printf "${time_bg}${time_fg} ${model} ${reset}"
printf "\033[38;2;40;40;40m${sep_close}${reset}"
if [ "$lines_added" -gt 0 ] || [ "$lines_removed" -gt 0 ]; then
  printf " ${green_fg}+${lines_added}${reset} ${red_fg}-${lines_removed}${reset}"
fi

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

if [ -n "$used" ] && [ "${used%.*}" -ge 70 ]; then
  ctx_fmt=$(fmt_k "$ctx_size")
  printf "  ${time_fg}ctx ${reset}"
  make_bar "${used%.*}" 10
  printf "${time_fg} ${used}%% of ${ctx_fmt}${reset}"
fi
if [ -n "$rate_used" ]; then
  printf "  ${time_fg}5h ${reset}"
  make_bar "${rate_used%.*}" 10
  printf "${time_fg} ${rate_used}%%${reset}"
  if [ -n "$rate_resets" ]; then
    now=$(date +%s)
    remaining=$(( rate_resets - now ))
    if [ "$remaining" -gt 0 ]; then
      hours=$(( remaining / 3600 ))
      mins=$(( (remaining % 3600) / 60 ))
      printf "${time_fg} resets ${hours}h${mins}m${reset}"
    fi
  fi
fi
printf "\n"
