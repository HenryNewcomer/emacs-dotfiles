# Source: https://juliu.is/a-simple-tmux/
# Gets the name of the current directory and removes periods, which tmux doesn’t like.
# If any session with the same name is open, it re-attaches to it.
# Otherwise, it checks if an .envrc file is present and starts a new tmux session using direnv exec.
# Otherwise, starts a new tmux session with that name.
function tat {
  name=$(basename `pwd` | sed -e 's/\.//g')

  if tmux ls 2>&1 | grep "$name"; then
    tmux attach -t "$name"
  elif [ -f .envrc ]; then
    direnv exec / tmux new-session -s "$name"
  else
    tmux new-session -s "$name"
  fi
}

# Manually add environment variables for Python
export PATH="/opt/homebrew/bin/python3:$PATH"
export PATH="/Library/Frameworks/Python.framework/Versions/3.11/bin/python3:$PATH"
alias python=python3

# TODO: make 'py' alias create and enter a virtual environment, and then calls python3
alias setpy="python3 -m venv .venv && source .venv/bin/activate"
alias py="source .venv/bin/activate && python3"
