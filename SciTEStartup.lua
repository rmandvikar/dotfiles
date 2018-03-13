-- clip FileDir
function ClipFileDir()
	editor:CopyText(props['FileDir'])
end

-- clip FileName
function ClipFileName()
	editor:CopyText(props['FileNameExt'])
end

-- CutAllowLine: cut line if selection empty else cut selection
function CutAllowLine()
	if editor.SelectionEmpty then
		-- LineCut does not put \n at end if line does not have one
		editor:CopyAllowLine()
		editor:LineDelete()
	else
		editor:Cut()
	end
end

--~ http://www.scintilla.org/SciTEFAQ.html#ToolsNoMenu
--~ http://www.scintilla.org/CommandValues.html
--~ http://lua-users.org/wiki/SciteScripts
--~ http://lua-users.org/wiki/UsingLuaWithScite
--~ http://www.scintilla.org/PaneAPI.html
