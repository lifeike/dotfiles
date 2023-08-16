#!/usr/bin/env python3
import os
import time
import subprocess
import atexit
import signal
import sys

# DESCRIPTION:
#
# Checks out every "REFRESH_RATE" seconds if the workspace/desktop changed
# If so, correct the focus to the last screen you were focusing in that workspace/desktop
#
# In the case that we have no history of you focusing a screen in the current desktop,
# attempt to focus on the topmost window by searching and filtering all the windows
# in the current desktop
#

# TWEAK VARIABLES
REFRESH_RATE = 0.01  # seconds
LOCKFILE = "/tmp/gnome_focus_automation_lockfile"

history_desktop_last_active_window = {}


def main():
    global history_desktop_last_active_window

    # This SCRIPT can't run duplicated on our system
    # So let's create a lockfile to prevent that
    create_lockfile_or_quit()

    current_desktop = get_desktop()
    while True:
        time.sleep(REFRESH_RATE)

        update_window_history()

        previous_desktop = current_desktop
        current_desktop = get_desktop()
        did_desktop_change = current_desktop != previous_desktop

        if did_desktop_change:
            focus_best_window(current_desktop)


def update_window_history():
    global history_desktop_last_active_window

    active_window = get_active_window()
    active_w_desktop = get_desktop_for_window(active_window)

    if active_w_desktop != "":
        history_desktop_last_active_window[active_w_desktop] = active_window


def focus_best_window(current_desktop):
    global history_desktop_last_active_window

    if current_desktop in history_desktop_last_active_window:
        target_window = history_desktop_last_active_window[current_desktop]
        is_target_valid = get_desktop_for_window(target_window) == current_desktop

        if is_target_valid:
            did_history_focus_succeded = try_activate_window(target_window)
        else:
            did_history_focus_succeded = False
    else:
        did_history_focus_succeded = False

    if not did_history_focus_succeded:
        # Fallback Focus
        topmost_window = unreliably_get_topmost_window_of_desktop(current_desktop)
        if topmost_window != "":
            try_activate_window(topmost_window)


# ----------------------------------------
# LOCKFILE helper functions


# Make sure the lock file is removed when we exit and when we receive a signal
def cleanup():
    os.unlink(LOCKFILE)


# If lockfile exists, then exit
def create_lockfile_or_quit():
    if os.path.exists(LOCKFILE):
        pid = open(LOCKFILE).read()
        try:
            os.kill(int(pid), 0)
            print("Already running...")
            print("")
            print("If you are sure that's not the case you can manually delete")
            print(f"the lockfile located at {LOCKFILE} and try again.")
            sys.exit()
        except OSError:
            pass

    atexit.register(cleanup)
    signal.signal(signal.SIGINT, lambda signal, frame: sys.exit(0))
    signal.signal(signal.SIGTERM, lambda signal, frame: sys.exit(0))

    with open(LOCKFILE, "w") as f:
        f.write(str(os.getpid()))


# ---------------------------------------------
# xdotool helper FUNCTIONS


def run_command_that_might_fail(command, fail_return_value):
    try:
        process = subprocess.Popen(
                command, stdout=subprocess.PIPE, stderr=subprocess.DEVNULL
                )
        stdout, _ = process.communicate()
        return stdout.decode().strip()
    except subprocess.CalledProcessError:
        return fail_return_value


def get_desktop():
    return run_command_that_might_fail(["xdotool", "get_desktop"], fail_return_value=-1)


def get_active_window():
    return run_command_that_might_fail(
            ["xdotool", "getactivewindow"], fail_return_value=-1
            )


def get_desktop_for_window(window):
    return run_command_that_might_fail(
            ["xdotool", "get_desktop_for_window", window], fail_return_value=""
            )


def unreliably_get_topmost_window_of_desktop(desktop):
    # The output from "xdotool search" is reverse-ordered according to how windows appear on the screen
    # So getting the last window from the current desktop is the way to go
    # This sometimes doesn't work and a window that is on the bottom appears on the top
    return (
            run_command_that_might_fail(
                ["xdotool", "search", "--desktop", str(desktop), "."], fail_return_value=""
                )
            .strip()
            .split("\n")[-1]
            )


def try_activate_window(window):
    output = run_command_that_might_fail(
            ["xdotool", "windowactivate", window], fail_return_value=-1
            )
    # Boolean return
    return output != -1


if __name__ == "__main__":
    main()

