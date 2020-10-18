#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# vi: set ft=python :
"""
LP Bug Tracker uses launchpadlib to get the Yaru-theme bugs.
The first time, the full list is saved in a json file.
The next times, the newly get list of LP yaru-theme bugs are compared with the ones
stored in the json file to show if any new issue was created since last check.
"""

import os
import json
import argparse
import subprocess
from launchpadlib.launchpad import Launchpad

HOME = os.path.expanduser("~")
CACHEDIR = os.path.join(HOME, ".launchpadlib", "cache")
YARU_LP_BUGS_FILE = "yaru_lp_bugs.json"
YARU_LP_BUGS_DIR = "launchpad"


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--get-lp-bugs", action="store_true", help="get Yaru active bugs on Launchpad"
    )
    parser.add_argument(
        "--diff-bugs",
        action="store_true",
        help="compare bug lists and save the new bugs.",
    )
    parser.add_argument("--destination", help="json file path to save a bug list")
    parser.add_argument("--source", help="json file path containing a bug list to read")

    args = parser.parse_args()

    if args.get_lp_bugs:
        get_lp_bugs(args.destination)

    if args.diff_bugs:
        diff_bugs(args.source, args.destination)


def create_issue(id, title, weblink):
    """ Create a new Bug using HUB """
    subprocess.run(
        [
            ".github/hub",
            "issue",
            "create",
            "--message",
            "LP#{} {}".format(id, title),
            "--message",
            "Reported first on Launchpad at {}".format(weblink),
            "--label",
            "Launchpad"
        ]
    )


def get_lp_bugs(dest):
    """ Get LP active bugs and save in dest as json file """
    bugs = get_yaru_launchpad_bugs()
    if not dest:
        dest = YARU_LP_BUGS_FILE
    elif os.path.isdir(dest):
        dest = os.path.join(dest, YARU_LP_BUGS_FILE)

    save_bug_list(bugs, dest)


def diff_bugs(source, destination):
    """Reads a list of bugs from the {source} json file,
    compares them with the ones stored in Yaru repo and
    save the list of the untracked bugs as json file in
    {destination}."""

    bugs_ref = get_bug_list(source)
    if not bugs_ref:
        print("[!] cannot find bugs in %s" % source)
        return

    bugs_stored = get_bug_list(os.path.join(YARU_LP_BUGS_DIR, YARU_LP_BUGS_FILE))
    bugs_diff = {}
    for id in bugs_ref:
        if bugs_stored.get(id, None) is None:
            print("Untracked LP bug: %s - %s" % (id, bugs_ref[id]["title"]))
            bugs_diff[id] = bugs_ref[id]

    if len(bugs_diff):
        # save_bug_list(bugs_diff, destination)
        for id, data in bugs_diff.items():
            create_issue(id, data["title"], data["link"])


def get_yaru_launchpad_bugs():
    """Get a list of active bugs from Launchpad"""

    lp = Launchpad.login_anonymously(
        "Yaru LP bug checker", "production", CACHEDIR, version="devel"
    )

    ubuntu = lp.distributions["ubuntu"]
    archive = ubuntu.main_archive

    packages = archive.getPublishedSources(source_name="yaru")
    package = ubuntu.getSourcePackage(name=packages[0].source_package_name)

    bug_tasks = package.searchTasks()
    bugs = {}

    for task in bug_tasks:
        id = str(task.bug.id)
        title = task.title.split(": ")[1]
        link = "https://bugs.launchpad.net/ubuntu/+source/yaru-theme/+bug/" + str(id)
        bugs[id] = {"title": title, "link": link}

    return bugs


def save_bug_list(bugs, destination):
    with open(destination, "w") as f:
        f.write(json.dumps(bugs, indent=2))


def get_bug_list(source):
    try:
        with open(source, "r") as f:
            bugs = json.loads(f.read())
    except FileNotFoundError:
        bugs = {}
    return bugs


if __name__ == "__main__":
    main()
