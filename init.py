#!/usr/bin/python
import curses
import option_menu
import dialog_menu
import window
from curses import wrapper

# Variable declaration
stdscr = curses.initscr()
modules = []

# Python module configuration
curses.start_color()
curses.cbreak()
curses.init_pair(1, curses.COLOR_WHITE, curses.COLOR_RED)
curses.curs_set(0)
stdscr.bkgd(' ', curses.color_pair(0))
stdscr.keypad(True)

def import_full_menu(win):
    menu = dialog_menu.create_centered(win, 
            "Modified date check?",
            60)

    option = menu.get_response()
    del menu
    
    return True

def import_single_menu(win):
    menu = dialog_menu.create_centered(win, 
            "Modified date check?",
            60)

    option = menu.get_response()
    del menu
    
    return True

# Import menu
def import_menu(win):
    menu = option_menu.create_centered(win,
            "Import menu",
            60, ["Full import (All configurations)",
                "Import a single configuration"])

    option = menu.get_option()
    del menu

    if option == 1:
        import_full_menu(win)
    elif option == 2:
        import_single_menu(win)

# Install menu
def install_menu(win):
    return

# Init loop function
def init_loop(win):
    menu = option_menu.create_centered(win, 
            "Select option",
            60, ["Import", "Install"])

    option = menu.get_option()
    del menu

    if option == 1:
        import_menu(win)
        return True
    elif option == 2:
        install_menu(win)
        return True
    else:
        return False

# Main function
def main(stdscr):
    while True:
        stdscr.clear()
        stdscr.refresh()

        do_continue = False

        try:
            do_continue = init_loop(stdscr)
        except(KeyboardInterrupt):
            break

        if not do_continue:
            break

wrapper(main)
