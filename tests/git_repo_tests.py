"""
tests/git_repo_tests.py

This script contains tests for pythonedashared/git_repo.py

Copyright (C) 2023-today rydnr's pythoneda-shared/git

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
"""
import sys
from pathlib import Path

base_folder = str(Path(__file__).resolve().parent.parent)
if base_folder not in sys.path:
    sys.path.append(base_folder)

from pythonedasharedgit.git_repo import GitRepo

import re
import unittest

class GitRepoTests(unittest.TestCase):
    """
    Defines tests for pythonedasharedgit/git_repo.py.

    Class name: GitRepoTests

    Responsibilities:
        - Validates the functionality of the GitRepo class.

    Collaborators:
        - GitRepo: The subject under test.
    """

    def test_url_is_a_git_repo(self):
        """
        Checks if the method "url_is_a_git_repo()" behaves correctly.
        """
        # given
        url = "https://github.com/pythoneda/base"

        # when
        result = GitRepo.url_is_a_git_repo(url)

        # then
        assert result

    def test_tag_exists_for_existing_tag(self):
        """
        Checks if the method "tag_exists()" behaves correctly when the tag exists.
        """
        # given
        url = "https://github.com/pythoneda/base"
        tag = "0.0.1a5"

        # when
        result = GitRepo.tag_exists(url, tag)

        # then
        assert result

    def test_tag_exists_for_non_existing_tag(self):
        """
        Checks if the method "tag_exists()" behaves correctly when the tag does not exist.
        """
        # given
        url = "https://github.com/pythoneda/base"
        tag = "0.0.1-5"

        # when
        result = GitRepo.tag_exists(url, tag)

        # then
        assert not result

if __name__ == '__main__':
    unittest.main()
