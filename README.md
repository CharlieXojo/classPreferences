classPreferences ================

A cross platform preferences class for Xojo using SQLite.

#Summary
classPreferences is a class to simply generate a preferences storage
mechanism using an SQLite database. Calling the constructor with:

####Dim prefs as new classPreferences([bundleID])
####
will create the database file if it does not exist already. Once the
file is created, simply use the get and set methods outlined below to
store and retrieve your applications settings.

#Events
###PreferencesChanged
PreferencesChanged is raised each time one of the set methods has
successfully written a value to the preferences file. It is useful for
updating your application when a user has changed one of their
preferences.

#Methods
#
###Constructor(bundleID as String)
The constructor's argument, bundleID, is the name which will be used for
your preferences file. The preferences file, by default, will be written
to SpecialFolder.ApplicationData and placed in a folder with the name of
bundleID and the file will be named bundleID.preferences. It is
therefore important that the bundleID argument contains a string which
will be valid for use as a folder and a filename on your platform.

###setBooleanValue(key as String, value as Boolean)
Allows you to pass a boolean value to be written to your preferences
file. 

All values are actually converted to string and stored in the
preferences database as text and then converted back to their datatype
when retrieved. This is transparent to you when coding.

Keys are case insensitive but must be unique.

###setDoubleValue(key as String, value as Boolean)
Allows you to pass a double value to be written to your preferences
file. 

All values are actually converted to string and stored in the
preferences database as text and then converted back to their datatype
when retrieved. This is transparent to you when coding.

Keys are case insensitive but must be unique.

###setIntegerValue(key as String, value as Boolean)
Allows you to pass an integer value to be written to your preferences
file. 

All values are actually converted to string and stored in the
preferences database as text and then converted back to their datatype
when retrieved. This is transparent to you when coding.

Keys are case insensitive but must be unique.

###setStringValue(key as String, value as Boolean)
Allows you to pass a string value to be written to your preferences
file. 

All values are actually converted to string and stored in the
preferences database as text and then converted back to their datatype
when retrieved. This is transparent to you when coding.

Keys are case insensitive but must be unique.

###getBooleanValue(key as String) as Boolean
Returns a boolean value from your preferences file. Keys are case
insensitive but must be unique. If the key does not exists in the
preferences file a KeyNotFoundException will be raised. To avoid this
the HasKey method can be used prior to calling the get methods to check
the existence of a key.

###getDoubleValue(key as String) as Double
Returns a double value from your preferences file. Keys are case
insensitive but must be unique. If the key does not exists in the
preferences file a KeyNotFoundException will be raised. To avoid this
the HasKey method can be used prior to calling the get methods to check
the existence of a key.

###getIntegerValue(key as String) as Integer
Returns an integer value from your preferences file. Keys are case
insensitive but must be unique. If the key does not exists in the
preferences file a KeyNotFoundException will be raised. To avoid this
the HasKey method can be used prior to calling the get methods to check
the existence of a key.

###getStringValue(key as String) as String
Returns a string value from your preferences file. Keys are case
insensitive but must be unique. If the key does not exists in the
preferences file a KeyNotFoundException will be raised. To avoid this
the HasKey method can be used prior to calling the get methods to check
the existence of a key.

###deleteValue(key as string)
Deletes a key and value pair from your preferences file. Keys are case
insensitive but must be unique. If the key does not exists in the
preferences file a KeyNotFoundException will be raised. To avoid this
the HasKey method can be used prior to calling the get methods to check
the existence of a key.

###hasKey(key as string) as Boolean
Checks the preferences file for the existence of key. Returns true if
the key exists, false if not.
Useful for checking the existence of a key prior to calling any of the
get methods if you are unsure if the key exists.
