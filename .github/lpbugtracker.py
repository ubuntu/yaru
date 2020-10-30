#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# vi: set ft=python :
"""
Launchpad Bug Tracker uses launchpadlib to get the Yaru-theme bugs.
The first time, the full list is saved in a json file.
The next times, the newly get list of Launchpad yaru-theme bugs are compared with the ones
stored in the json file to show if any new issue was created since last check.
"""

import os
import subprocess
import logging
from launchpadlib.launchpad import Launchpad

log = logging.getLogger("lpbugtracker")
log.setLevel(logging.DEBUG)

HUB = ".github/hub"
HOME = os.path.expanduser("~")
CACHEDIR = os.path.join(HOME, ".launchpadlib", "cache")


def main():
    lp_bugs = get_yaru_launchpad_bugs()
    if len(lp_bugs) == 0:
        return

    gh_tracked_lp_bugs = get_gh_bugs()

    for id in lp_bugs:
        tag = "LP#%s" % id
        if tag not in gh_tracked_lp_bugs:
            create_issue(id, lp_bugs[id]["title"], lp_bugs[id]["link"])


def get_yaru_launchpad_bugs():
    """Get a list of Yaru bugs from Launchpad"""

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


def get_gh_bugs():
    """Get the list of the LP bug already tracked in GitHub.

    Launchpad bugs tracked on GitHub have a title like

    "LP#<id> <title>"

    this function returns a list of the "LP#<id>" substring for each bug,
    open or closed, found on Yaru repository on GitHub.
    """

    output = subprocess.check_output(
        [HUB, "issue", "--labels", "Launchpad", "--state", "all"]
    )
    return [
        line.strip().split()[1] for line in output.decode().split("\n") if "LP#" in line
    ]


def create_issue(id, title, weblink):
    """ Create a new Bug using HUB """
    print("creating:", id, title, weblink)
    subprocess.run(
        [
            HUB,
            "issue",
            "create",
            "--message",
            "LP#{} {}".format(id, title),
            "--message",
            "Reported first on Launchpad at {}".format(weblink),
            "-l",
            "Launchpad",
        ]
    )


if __name__ == "__main__":
    main()
