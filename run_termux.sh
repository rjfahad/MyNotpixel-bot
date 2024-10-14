#!/bin/bash

# Define color codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if MyNotpixel-bot directory exists
if [ -d "MyNotpixel-bot" ]; then
    # Change directory to MyNotpixel-bot
    cd MyNotpixel-bot || exit

    # Activate the virtual environment if it exists
    if [ -f "venv/bin/activate" ]; then
        echo -e "${BLUE}Activating Python virtual environment...${NC}"
        source venv/bin/activate
    else
        echo -e "${GREEN}Virtual environment not found. Please run install.sh first.${NC}"
        exit 1
    fi

    # Run the bot
    echo -e "${GREEN}Running the bot...${NC}"
    python3.10 main.py

    echo -e "${GREEN}Script execution completed!${NC}"
else
    echo -e "${GREEN}MyNotpixel-bot is not installed. Please run install.sh first.${NC}"
fi
