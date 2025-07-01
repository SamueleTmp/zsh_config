# 🚀 Zsh & Git Configuration 🚀

Welcome to my personal collection of Zsh and Git configurations! This repository is designed to streamline my command-line workflow, making it more efficient and enjoyable.

## 📂 File Descriptions

Here's a breakdown of what each file does:

### `.zshrc` 🐚
This is the main entry point for the Zsh shell configuration. It sets up the shell environment, custom functions, and sources other configuration files.

- **Git Branch Display**: Shows the current Git branch in the prompt.
- **Optimized History**: Prevents duplicate commands from being saved to the history.
- **Fuzzy Finder Integration**: Sets up `fzf` for powerful fuzzy searching.

### `gcloud_config_switcher.sh` ☁️
This script is a real time-saver! It automatically switches the active `gcloud` (Google Cloud SDK) configuration based on the current directory you `cd` into.

- **How it works**: It hooks into the `cd` command and checks if the current path matches a predefined mapping in the script. If it does, it activates the corresponding `gcloud` configuration.
- **Setup**: You need to define your own directory-to-configuration mapping inside the script. Detailed instructions are included in the file itself!

### `.gitignore` 🙈
A standard Git ignore file. It tells Git which files and directories to intentionally ignore and not track. This helps keep the repository clean from temporary files, build artifacts, and local-only directories.

- **Current configuration**: Ignores the common `.venv` directory used for Python virtual environments.

### `.gitconfig` ⚙️
This file uses a powerful Git feature called "conditional includes." It allows you to use different Git configurations for different directories. This is perfect for managing multiple identities, such as a work profile and a personal profile.

- **How it works**: The `includeIf` directive checks if the current repository is within a specific directory. If it is, it loads an additional `.gitconfig_include` file with settings specific to that context (e.g., a different email address).
- **Template**: The file in this repository is an anonymized template. You will need to edit the paths and create the corresponding `.gitconfig_include` files to match your own setup.

## 🛠️ Setup Instructions

1.  **Clone this repository** to a location of your choice.
    ```bash
    git clone <your-repo-url> ~/zsh_config
    ```
2.  **Source the main `.zshrc` file** from your personal `~/.zshrc`. Add this line to it:
    ```bash
    source ~/zsh_config/.zshrc
    ```
3.  **Customize the `gcloud_config_switcher.sh`**. Open the script and edit the `folder_config_map` to match your project directories and `gcloud` configuration names.
4.  **Customize the `.gitconfig`**. Edit the paths in the `.gitconfig` file to point to your project directories. Then, create the corresponding `.gitconfig_include` files with your specific user information.

Enjoy the enhanced shell experience! ✨