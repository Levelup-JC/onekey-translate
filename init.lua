-- OneKey Translate — Save 40%+ tokens by using English with LLMs
-- Cmd+E:       ZH → EN translate + replace in-place (before sending to LLM)
-- Cmd+Shift+E: EN → ZH translate + popup display (reading LLM output)
-- Double-tap E: Same as Cmd+E
--
-- Engine: Google Translate free API (with Apple Shortcuts fallback)

local PROXY = "http://127.0.0.1:7897"  -- set to nil if no proxy needed

local function ks(mods, k)
  hs.eventtap.keyStroke(mods or {}, k, 0)
end

-- ── Google Translate API ──
local function translate(text, from, to)
  if not text or text == "" then return nil end
  -- URL-encode via Python
  local safe = text:gsub("'", "'\\''")
  local encoded = hs.execute(
    "/usr/bin/python3 -c 'import urllib.parse,sys; print(urllib.parse.quote(sys.argv[1]))' '" .. safe .. "'"
  )
  if not encoded then return nil end
  encoded = encoded:gsub("\n$", "")
  -- Build URL and call
  local url = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=" .. from .. "&tl=" .. to .. "&dt=t&q=" .. encoded
  local cmd = "curl -s --max-time 5"
  if PROXY then cmd = cmd .. " --proxy " .. PROXY end
  cmd = cmd .. " '" .. url .. "'"
  local output, status = hs.execute(cmd)
  if status ~= 0 or not output then return nil end
  local result = output:match('%[%[%["([^"]+)"')
  return result
end

-- ── Apple Shortcuts fallback ──
local function translateShortcuts(text, from, to)
  local f = io.open("/tmp/_hs_input.txt", "w")
  if f then f:write(text); f:close() end
  local result = hs.execute("/usr/bin/shortcuts run '翻译所选内容' < /tmp/_hs_input.txt 2>/dev/null")
  if result then result = result:gsub("\n$", "") end
  return result
end

local function translateAuto(text, from, to)
  local r = translate(text, from, to)
  if not r or r == "" then r = translateShortcuts(text, from, to) end
  return r
end

-- ── Cmd+E: ZH → EN → replace in-place ──
local function zh2en()
  local app = hs.application.frontmostApplication()
  local orig = hs.pasteboard.getContents()

  ks({"cmd"}, "a"); hs.timer.usleep(150000)
  ks({"cmd"}, "c"); hs.timer.usleep(200000)

  local text = hs.pasteboard.getContents()
  if not text or text == "" then
    hs.alert.show("No text to translate", 1)
    return
  end

  local result = translateAuto(text, "zh-CN", "en")
  if not result or result == "" then
    hs.alert.show("Translation failed — check network or proxy", 2)
    if orig then hs.pasteboard.setContents(orig) end
    return
  end

  hs.pasteboard.setContents(result)
  if app then app:activate(); hs.timer.usleep(120000) end
  ks({"cmd"}, "v")
  hs.timer.doAfter(0.5, function()
    if orig then hs.pasteboard.setContents(orig) end
  end)
  hs.alert.show("Done", 0.6)
end

-- ── Cmd+Shift+E: EN → ZH → popup ──
local function en2zh()
  local orig = hs.pasteboard.getContents()

  ks({"cmd"}, "c"); hs.timer.usleep(200000)

  local text = hs.pasteboard.getContents()
  if not text or text == "" then
    hs.alert.show("No text selected", 1)
    return
  end

  local result = translateAuto(text, "en", "zh-CN")
  if not result or result == "" then
    hs.alert.show("Translation failed", 1)
    if orig then hs.pasteboard.setContents(orig) end
    return
  end

  hs.pasteboard.setContents(result)
  hs.alert.show(result, 5)
  hs.timer.doAfter(5.5, function()
    if orig then hs.pasteboard.setContents(orig) end
  end)
end

-- ── Bind hotkeys ──
hs.hotkey.bind({"cmd"}, "E", zh2en)
hs.hotkey.bind({"cmd", "shift"}, "E", en2zh)
hs.hotkey.bind({}, "F18", zh2en)

-- ── Double-tap E trigger ──
local lastE = 0
hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(e)
  if e:getKeyCode() ~= hs.keycodes.map.e then return false end
  local f = e:getFlags()
  if f.cmd or f.alt or f.ctrl or f.shift or f.fn then return false end
  local now = hs.timer.secondsSinceEpoch()
  if now - lastE <= 0.32 then
    lastE = 0
    hs.timer.doAfter(0.01, function() ks({}, "delete"); hs.timer.doAfter(0.03, zh2en) end)
    return true
  end
  lastE = now
  return false
end):start()

hs.alert.show("Cmd+E:ZH->EN | Cmd+Shift+E:EN->ZH | EE:ZH->EN", 2)
