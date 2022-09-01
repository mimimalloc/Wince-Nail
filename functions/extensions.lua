-- Allows for loops to be traversed in order of keys
function keySorted (t, f)
  local a = {}
  for n in pairs(t) do table.insert(a, n) end
  table.sort(a, f)
  local i = 0
  local iter = function ()
    i = i + 1
    if a[i] == nil then return nil
    else return a[i], t[a[i]]
    end
  end
  return iter
end

-- Pushes data into the end of a table
function tPush(table, entry)
  table[#table+1] = entry
  return table[#table]
end

-- Inverts a table(if you need to get a key)
function table_invert(t)
   local s={}
   for k,v in pairs(t) do
     s[v]=k
   end
   return s
end

-- Finds the key of a value using the table inversion
function getKey(t, item)
  tR = table_invert(t)
  return tR[item]
end
