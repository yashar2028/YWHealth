#!/bin/bash

# Check if Poetry is installed.
if ! command -v poetry &> /dev/null
then
    echo "Poetry is not installed!"
    echo "Install it using: curl -sSL https://install.python-poetry.org | python3 -"
    exit 1
fi

echo "Starting PostgreSQL container..." # Database will run upon entering the venv.
./scripts/start_db.sh

VENV_PATH=$(poetry env info --path 2>/dev/null) # The virtual environment path for Poetry.

if [ -z "$VENV_PATH" ]; then
    echo "No Poetry environment found! Creating one..."
    poetry install
    VENV_PATH=$(poetry env info --path)
fi

# Activate the virtual environment.
if [ -d "$VENV_PATH" ]; then
    echo "Poetry environment found! Activating..."
    source "$VENV_PATH/bin/activate"  # This will open a shell with the venv activated on the poetry venv path stored on VENV_PATH.
else
    echo "Failed to find or create a virtual environment."
    exit 1
fi

