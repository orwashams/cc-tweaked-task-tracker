--Basalt configurated installer
local filePath =
"basalt.lua"                                                                     --here you can change the file path default: basalt
if not (fs.exists(filePath)) then
    shell.run("pastebin run ESs1mg7P packed true " .. filePath:gsub(".lua", "")) -- this is an alternative to the wget command
end
local basalt = require(filePath:gsub(".lua", ""))

local w, h = term.getSize()

local programTitleContent = "Task Tracker"

local main = basalt.createFrame("mainFrame")
local objFrame = main:addFrame("objectFrame"):setPosition(1,1):setBackground(colors.lightGray):setSize(w, h)


local function visualButton(btn)
    btn:onClick(function(self) btn:setBackground(colors.black) btn:setForeground(colors.lightGray) end)
    btn:onClickUp(function(self) btn:setBackground(colors.gray) btn:setForeground(colors.black) end)
    btn:onLoseFocus(function(self) btn:setBackground(colors.gray) btn:setForeground(colors.black) end)
end

--objFrame:addScrollbar("exampleScrollbar"):setPosition(objFrame:getWidth(),1):setMaxValue(objFrame:getHeight()):setSize(1,objFrame:getHeight()):setSymbolSize(3):ignoreOffset():onChange(function(self) objFrame:setOffset(0, (self:getValue()-1)) end):setAnchor("topRight"):show():setZIndex(15)

local programTitle = objFrame:addLabel("programTitle"):setText(programTitleContent):setFontSize(2):setPosition(9, 2)

local todoLabel = objFrame:addLabel("todoLabel"):setText("Todo:"):setPosition(2,6)

local todoTextInput = objFrame:addInput("todoTextInput"):setSize("parent.w - 12",3):setPosition("todoLabel.x + 5", 5):setBackground(colors.gray)

local blueDividerPane = objFrame:addPane("dividerPane"):setSize("parent.w - 2", 1):setPosition(2, "todoTextInput.y + 3"):setBackground(false, "\140", colors.red)

local todosList = objFrame:addList("todosList"):setPosition(2 , "dividerPane.y + 1"):setSize(w-2,h-10):setScrollable(true)

function deleteItem(self, event, char)

  if(char=="d") then
    self:removeItem(self:getItemIndex())
  end
end

todosList:onChar(deleteItem)

local addTaskButton = objFrame:addButton():setText("Add"):setHorizontalAlign("center")
     :setVerticalAlign("center"):setPosition("todoTextInput.x + 35", 5):setSize(5,3):setBorder(colors.black)
     :onClick(function()
        local inputFieldValue = todoTextInput:getValue()
        
        if inputFieldValue == nil or inputFieldValue == '' then 
            return
        end

        todosList:addItem(" "..inputFieldValue)

        todoTextInput:setValue("")
    end)
     
visualButton(addTaskButton)

basalt.autoUpdate()