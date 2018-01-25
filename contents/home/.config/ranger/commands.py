# This is a sample commands.py.  You can add your own commands here.
#
# Please refer to commands_full.py for all the default commands and a complete
# documentation.  Do NOT add them all here, or you may end up with defunct
# commands when upgrading ranger.

# You always need to import ranger.api.commands here to get the Command class:
from ranger.api.commands import *

# A simple command for demonstration purposes follows.
# -----------------------------------------------------------------------------

# You can import any python module as needed.
import os

# Any class that is a subclass of "Command" will be integrated into ranger as a
# command.  Try typing ":my_edit<ENTER>" in ranger!

class term_open(Command):
    """:term_open <dir>

    A command that opens a terminal and sets the working directory
    to the given directory.
    """

    def execute(self):
        target_path = ""

        if self.arg(1):
            target_path = self.rest(1)
        else:
            target_path = self.fm.thisfile.path

        if not os.path.exists(target_path):
            if not os.path.isdir(target_path):
                self.fm.notify("Path must be a directory!", bad=True)
                return
            self.fm.notify(target_path + " not found", bad=True)
            return

        os.system("urxvt -cd " + target_path)
