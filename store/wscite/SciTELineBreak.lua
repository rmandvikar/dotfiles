-----------------------------------------------------------------------
-- SciTELineBreak: Implement line-breaking on key press for SciTE
------------------------------------------------------------------------
-- Copyleft 2013 by sdaau <sdaau@users.sf.net>
-- based in part on:
-- SciTEHexEdit: A Self-Contained Primitive Hex Editor for SciTE
-- Copyright 2005-2006 by Kein-Hong Man <khman@users.sf.net>
--
local VERSION, REVDATE = "0.1", "20130406"     -- version information
--
-- Development platform: Ubuntu Natty 11.04 Gnu/Linux
------------------------------------------------------------------------
-- Permission to use, copy, modify, and distribute this software and
-- its documentation for any purpose and without fee is hereby granted,
-- provided that the above copyright notice appear in all copies and
-- that both that copyright notice and this permission notice appear
-- in supporting documentation.
--
-- SDAAU DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
-- INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN
-- NO EVENT SHALL KEIN-HONG MAN BE LIABLE FOR ANY SPECIAL, INDIRECT OR
-- CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS
-- OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
-- NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION
-- WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
------------------------------------------------------------------------
-- Purpose:
-- Text editors like `geany` have an option "line breaking"; where if
-- typing beyond a certain character width, a line-break is
-- automatically inserted. This typically works for typing text, but
-- not for deleting text, or copy-pasting - and is different from the
-- concept of "line wrapping" (where no line-breaks are inserted - but
-- lines are visually 'broken' or 'wrapped' to fit the window).
--
-- In `SciTE`, one can use these variables in a User Options file
-- (.SciTEUser.properties), to show a "Column guide", (called
-- e.g. "margin line" in `gedit`):
--
-- edge.mode=1
-- edge.column=80
--
-- This "Column guide" line is simply a visual tool, to help with
-- indication of long lines; `SciTE`'s variable `wrap=1` otherwise
-- wraps text to the width of the window, and is independent of the
-- "Column guide" settings.
--
-- This add-on script works with the `edge.column` variable: the script
-- can have it's activity toggled, by calling its entry in `SciTE`'s
-- "Tools" menu; when active, it will scan keypresses - and if a
-- keypress occurs in a column beyond `edge.column`; it will enter a
-- line-break "\n" at the previous word boundary.
------------------------------------------------------------------------
-- QUICKSTART
-- * Copy this script to the same directory as .SciTEUser.properties
--   (usually, the home directory: ~)
-- * Load this script by adding `require("SciTELineBreak")` on top of
--   sciteLuaFunctions.lua (`SciTE`: Options/Open Lua Startup Script)
-- * Add the following to .SciTEUser.properties
--   (`SciTE`: Options/Open User Options File)
--
-- ext.lua.reset=0
-- command.name.18.*=Toggle Line Breaking
-- command.18.*=LineBreaker
-- command.subsystem.18.*=3
-- command.save.before.18.*=2
-- command.shortcut.36.*=Ctrl+Alt+B
--
-- Replace the `18` as appropriate; now when the Tools command is
-- triggered, it will call the LineBreaker() function.
------------------------------------------------------------------------

------------------------------------------------------------------------
-- main variables
------------------------------------------------------------------------

local isSciTELineBreakActive = false          -- master toggle variable
local lb = "\n"                               -- linebreak character

local SIG = "SciTELineBreak"

-- "cast"/convert to integer (atoi) first:
local edgecol = tonumber(props["edge.column"]);


------------------------------------------------------------------------
-- get string to print nil values
------------------------------------------------------------------------
local function pn(ins)
  return string.format("%s", type(ins))
end

------------------------------------------------------------------------
-- error log function
-- note: prepending ">" to output string, makes it color blue in
-- output pane!
------------------------------------------------------------------------
local function Error(msg) _ALERT(">"..SIG..": "..msg) end   -- error msg

------------------------------------------------------------------------
-- simple check for extman, partially emulate if okay to do so
-- mix from SciTEHexEdit's function, http://lua-users.org/wiki/SciteHexEdit
-- (simple way to add a handler only, can't remove like extman does)
-- and from example in http://lua-users.org/wiki/SciteExtMan .
-- As it is not part of a function, runs at
-- first time script is loaded (via require)
------------------------------------------------------------------------
if (OnChar) and not scite_OnChar then
  print("OnChar " .. pn(OnChar) .. " scite_Command " .. pn(scite_OnChar))
  Error("There is a handler conflict, please use extman")
else
  if not scite_OnChar then
    local _OnCh
    scite_OnChar = function(f, remove)
      if remove then _OnCh = nil else _OnCh = f end
    end
    OnChar = function(c) if _OnCh then return _OnCh(c) end end
  end
end



------------------------------------------------------------------------
-- handle incoming events
-- note: HandleChar hits when: after key is pressed (say at column 27);
-- but before character is inserted in editor
-- so at pos co=10; press key (HandleChar sees 10); char inserted co=11
-- see also http://www.scintilla.org/PaneAPI.html (and links therein)
-- DeleteRange (noworkforme):
-- http://www.scintilla.org/PaneAPI.html
-- DeleteBack (sel or if not, char before):
-- http://apostata.web.fc2.com/scite/scitelua.html
------------------------------------------------------------------------
local function HandleChar(c)
  if not isSciTELineBreakActive then return end    -- verify line breaking
  local curPos = editor.CurrentPos
  local curCol = editor.Column[curPos]
  local nextCol = curCol+1
  local wsp = editor:WordStartPosition(curPos, true)
  if nextCol > edgecol then
    if wsp < curPos then
      -- this is likely a character within a word
      editor:InsertText(wsp, lb)
    else
      -- this is likely a space
      editor:InsertText(curPos-1, lb)
      -- if we've broken at space, delete it
      -- (so the new line doesn't start with space)
      if c==" " then
        editor:DeleteBack() --:DeleteRange(curPos-1,1) --(curPos,-1)
      end
    end
  end
  -- debug:
  --local rep = string.format("HandleChar: %s (%d %d %d)", c, curPos, wsp, nextCol)
  --print(">"..SIG..": "..rep)
  return true
end


------------------------------------------------------------------------
-- line breaker initialization
------------------------------------------------------------------------

local function LineBreakerBase()
  --------------------------------------------------------------------
  -- initialize the user interface, initialize state
  --------------------------------------------------------------------

  -- set the local HandleChar as function to handle keypresses
  scite_OnChar(HandleChar)

  -- set up report string
  local lbn = string.format("line breaking (%d chars)", edgecol)

  -- check toggle
  if (isSciTELineBreakActive) then
    isSciTELineBreakActive = false
    buffer[SIG] = false;
    print(">"..SIG..": "..lbn.." was active; now is inactive.")
  else
    isSciTELineBreakActive = true
    buffer[SIG] = true;
    buffer.Mode = "edit"
    print(">"..SIG..": "..lbn.." was not active; now is active.")
  end
end

-- somehow SciTE needs this, otherwise it can't see current properties
-- also, LineBreaker is global function ; LineBreakerBase is local
-- LineBreakerBase directly: "Lua: error checking global scope for command"
function LineBreaker() LineBreakerBase() end

-- end of script
