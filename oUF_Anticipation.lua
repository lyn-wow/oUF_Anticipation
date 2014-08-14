if(select(2, UnitClass('player')) ~= 'ROGUE') then return end
 
local _, ns = ...
local cfg = ns.cfg
local oUF = ns.oUF or oUF
assert(oUF, "<name> was unable to locate oUF install.")
 
local MAX_ANTICIPATION_POINTS = 5
local ANTICIPATION = GetSpellInfo(115189)
 
local Update = function(self, event, unit)
    if unit ~= 'player' then return end
    
    local apoints = self.Anticipation
    local _, _, _, ap = UnitBuff('player', ANTICIPATION)
    
    if ap == nil then
        ap = 0
    end
           
    for i=1, MAX_ANTICIPATION_POINTS do
        if(i <= ap and UnitExists('target')) then
            apoints[i]:Show()
        else
            apoints[i]:Hide()
        end
    end
 
    if(apoints.PostUpdate) then
        return apoints:PostUpdate(ap)
    end
end
 
local Path = function(self, ...)
    return (self.Anticipation.Override or Update) (self, ...)
end
 
local ForceUpdate = function(element)
    return Path(element.__owner, 'ForceUpdate', element.__owner.unit)
end
 
local Enable = function(self)
    local apoints = self.Anticipation
    if(apoints) then
        apoints.__owner = self
        apoints.ForceUpdate = ForceUpdate
 
        self:RegisterEvent('UNIT_AURA', Path, true)
        self:RegisterEvent('PLAYER_TARGET_CHANGED', Path, true)
 
        return true
    end
end
 
local Disable = function(self)
    local apoints = self.Anticipation
    if(apoints) then
        for index = 1, MAX_ANTICIPATION_POINTS do
            apoints[index]:Hide()
        end
        self:UnregisterEvent('UNIT_AURA', Path)
        self:UnregisterEvent('PLAYER_TARGET_CHANGED', Path)
    end
end
 
oUF:AddElement('Anticipation', Path, Enable, Disable)
