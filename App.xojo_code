#tag Class
Protected Class App
Inherits Application
	#tag Event
		Sub Open()
		  Preferences = new classPreferences("PreferencesTest")
		End Sub
	#tag EndEvent


	#tag Property, Flags = &h0
		Preferences As classPreferences
	#tag EndProperty


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
