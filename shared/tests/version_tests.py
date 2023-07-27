"""
tests/version_tests.py

This script contains tests for pythonedashared/version.py

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

from pythonedasharedgit.version import Version

import unittest


class VersionTests(unittest.TestCase):
    """
    Defines tests for pythonedasharedgit/version.py.

    Class name: VersionTests

    Responsibilities:
        - Validates the functionality of the Version class.

    Collaborators:
        - Version: The subject under test.
    """

    def test_increase_major_version_0_0_1_a5(self):
        """
        Checks if the method "increase_major" behaves correctly for 0.0.1-a5.
        """
        # given
        tag = "0.0.1-a5"
        sut = Version(tag)

        # when
        result = sut.increase_major().value

        # then
        expected = "1.0.0"
        assert result == expected, f"Expected '{expected}', but got '{result}'"

    def test_increase_minor_version_0_0_1_a5(self):
        """
        Checks if the method "increase_minor" behaves correctly for 0.0.1-a5.
        """
        # given
        tag = "0.0.1-a5"
        sut = Version(tag)

        # when
        result = sut.increase_minor().value

        # then
        expected = "0.1.0"
        assert result == expected, f"Expected '{expected}', but got '{result}'"

    def test_increase_patch_version_0_0_1_a5(self):
        """
        Checks if the method "increase_patch" behaves correctly for 0.0.1-a5.
        """
        # given
        tag = "0.0.1-a5"
        sut = Version(tag)

        # when
        result = sut.increase_patch().value

        # then
        expected = "0.0.2"
        assert result == expected, f"Expected '{expected}', but got '{result}'"

    def test_increase_prerelease_version_0_0_1_a5(self):
        """
        Checks if the method "increase_prerelease" behaves correctly for 0.0.1-a5.
        """
        # given
        tag = "0.0.1-a5"
        sut = Version(tag)

        # when
        result = sut.increase_prerelease().value

        # then
        expected = "0.0.1-a6"
        assert result == expected, f"Expected '{expected}', but got '{result}'"

    def test_increase_prerelease_version_0_0_1_a6(self):
        """
        Checks if the method "increase_prerelease" behaves correctly for 0.0.1-a6.
        """
        # given
        tag = "0.0.1-a6"
        sut = Version(tag)

        # when
        result = sut.increase_prerelease().value

        # then
        expected = "0.0.1-a7"
        assert result == expected, f"Expected '{expected}', but got '{result}'"

    def test_increase_build_version_0_0_1_a6(self):
        """
        Checks if the method "increase_prerelease" behaves correctly for 0.0.1-a6.
        """
        # given
        tag = "0.0.1-a6"
        sut = Version(tag)

        # when
        result = sut.increase_build().value

        # then
        expected = "0.0.1-a6+build.1"
        assert result == expected, f"Expected '{expected}', but got '{result}'"


if __name__ == "__main__":
    unittest.main()
