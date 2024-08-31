#!/bin/bash

start_postgresql_linux() {
    if systemctl is-active --quiet postgresql; then
        echo "PostgreSQL is already running."
    else
        echo "Starting PostgreSQL..."
        sudo systemctl start postgresql
        echo "PostgreSQL started."
    fi
}

restart_postgresql_linux() {
    echo "Restarting PostgreSQL..."
    sudo systemctl restart postgresql
    echo "PostgreSQL restarted."
}

stop_postgresql_linux() {
    if systemctl is-active --quiet postgresql; then
        echo "Stopping PostgreSQL..."
        sudo systemctl stop postgresql
        echo "PostgreSQL stopped."
    else
        echo "PostgreSQL is not running."
    fi
}

start_postgresql_macos() {
    if pg_isready > /dev/null 2>&1; then
        echo "PostgreSQL is already running."
    else
        echo "Starting PostgreSQL..."
        brew services start postgresql
        echo "PostgreSQL started."
    fi
}

restart_postgresql_macos() {
    echo "Restarting PostgreSQL..."
    brew services restart postgresql
    echo "PostgreSQL restarted."
}

stop_postgresql_macos() {
    if pg_isready > /dev/null 2>&1; then
        echo "Stopping PostgreSQL..."
        brew services stop postgresql
        echo "PostgreSQL stopped."
    else
        echo "PostgreSQL is not running."
    fi
}

start_postgresql_windows() {
    if net start | findstr /I "postgresql-x64-16" > /dev/null; then
        echo "PostgreSQL is already running."
    else
        echo "Starting PostgreSQL..."
        net start postgresql-x64-16
        echo "PostgreSQL started."
    fi
}

restart_postgresql_windows() {
    echo "Restarting PostgreSQL..."
    net stop postgresql-x64-16
    net start postgresql-x64-16
    echo "PostgreSQL restarted."
}

stop_postgresql_windows() {
    if net start | grep "postgresql-x64-16" > /dev/null; then
        echo "Stopping PostgreSQL..."
        net stop postgresql-x64-16
        echo "PostgreSQL stopped."
    else
        echo "PostgreSQL is not running."
    fi
}

# Detect the operating system and handle the start/restart/stop commands
case "$(uname -s)" in
    Linux*)     
        case "$1" in
            restart) restart_postgresql_linux ;;
            stop)    stop_postgresql_linux ;;
            *)       start_postgresql_linux ;;
        esac
        ;;
    Darwin*)    
        case "$1" in
            restart) restart_postgresql_macos ;;
            stop)    stop_postgresql_macos ;;
            *)       start_postgresql_macos ;;
        esac
        ;;
    CYGWIN*|MINGW*|MSYS*)
        case "$1" in
            restart) restart_postgresql_windows ;;
            stop)    stop_postgresql_windows ;;
            *)       start_postgresql_windows ;;
        esac
        ;;
    *)          
        echo "Unknown OS, script does not support this OS." 
        ;;
esac
