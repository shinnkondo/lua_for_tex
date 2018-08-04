-- Handy tool to generate macros for paper boxes with different colors.
-- It provides the following three environments with one argument:
--     mybox, exbox, albox
-- Providing same environments probably is doable using latex alone, but this is easier to see.

local paperbox = {}

local function generatemacro(name, colback, colframe, coltitle)
    return string.format([[
        \newtcolorbox{%s}[1]{
            enhanced,
            colback=%s,
            colframe=%s,
            arc=0.4mm,
            boxrule=0mm,
            fuzzy shadow={0mm}{-0.2mm}{0mm}{0.1mm}{black!50!white},
            fuzzy shadow={0mm}{0mm}{0mm}{0.2mm}{black!20!white},
            left=1mm,
            right=1mm,
            oversize,
            colbacktitle=white,
            coltitle=%s,
            fonttitle=\bfseries,
            detach title,
            title={#1},
            before upper={\tcbtitle\par}
        }
    ]], name, colback, colframe, coltitle)
end

--- Print multiple lines string to tex.
-- Tricks need to be used since usual new lines in Lua do not translate to new lines in TeX
-- @param lines multiple lines string
local function printlines2tex(lines)
    for line in  string.gmatch(lines, "[^\r\n]+") do
        tex.print(line)
    end
end

--- Set up before paperbox.new
function paperbox.setup()
    printlines2tex([[
        \usepackage{tcolorbox}
        \tcbuselibrary{skins}
    ]])
end

--- Create a custom paper box
function paperbox.new(name, colback, colframe, coltitle)
    printlines2tex(generatemacro(name, colback, colframe, coltitle))
end

--- Set up default paper boxes.
function paperbox.preset()
    paperbox.setup()
    printlines2tex([[
    \definecolor{mLightGreen}{HTML}{14B03D}
    \definecolor{mDarkTeal}{HTML}{23373b}
    \definecolor{mLightBrown}{HTML}{EB811B}
    ]])
    paperbox.new("mybox", "white", "black!30!white", "mDarkTeal")
	paperbox.new("exbox", "mLightGreen!3!white", "mLightGreen", "mLightGreen")
	paperbox.new("albox", "mLightBrown!3!white", "mLightBrown", "mLightBrown")
end

return paperbox