--[[
local utils = {}
utils.strsplit = function(delimiter, subject)
  if not subject then return nil end
  local delimiter, fields = delimiter or ":", {}
  local pattern = string.format("([^%s]+)", delimiter)
  string.gsub(subject, pattern, function(c) fields[#fields + 1] = c end)
  return table.unpack(fields)
end

function print_r(obj, indent)
    indent = indent or 0
    local spaces = string.rep("  ", indent)
    
    if type(obj) == "table" then
        print(spaces .. "{")
        for k, v in pairs(obj) do
            io.write(spaces .. "  [" .. tostring(k) .. "] = ")
            if type(v) == "table" then
                print()
                print_r(v, indent + 1)
            else
                print(tostring(v))
            end
        end
        print(spaces .. "}")
    else
        print(tostring(obj))
    end
end

local filter_texts = { utils.strsplit(',', 'test@pvp,test@pve,group@normal') }
print('input' .. filter_texts[1])
local count = 1;

local root = {}
root.filter = {}

for id, filter_text in pairs(filter_texts) do
  local name, args = utils.strsplit(':', filter_text)
  -- print(name)
  local group, realName = utils.strsplit('@', name)
  -- print(group .. ' - ' .. realName)
  group = group or ('default' .. count);
  count = count + 1
  if not root.filter[group] then
    root.filter[group] = {}
  end
  root.filter[group][realName] = args or tonumber
end
print_r(root)
print('done')

]]