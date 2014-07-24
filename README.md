classPreferences
================

A cross platform preferences class for Xojo using SQLite

###Methods

#Constructor(bundleID as String)
The constructor's argument, bundleID, is the name which will be used for your preferences file. The preferences file, by default, will be written to SpecialFolder.ApplicationData and placed in a folder with the name of bundleID and the file will be named bundleID.preferences. It is therefore important that the bundleID argument contains a string which will be valid for use as a folder and a filename on your platform.

