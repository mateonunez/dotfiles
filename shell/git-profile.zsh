# git-profile.zsh — Shell integration for gitswitch
# Source this from ~/.zshrc:
#   source ~/.dotfiles/shell/git-profile.zsh

# ── PATH ─────────────────────────────────────────────────────────────────────

[[ ":$PATH:" != *":${HOME}/.dotfiles/scripts:"* ]] \
  && export PATH="${HOME}/.dotfiles/scripts:${PATH}"

# ── Aliases ───────────────────────────────────────────────────────────────────

alias gswitch='gitswitch'
alias gswitch-use='gitswitch use'
alias gswitch-list='gitswitch list'
alias gswitch-current='gitswitch current'

# ── Tab completion ────────────────────────────────────────────────────────────

# Completes profile names from ~/.gitconfig.<name> files
_gitswitch_profiles() {
  local -a profiles
  for f in "${HOME}"/.gitconfig.*; do
    [[ -f "$f" && ! -L "$f" ]] || continue
    local name="${f##*/.gitconfig.}"
    [[ "$name" == "bak" ]] && continue
    profiles+=("$name")
  done
  compadd -a profiles
}

_gitswitch_completion() {
  local state
  _arguments \
    '1:command:((
      init\:"set up ~/.gitconfig for profile switching"
      use\:"switch to a profile"
      list\:"list available profiles"
      current\:"show active profile"
      help\:"show help"
    ))' \
    '*::arg:->args'

  case $state in
    args)
      case "${words[1]}" in
        use) _gitswitch_profiles ;;
      esac
      ;;
  esac
}

compdef _gitswitch_completion gitswitch gswitch

# ── Powerlevel10k custom segment ──────────────────────────────────────────────
#
# Shows the active git profile in the right prompt, styled like other env
# segments (pyenv, nvm, etc.).  After sourcing this file you only need to add
# `git_profile` to POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS in ~/.p10k.zsh.
#
# Color key: 214 = amber/orange  (matches the "whatwapp" brand colour in your
#             theme); 47 = bright-green; fallback is plain yellow (11).

function prompt_git_profile() {
  local profile_file="${HOME}/.git_profile"
  [[ -s "$profile_file" ]] || return
  local profile
  profile=$(<"$profile_file")
  [[ -n "$profile" ]] || return
  p10k segment -f 214 -i '⊶' -t "$profile"
}

# instant_prompt_* must always make the same p10k segment calls so that the
# instant prompt is rendered correctly before the shell is fully initialised.
function instant_prompt_git_profile() {
  prompt_git_profile
}
