import curses
from curses import panel

class Window:
    window = None
    wpanel = None
    title = ""

    # Overridden refresh
    def child_refresh(self):
        return

    # Updates the window
    def refresh(self):
        win = self.window
        win.clear()
        win.border()
        self.print_title()
        self.child_refresh()
        panel.update_panels()
        win.refresh()

    # Prints the title
    def print_title(self):
        win = self.window
        title = self.title
        cy, cx = get_window_center(win)
        win.addstr(1, cx - len(title) // 2, title)

    # Creates a new window
    def __init__(self, window, title):
        self.window = window
        self.wpanel = panel.new_panel(window)
        self.title = title

# Returns the center of the window
def get_window_center(win):
    my, mx = win.getmaxyx()
    return (my // 2, mx // 2)

# Create a basic classless window
def create_basic(h, w, y, x):
    win = curses.newwin(h, w, y, x)
    return win

# Creates a new subwindow with title
def create(title, h, w, y, x):
    win = create_basic(h, w, y, x)
    win_obj = Window(win, title)
    win_obj.refresh()
    return win_obj

# Creates a centered subwindow with title
def create_centered(parent, title, h, w):
    cy, cx = get_window_center(parent)
    return create(title, h, w, cy - h // 2, cx - w // 2)
