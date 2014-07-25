classPreferences ================

A cross platform preferences class for Xojo using SQLite.

#Revisions
#### 24 July 2014
First Release

#### 25 July 2014
Thanks to Axel Schneider for the addition of setColorValue and
getColorValue methods.
Also added the Optional Default as VariableType argument to each get
method.

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

##set Methods
The set methods all set the value of the specified type to the
preferences database. Keys are case insensitive but must be unique or
the method will replace the existing value stored in the preferences
database. 

All values are actually converted to string and stored in the
preferences database as text and then converted back to their datatype
when retrieved. This is transparent to you when coding.

###setBooleanValue(key as String, value as Boolean)
###
###setDoubleValue(key as String, value as Double)
###
###setSingleValue(key as String, value as Single)
###
###setColorValue(key as String, value as Color)
###
###setIntegerValue(key as String, value as Integer)
###
###setStringValue(key as String, value as String)
###
##get Methods
The get methods all return the value of the specified type from the
preferences database. Keys are case insensitive and must exist in the
database. If the key does not exists in the preferences database a
KeyNotFoundException will be raised. To avoid this the HasKey method can
be used prior to calling the get methods to check the existence of a
key. Alternatively pass the optional default value to be returned if the
key cannot be found, however, you will not be notified if the key was
not found and the method will return correctly.

###getBooleanValue(key as String,Optional default as Boolean) as Boolean
###
###getDoubleValue(key as String,Optional default as Double) as Double
###
###getSingleValue(key as String,Optional default as Single) as Single
###
###getColorValue(key as String,Optional default as Color) as Color
###
###getIntegerValue(key as String,Optional default as Integer) as Integer
###
###getStringValue(key as String,Optional default as String) as String
###
##Utility Methods
##
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
