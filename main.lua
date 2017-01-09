-- 
-- Abstract: logger Library Plugin Test Project
-- 
-- Sample code is MIT licensed, see http://www.coronalabs.com/links/code/license
-- Copyright (C) 2016 Yoger Games AB. All Rights Reserved.
--
------------------------------------------------------------
local widget = require "widget"


-- Require the plugin
local logger = require("plugin.logger")

-- Create the options table
local options = {}

-- Set a different table depending on the environment / device
if system.getInfo( "environment" ) == "simulator" then
    options.highlight_errors = true
    options.highlight_warnings = true
    options.log_levels = {
        global = logger.LEVELS.DEBUG, 
        main = logger.LEVELS.DUMP
    }
elseif system.getInfo("deviceID") == "xxx" then
    options.highlight_errors = true
    options.highlight_warnings = false
    options.log_levels = {
        global = logger.LEVELS.LOG, 
        crosspromo = logger.LEVELS.DUMP
    }
else
    options.highlight_errors = true
    options.highlight_warnings = false
    options.log_levels = {
        global = logger.LEVELS.ERROR 
    }
end

-- Initialize logger with the options table
logger.init(options)

-- Additional log levels can be set after init
----------------------------------------------
-- logger.setLogLevel(logger.LEVELS.DUMP, "main")
-- logger.setGlobalLogLevel(logger.LEVELS.DEBUG, false)
display.setDefault( "background", 1, 1, 1 )

local xPos, yPos = display.contentCenterX, display.contentCenterY
local widthBtn, heightBtn = display.contentWidth * 0.8, 50
local btnFontSize = 12
local numButtons = 7
local currentBtn = 0

local function createButton(textLabel, callback)
    currentBtn = currentBtn + 1
    return widget.newButton{
        x = xPos, y = currentBtn * display.contentHeight / (numButtons + 1),
        width = widthBtn, height = heightBtn,
        label = textLabel,
        labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0 } },
        fontSize = btnFontSize,
        onRelease = callback,
        -- Properties for a rounded rectangle button
        shape = "roundedRect",
        cornerRadius = 2,
        fillColor = { default={1/255,87/255,155/255,1}, over={128/255,216/255,255/255,0.4} },
        strokeColor = { default={0/255,145/255,234/255,1}, over={0/255,176/255,255/255,1} },
        strokeWidth = 4
    }
end


-- Set log level for channel "main" to LOG
----------------------------------------------
local btn1 = createButton("setLogLevel ( LOG, 'main' )", function()
        logger.setLogLevel(logger.LEVELS.LOG, "main")
		logger.printLogLevels()
    end
)

-- Set log level for channel "main" to DEBUG
----------------------------------------------
createButton("setLogLevel ( DEBUG, 'main' )", function()
        logger.setLogLevel(logger.LEVELS.DEBUG, "main")
		logger.printLogLevels()
    end
)

-- Set log level for channel "main" to DUMP
----------------------------------------------
createButton("setLogLevel ( DUMP, 'main' )", function()
        logger.setLogLevel(logger.LEVELS.DUMP, "main")
		logger.printLogLevels()
    end
)

-- Log a highlighted error
----------------------------------------------
createButton("logger.error ('main', 'an error occurred')", function()
        logger.error("main", "an error occurred")
    end
)

-- Log a highlighted warning
----------------------------------------------
createButton("logger.warning ('main', 'a warning message')", function()
        logger.warning("main", "a warning message")
    end
)

-- Log a dump message
----------------------------------------------
createButton("logger.dump ('main', 'a dump message')", function()
        logger.dump("main", "a dump message")
    end
)

-- Log complex AND multiple parameters
----------------------------------------------
local myComplexTable = { param = "key", param2 = { nestedKey = "nestedValue"}}

createButton("logger.log ( 'main', myComplexTable, ...)", function()
        logger.log("main", myComplexTable, 1, true, "stringValue")
    end
)