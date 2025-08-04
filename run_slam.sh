#!/bin/bash

# SLAM Runner Script (Bash version)
# Choose to run original version (MonoGS) or RTGS version (MonoGS_RTGS) SLAM program based on input parameters

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print help information
show_help() {
    echo -e "${BLUE}SLAM Runner Script${NC}"
    echo "Choose to run original version (MonoGS) or RTGS version (MonoGS_RTGS) SLAM program based on input parameters"
    echo ""
    echo "Usage:"
    echo "  $0 original <config>"
    echo "  $0 RTGS <config>"
    echo ""
    echo "Parameters:"
    echo "  original    Run original version (MonoGS directory)"
    echo "  RTGS       Run RTGS version (MonoGS_RTGS directory)"
    echo "  <config>   Config file path, e.g.: tum/fr3_office, replica/office0"
    echo ""
    echo "Examples:"
    echo "  $0 original tum/fr3_office"
    echo "  $0 RTGS tum/fr3_office"
    echo "  $0 original replica/office0"
    echo "  $0 RTGS replica/office0"
    echo ""
    echo "Options:"
    echo "  -h, --help  Show this help message"
}

# Check parameters
if [ $# -eq 0 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    show_help
    exit 0
fi

if [ $# -ne 2 ]; then
    echo -e "${RED}Error: Two parameters required${NC}"
    echo "Usage: $0 <version> <config>"
    echo "Use '$0 --help' for detailed help"
    exit 1
fi

VERSION=$1
CONFIG=$2

# Determine working directory
if [ "$VERSION" = "original" ]; then
    WORK_DIR="MonoGS"
    echo -e "${GREEN}Running original version (MonoGS)${NC}"
elif [ "$VERSION" = "RTGS" ]; then
    WORK_DIR="MonoGS_RTGS"
    echo -e "${GREEN}Running RTGS version (MonoGS_RTGS)${NC}"
else
    echo -e "${RED}Error: Unsupported version '$VERSION'${NC}"
    echo "Please use 'original' or 'RTGS'"
    exit 1
fi

# Check if directory exists
if [ ! -d "$WORK_DIR" ]; then
    echo -e "${RED}Error: Directory '$WORK_DIR' does not exist${NC}"
    exit 1
fi

# Build config file path
CONFIG_FILE="$WORK_DIR/configs/rgbd/$CONFIG.yaml"

# Check if config file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo -e "${RED}Error: Config file '$CONFIG_FILE' does not exist${NC}"
    exit 1
fi

# Display execution information
echo -e "${BLUE}Working directory:${NC} $(pwd)/$WORK_DIR"
echo -e "${BLUE}Config file:${NC} configs/rgbd/$CONFIG.yaml"
echo -e "${BLUE}Command:${NC} python3 slam.py --config configs/rgbd/$CONFIG.yaml --eval"
echo -e "${YELLOW}$(printf '%.0s-' {1..50})${NC}"

# Switch to working directory and execute command
cd "$WORK_DIR" || {
    echo -e "${RED}Error: Cannot switch to directory '$WORK_DIR'${NC}"
    exit 1
}

# Execute SLAM program
if python3 slam.py --config "configs/rgbd/$CONFIG.yaml" --eval; then
    echo -e "\n${GREEN}SLAM program execution successful!${NC}"
    exit 0
else
    echo -e "\n${RED}SLAM program execution failed!${NC}"
    exit 1
fi 