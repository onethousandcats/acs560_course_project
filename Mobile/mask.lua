local M = {}
 
local GENERIC_MASK_FILE = "images/generic_mask.png"
local GENERIC_MASK_WIDTH = 400
local GENERIC_MASK_HEIGHT = 400
M.applyMask = function(params)
    if params.object == nil then
        return
    end
    if params.width == nil then
        params.width = params.object.width
    end
    if params.height == nil then
        params.height = params.object.height
    end
 
    local myMask = graphics.newMask(GENERIC_MASK_FILE)
    params.object:setMask(myMask)
    params.object.maskScaleX = params.width/GENERIC_MASK_WIDTH
    params.object.maskScaleY = params.height/GENERIC_MASK_HEIGHT
    --there may be a need in the future add logic to the positioning for different reference points
    params.object.maskX = params.width/2
    params.object.maskY = params.height/2
 
end
 
return M