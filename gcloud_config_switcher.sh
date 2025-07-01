# SCRIPT: gcloud_config_switcher.sh
#
# DESCRIPTION:
# This script automatically switches the active gcloud configuration based on the
# current directory. It is designed to be sourced from your .zshrc file.
#
# HOW TO SETUP IN ZSH (.zshrc):
#
# 1.  Make sure this script is executable:
#     chmod +x /path/to/gcloud_config_switcher.sh
#
# 2.  Source this script from your .zshrc file. Add the following line:
#     source /path/to/your/gcloud_config_switcher.sh
#
# 3.  The script will automatically handle the rest. It redefines the `cd`
#     command to check the gcloud configuration every time you change directories.

# ------------------------------------------------------------------------------
# CONFIGURATION
# ------------------------------------------------------------------------------
# Define a map where keys are unique parts of a directory path and values are
# the names of the corresponding gcloud configurations.
#
# SYNTAX:
# ["<unique-path-part>"]="<gcloud-config-name>"
#
# EXAMPLE:
# If your projects are in `~/Projects/work/project-alpha` and you want to use
# the `gcloud-config-alpha` for it, you could add:
# ["work/project-alpha"]="gcloud-config-alpha"
#
declare -A folder_config_map=(
  ["path/to/project-a"]="config-a"
  ["path/to/project-b"]="config-b"
  ["client-x/project-c"]="config-c"
)

# ------------------------------------------------------------------------------
# CORE FUNCTIONS
# ------------------------------------------------------------------------------

# Function to check if a given gcloud configuration is currently active.
#
# @param $1 - The name of the gcloud configuration to check.
# @return "true" if the configuration is active, "false" otherwise.
check_activate_state() {
  # Describes the given configuration, finds the "is_active" line,
  # extracts the value (true/false), and removes whitespace.
  local is_active=$(gcloud config configurations describe "$1" | grep is_active: | cut -d':' -f2 | tr -d ' ')
  echo $is_active
}

# Function to activate a new gcloud configuration.
#
# @param $1 - The name of the gcloud configuration to activate.
change_config() {
  local new_config="$1"
  echo "Switching gcloud account to: $new_config"
  gcloud config configurations activate "$new_config" >/dev/null 2>&1
}

# Main function that triggers on directory changes.
handle_directory_change() {
  # Get the current path relative to the user's home directory.
  local relative_dir=$(pwd | sed "s|^$HOME/||")

  # Loop through the predefined path keys in the configuration map.
  for key in "${(@k)folder_config_map}"; do
    # Check if the current directory path contains one of the keys.
    if [[ "$relative_dir" == *"$key"* ]]; then
      local config_name="${folder_config_map[$key]}"
      # Check if the corresponding configuration is already active.
      local activate_state=$(check_activate_state "$config_name")

      if [[ "$activate_state" == "true" ]]; then
        # If it's already active, do nothing.
        return
      else
        # If not active, switch to the correct configuration.
        change_config "$config_name"
      fi
      # Exit after the first match is found and handled.
      return
    fi
  done
}

# ------------------------------------------------------------------------------
# ZSH INTEGRATION
# ------------------------------------------------------------------------------

# Redefine the 'cd' command to add our custom logic.
cd() {
  # Execute the original 'cd' command with all its arguments.
  builtin cd "$@"
  # After changing directory, call our handler function.
  handle_directory_change
}

# Run the handler once on shell startup to set the config for the initial directory.
handle_directory_change
