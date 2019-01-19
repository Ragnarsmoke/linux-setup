import curses
import window
import keyset

# Dialog menu class
class DialogMenu(window.Window):
    current_selection = True

    # Refresh menu
    def child_refresh(self):
        self.print_buttons()

    # Print the options
    def print_buttons(self):
        win = self.window
        current_selection = self.current_selection
        cy, cx = window.get_window_center(win)

        for i in range(0, 2):
            x = cx - 4
            text = "Yes"
            mode = curses.A_NORMAL

            if i == 1:
                x = cx + 1
                text = "No"

            if i == int(not current_selection):
                mode = curses.A_REVERSE

            win.addstr(2, x, text, mode)

    # Switches selection
    def selection_switch(self):
        self.current_selection = not self.current_selection

    # Gets the selected option
    def get_response(self):
        win = self.window
        while True:
            key = win.getch()

            if key in (keyset.keyset_up + keyset.keyset_down + keyset.keyset_left + keyset.keyset_right):
                self.selection_switch()
            elif key in keyset.keyset_enter:
                return self.current_selection

            self.refresh()

    # Creates a new option menu
    def __init__(self, window, title):
        super(DialogMenu, self).__init__(window, title)
        window.keypad(True)

# Creates a new dialog menu attached to the given window
def create(title, w, y, x):
    win = window.create_basic(4, w, y, x)
    win.bkgd(' ', curses.color_pair(1))
    menu = DialogMenu(win, title)
    menu.refresh()
    return menu

# Creates a new centered dialogmenu attached to the given window
def create_centered(parent, title, w):
    cy, cx = window.get_window_center(parent)
    return create(title, w, cy - 4, cx - w // 2)
