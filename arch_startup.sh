#!/bin/bash

echo "=== Arch Linux Docker Container ==="
echo "User: $(whoami)"
echo "Home: $HOME"
echo "Display: $DISPLAY"
echo ""

show_menu() {
    echo "Choose what to run:"
    echo "1) Full XFCE Desktop"
    echo "2) File Manager (Thunar)"
    echo "3) Terminal"
    echo "4) Text Editor"
    echo "5) Firefox Browser"
    echo "6) Custom Command"
    echo "7) Just Bash Shell"
    echo ""
    echo -n "Enter your choice (1-8): "
}

if [ -z "$DISPLAY" ]; then
    echo "Warning: DISPLAY not set. Setting to :0"
    export DISPLAY=:0
fi

if [ $# -gt 0 ]; then
    echo "Running command: $@"
    exec "$@"
fi

while true; do
    show_menu
    read choice
    
    case $choice in
        1)
            echo "Starting XFCE Desktop..."
            echo "Note: This will take over your entire X11 display (On Windows run X11 Server before)"
            echo "Close the desktop to return to this menu"
            startxfce4
            ;;
        2)
            echo "Starting File Manager..."
            thunar &
            echo "File manager started in background"
            ;;
        3)
            echo "Starting Terminal..."
            xfce4-terminal &
            echo "Terminal started in background"
            ;;
        4)
            echo "Starting Text Editor..."
            mousepad &
            echo "Text editor started in background"
            ;;
        5)
            echo "Starting Firefox..."
            echo "Note: This may take a moment to load"
            firefox &
            echo "Firefox started in background"
            ;;
        6)
            echo -n "Enter command to run: "
            read cmd
            if [ -n "$cmd" ]; then
                echo "Running: $cmd"
                eval "$cmd"
            fi
            ;;
        7)
            echo "Starting bash shell..."
            echo "Type 'exit' to return to menu"
            /bin/bash
            ;;
        *)
            echo "Invalid choice. Please try again."
            ;;
    esac
    
    echo ""
done