local entmeta = FindMetaTable("Entity")

function entmeta:Horde_AddBreakEffect(duration, inflictor)
    if self:IsPlayer() then
        local old_health = self:Health()
        self:SetHealth(math.min(old_health, self:GetMaxHealth() * HORDE.difficulty_break_health_left[HORDE.difficulty]))
        local recover = (1 + old_health - self:Health()) / duration
        if recover <= 0 then return end
        local str = "Horde_BreakRecovery" .. self:SteamID()
        timer.Create(str, 1, 0, function ()
            if not self:IsValid() or self:Health() >= old_health then timer.Remove(str) return end
            self:SetHealth(math.min(old_health, self:Health() + recover))
        end)
    else
        if not self:IsValid() then return end
        local dmg = DamageInfo()
        if inflictor and inflictor:IsValid() then
            dmg:SetAttacker(inflictor)
            dmg:SetInflictor(inflictor)
        else
            dmg:SetAttacker(self)
            dmg:SetInflictor(self)
        end
        dmg:SetDamageType(DMG_NERVEGAS)
        dmg:SetDamage(150 + self:Health() * 0.1)
        self:TakeDamageInfo(dmg)
    end
end