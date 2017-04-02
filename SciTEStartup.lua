-- clip FileDir
function ClipFileDir()
	editor:CopyText(props['FileDir'])
end

-- clip FileName
function ClipFileName()
	editor:CopyText(props['FileNameExt'])
end

--~ http://www.scintilla.org/SciTEFAQ.html#ToolsNoMenu
--~ http://www.scintilla.org/CommandValues.html
--~ http://lua-users.org/wiki/SciteScripts
--~ http://lua-users.org/wiki/UsingLuaWithScite
--~ http://www.scintilla.org/PaneAPI.html
