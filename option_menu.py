import curses
import window
import keyset

# Option menu class
class OptionMenu(window.Window):
    current_selection = 0
    options = []

    # Refresh option menu
    def child_refresh(self):
        self.print_options()

    # Print the options
    def print_options(self):
        options = self.options
        win = self.window

        for i in range(len(options)):
            _, width = win.getmaxyx()

            mode = curses.A_NORMAL

            if self.current_selection == i:
                mode = curses.A_REVERSE

            win.addstr(3 + i, 1,
                    "{}. {}".format(i, options[i]).ljust(width - 2), mode)

    # Moves up one option
    def option_down(self):
        options = self.options

        if self.current_selection + 1 < len(options):
            self.current_selection = self.current_selection + 1

    # Moves down one option
    def option_up(self):
        if self.current_selection - 1 >= 0:
            self.current_selection = self.current_selection - 1

    # Gets the selected option
    def get_option(self):
        win = self.window
        while True:
            key = win.getch()

            if key in keyset.keyset_up:
                self.option_up()
            elif key in keyset.keyset_down:
                self.option_down()
            elif key in range(48, 57):
                key_num = int(chr(key))

                if key_num >= 0:
                    self.current_selection = key_num
                    return self.current_selection
            elif key in keyset.keyset_enter:
                return self.current_selection

            self.refresh()

    # Creates a new option menu
    def __init__(self, window, title, options):
        super(OptionMenu, self).__init__(window, title)
        window.keypad(True)
        self.options = ["Exit"] + options

# Creates a new option menu attached to the given window
def create(title, w, y, x, options):
    h = len(options) + 5
    win = window.create_basic(h, w, y, x)
    win.bkgd(' ', curses.color_pair(1))
    menu = OptionMenu(win, title, options)
    menu.refresh()
    return menu

# Creates a new centered option menu attached to the given window
def create_centered(parent, title, w, options):
    cy, cx = window.get_window_center(parent)
    h = len(options) + 5
    return create(title, w, cy - h // 2, cx - w // 2, options)
