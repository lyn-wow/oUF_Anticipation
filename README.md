oUF_Anticipation
================

Simple Plugin for oUF for tracking Anticipation stacks like Combo Points

*Written for Warlods of Draenor Beta. Should also work on Live if you change the .toc to 50400*

Usage
-------------

Using the Plugin in your layout is as easy as it is for the oUF built in Combo Point display.


    local Anticipation = {}
    for index = 1, 5 do
      local APoint = self:CreateTexture(nil, 'BACKGROUND')
    
      -- Position and size of the combo point.
      APoint:SetSize(16, 16)
      APoint:SetPoint('TOPLEFT', self, 'BOTTOMLEFT', index * APoint:GetWidth(), 0)
    
      Anticipation[index] = APoint
    end
    
    -- Register with oUF
    self.Anticipation = Anticipation
    

Hooks
-------------

You can completely override the Update function

    self.Anticipation.Override = function(self) ... end
