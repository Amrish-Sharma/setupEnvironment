# Environment Setup Script

This repository contains a script to set up a development environment on Windows using the Windows Subsystem for Linux (WSL). The script enables necessary features, installs a Linux distribution, and sets up Docker and other essential tools.

## Features

- Enables WSL and Virtual Machine Platform features
- Installs the latest WSL kernel and sets WSL version to 2
- Installs Ubuntu 20.04 as the Linux distribution
- Updates Linux packages
- Installs Docker and other essential tools (wget, subversion, git)
- Adds the current user to the Docker group and starts the Docker service

## Prerequisites

- Windows 10 or later
- Administrative privileges to run the script

## Usage

1. Clone this repository:
    ```sh
    git clone https://github.com/Amrish-Sharma/setupEnvironment.git
    cd setupEnvironment
    ```

2. Run the script with administrative privileges:
    ```sh
    sudo ./env-setup.sh
    ```

3. Follow the on-screen instructions. The script will enable necessary features, install the Linux distribution, and set up Docker.

4. Restart your computer for all changes to take effect.

## Important Notes

- Ensure that you have a stable internet connection as the script will download necessary packages and updates.
- The script installs Ubuntu 20.04 by default. You can modify the script to install a different distribution if needed.
- After running the script, you may need to launch your Linux distribution manually to complete the initialization.

## Contributing

Contributions are welcome! Please fork this repository and submit a pull request with your changes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
