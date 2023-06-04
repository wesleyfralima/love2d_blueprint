Camera = Class()

function Camera:init(def)
    self.x = def.x or def.windowWidth/2
    self.y = def.y or def.windowHeight/2
    self.scaleX = def.scaleX or 1
    self.scaleY = def.scaleY or self.scaleX
    self.rotation = def.rotation or 0

    self.windowWidth = def.windowWidth
    self.windowHeight = def.windowHeight

    self.following = def.following or nil
end

--[[
    No need to update if the camera is not
    following an object.
]]
function Camera:update(dt)
    if self.following == nil then 
        error('Camera is not following any object. No need to update.')
    end

    self:follow()
end

function Camera:render()
    
end

--[[
    This method simply points the camera to a point.
    In order to update, it needs to be placed inside
    any update()

    The way that the camera is implemented now, this
    makes nothing if the camera is following an object
--]]
function Camera:pointAt(x, y)
    if self.following ~= nil then return end
    self.x = - x
    self.y = - y
end

--[[
    Similar to Camera:pointAt(), this methods follows
    and object's position. No need to be placed in an
    update() besause it is updated in Camera:update()
--]]
function Camera:follow()
    local offsetX = self.following.width/2 or 0
    local offsetY = self.following.height/4 or 0

    self.x = - self.following.x - offsetX
    self.y = - self.following.y - offsetY
end

--[[
    Defines the object for the camera to follow
]]
function Camera:startFollowing(obj)
    self.following = obj
end

--[[
    Makes the camera to do not follow any object
]]
function Camera:stopFollowing(obj)
    self.following = nil
end


--[[
    Starts the process of drawing through the camera's eyes
]]
function Camera:startFilming()
    love.graphics.push()
    love.graphics.rotate(-self.rotation)
    love.graphics.scale(1/self.scaleX, 1/self.scaleY)
    love.graphics.translate(
        self.x + self.windowWidth/2,
        self.y + self.windowHeight/2
    )
end

--[[
    Finishes the process of drawing through the camera's eyes
]]
function Camera:stopFilming()
    love.graphics.pop()
end