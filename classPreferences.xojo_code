#tag Class
Protected Class classPreferences
	#tag Method, Flags = &h0
		Sub Constructor(bundleID as String)
		  Dim prefFile as FolderItem
		  
		  prefDB = new SQLiteDatabase
		  
		  prefFile = SpecialFolder.ApplicationData.Child(bundleID)
		  
		  prefFile.CreateAsFolder
		  
		  prefFile = SpecialFolder.ApplicationData.Child(bundleID).Child(bundleID + ".preferences")
		  
		  prefDB.DatabaseFile = prefFile
		  
		  if not prefFile.Exists then
		    if CreatePrefsFile = False then
		      MsgBox  "Error creating preferences file"
		      exit Sub
		    end if
		  end if
		  
		  if prefDB.Connect = False then
		    MsgBox "Error connecting to preferences file"
		  end if
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function createPrefsFile() As Boolean
		  if prefDB.CreateDatabaseFile = False then
		    Return False
		  else
		    prefDB.SQLExecute("CREATE TABLE tblPreferences(id integer PRIMARY KEY AUTOINCREMENT,key varchar,value varchar);")
		    return True
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub deleteValue(key as String)
		  Dim rs as RecordSet
		  
		  //Check the database is connected
		  if prefDB.Connect = True then
		    //Get any records where key already exists
		    rs = prefDB.SQLSelect("SELECT * FROM tblPreferences WHERE key='" + Uppercase(key) + "'")
		    if prefDB.Error then
		      MsgBox prefDB.ErrorMessage
		    end if
		    
		    if rs.RecordCount = 0 then
		      Raise new KeyNotFoundException
		    else
		      prefDB.SQLExecute("DELETE FROM tblPreferences WHERE key='" + Uppercase(key) + "'")
		    end if
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getBooleanValue(key as String, Optional default as Boolean) As Boolean
		  Return (GetValue(key,default)="TRUE")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getColorValue(key as variant, Optional default as Color) As color
		  dim v as Variant = (GetValue(key,default))
		  Return v.ColorValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getDoubleValue(key as string, Optional default as Double) As Double
		  Return CDbl(GetValue(key,default))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getIntegerValue(key as string, Optional default as Integer) As Integer
		  Return CDbl(GetValue(key,default))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getPictureValue(key as String, Optional default as picture) As Picture
		  dim tmpDef as Variant
		  
		  if default <> Nil then
		    tmpDef = EncodeBase64(default.GetData(Picture.FormatPNG))
		  end  if
		  
		  return Picture.FromData(DecodeBase64(getValue(key,tmpDef)))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getSingleValue(key as string, Optional default as Single) As Single
		  Return CDbl(GetValue(key,default))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getStringValue(key as string, Optional default as String) As String
		  Return GetValue(key,default)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getValue(key as String, Optional default as Variant) As String
		  Dim rs as RecordSet
		  
		  //Check the database is connected
		  if prefDB.Connect = True then
		    //Get any records where key already exists
		    rs = prefDB.SQLSelect("SELECT * FROM tblPreferences WHERE key='" + Uppercase(key) + "'")
		    if prefDB.Error then
		      MsgBox prefDB.ErrorMessage
		    end if
		    
		    if rs.RecordCount = 0 then
		      if default <> nil then
		        return default
		      Else
		        Raise new KeyNotFoundException
		      end if
		    else
		      return rs.Field("value").StringValue
		    end if
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function hasKey(key as String) As Boolean
		  Dim rs as RecordSet
		  
		  //Check the database is connected
		  if prefDB.Connect = True then
		    //Get any records where key already exists
		    rs = prefDB.SQLSelect("SELECT * FROM tblPreferences WHERE key='" + Uppercase(key) + "'")
		    if prefDB.Error then
		      MsgBox prefDB.ErrorMessage
		    end if
		    
		    if rs.RecordCount = 0 then
		      return False
		    else
		      return True
		    end if
		    
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setBooleanValue(key as String, value as Boolean)
		  SetValue(key,str(value))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setColorValue(key as String, value as Color)
		  SetValue(key,value)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setDoubleValue(key as String, value as Double)
		  SetValue(key,value)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setIntegerValue(key as String, value as Integer)
		  SetValue(key,str(value))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setPictureValue(key as string,value as Picture)
		  SetValue(key,EncodeBase64(value.GetData(Picture.FormatPNG)))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setSingleValue(key as String, value as single)
		  SetValue(key,value)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setStringValue(key as String, value as String)
		  SetValue(key,value)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub setValue(key as string, value as variant)
		  Dim ps As PreparedSQLStatement
		  Dim rs As RecordSet
		  
		  //Check the database is connected
		  If prefDB.Connect =True Then
		    //Get any records where key already exists
		    rs = prefDB.SQLSelect("SELECT * FROM tblPreferences WHERE key='" + Uppercase(key) + "'")
		    If prefDB.Error Then
		      MsgBox prefDB.ErrorMessage
		    End If
		    
		    //If the key does not already exist
		    If rs.RecordCount = 0 Then
		      ps = prefDB.Prepare("INSERT INTO tblPreferences (key,value) VALUES (?,?)")
		      ps.Bind(0, Uppercase(key), SQLitePreparedStatement.SQLITE_TEXT)
		      ps.Bind(1, Str(value), SQLitePreparedStatement.SQLITE_TEXT)
		      ps.SQLExecute
		      If prefDB.Error Then
		        MsgBox prefDB.ErrorMessage
		      End If
		    Else
		      //Otherwise if it does exists update the value with the new value
		      ps = prefDB.Prepare("UPDATE tblPreferences SET value=? WHERE key=?")
		      ps.Bind(0, Str(value), SQLitePreparedStatement.SQLITE_TEXT)
		      ps.Bind(1, Uppercase(key), SQLitePreparedStatement.SQLITE_TEXT)
		      ps.SQLExecute
		    End If
		    
		    RaiseEvent PreferencesChanged
		    
		  End If
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event PreferencesChanged()
	#tag EndHook


	#tag Property, Flags = &h21
		Private prefDB As SQLiteDatabase
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
