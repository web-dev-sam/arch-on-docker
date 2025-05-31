#!/bin/bash

echo "=== Building Arch Linux Docker Container ==="

# Build the Arch container
echo "Building Arch Linux image (this may take several minutes)..."
docker build -f Dockerfile -t arch-desktop .

if [ $? -ne 0 ]; then
    echo "Error: Failed to build Arch Linux image"
    exit 1
fi

echo ""
echo "=== Arch Linux Docker Container Ready ==="
echo ""
echo "Make sure your X11 server (VcXsrv) is running!"
echo ""

# Set DISPLAY for Windows
export DISPLAY=host.docker.internal:0

echo "Available run modes:"
echo "1) Interactive menu (default)"
echo "2) Direct XFCE desktop"
echo "3) Just terminal"
echo "4) File manager only"
echo "5) Custom command"
echo ""
echo -n "Choose mode (1-5, Enter for default): "
read mode

case $mode in
    2)
        echo "Starting full XFCE desktop..."
        docker run -it --rm \
            -e DISPLAY=host.docker.internal:0 \
            --name arch-desktop \
            arch-desktop startxfce4
        ;;
    3)
        echo "Starting terminal..."
        docker run -it --rm \
            -e DISPLAY=host.docker.internal:0 \
            --name arch-desktop \
            arch-desktop xfce4-terminal
        ;;
    4)
        echo "Starting file manager..."
        docker run -it --rm \
            -e DISPLAY=host.docker.internal:0 \
            --name arch-desktop \
            arch-desktop thunar
        ;;
    5)
        echo -n "Enter command to run: "
        read cmd
        docker run -it --rm \
            -e DISPLAY=host.docker.internal:0 \
            --name arch-desktop \
            arch-desktop $cmd
        ;;
    *)
        echo "Starting interactive menu..."
        docker run -it --rm \
            -e DISPLAY=host.docker.internal:0 \
            --name arch-desktop \
            arch-desktop
        ;;
esac

echo ""
echo "Arch Linux container stopped."