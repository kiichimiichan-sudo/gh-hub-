-- Fixed main.lua file

-- Function to handle mouse button down and up events
function mouse1click()
    -- Replace mouse1click() with mouse:Button1Down() and mouse:Button1Up()
end

-- Updated setupAntiExplosion to check character parent
function setupAntiExplosion()
    if character and character.Parent then
        -- Proceed with function
    else
        -- Handle character parent check failure
    end
end

-- Ensure _G.BlobTargetName is properly set in dropdown callback
function onDropdownCallback(value)
    _G.BlobTargetName = value
end
