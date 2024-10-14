#!/bin/bash

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to install packages
install_packages() {
    echo -e "${BLUE}Updating and upgrading packages...${NC}"
    pkg update && pkg upgrade -y

    echo -e "${GREEN}Installing necessary packages...${NC}"
    pkg install git nano clang cmake ninja rust make tur-repo python3.10 -y
}

# Function to setup Python virtual environment
setup_virtualenv() {
    echo -e "${BLUE}Setting up Python virtual environment...${NC}"
    python3.10 -m venv venv
    source venv/bin/activate

    echo -e "${BLUE}Installing Python dependencies from requirements.txt...${NC}"
    pip install --upgrade pip wheel --quiet
    pip install -r requirements.txt --quiet
}

# Check if MyNotpixel-bot directory exists
if [ ! -d "MyNotpixel-bot" ]; then
    # If the directory does not exist, install everything
    install_packages

    # Clone the MyNotpixel-bot repository
    echo -e "${BLUE}Cloning MyNotpixel-bot repository...${NC}"
    git clone https://github.com/rjfahad/MyNotpixel-bot.git

    # Change directory to MyNotpixel-bot
    cd MyNotpixel-bot || exit

    # Copy .env-example to .env
    echo -e "${BLUE}Copying .env-example to .env...${NC}"
    cp .env-example .env

    # Notify user to edit .env
    echo -e "${YELLOW}Please edit the .env file to configure your settings.${NC}"

    # Set up and activate Python virtual environment
    setup_virtualenv

    echo -e "${GREEN}Installation completed! You can now run the bot.${NC}"

else
    # If the directory exists, just navigate to it
    echo -e "${GREEN}MyNotpixel-bot is already installed. Navigating to the directory...${NC}"
    cd MyNotpixel-bot || exit

    # Activate the virtual environment if it exists
    if [ -f "venv/bin/activate" ]; then
        echo -e "${BLUE}Activating Python virtual environment...${NC}"
        source venv/bin/activate
        echo -e "${GREEN}Virtual environment already exists. Skipping dependency installation.${NC}"
    else
        # If the virtual environment does not exist, set it up
        setup_virtualenv
    fi
fi

# Run the bot
echo -e "${GREEN}Running the bot...${NC}"
python3.10 main.py

echo -e "${GREEN}Script execution completed!${NC}"
