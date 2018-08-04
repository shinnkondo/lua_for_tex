local common = {}

--- Print multiple lines string to tex.
-- Tricks need to be used since usual new lines in Lua do not translate to new lines in TeX
-- @param lines multiple lines string
function common.printlines2tex(lines)
    for line in  string.gmatch(lines, "[^\r\n]+") do
        tex.print(line)
    end
end

return common