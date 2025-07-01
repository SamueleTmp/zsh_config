# Function to parse the current Git branch and display it in the prompt
function parse_git_branch() {
    # List all local branches, redirecting errors to /dev/null (to avoid messages when not in a git repo)
    # Then, use sed to find the line with the current branch (starts with *) and format it as [branch_name]
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

# Source a custom script for switching Google Cloud configurations
source $HOME/gcloud_config_switcher.sh

# Set up fzf key bindings and fuzzy completion
# fzf is a command-line fuzzy finder that enhances searching capabilities
source <(fzf --zsh)

# Zsh history settings
# Avoids storing duplicate commands in the history
setopt HIST_IGNORE_ALL_DUPS
# When searching history, don't show duplicate commands
setopt HIST_FIND_NO_DUPS
# Set the file where command history is stored
HISTFILE=~/.zsh_history