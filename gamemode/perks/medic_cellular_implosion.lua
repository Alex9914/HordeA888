PERK.PrintName = "Cellular Implosion"
PERK.Description = "Enemies you killed have 20% chance to generate a healing cloud."

PERK.Parameters = {}

PERK.Hooks = {}

PERK.Hooks.OnNPCKilled = function(victim, killer, inflictor)
    if not victim:IsValid() or not victim:IsNPC() or not killer:IsPlayer() then return end
    if not killer:Horde_GetPerk("medic_cellular_implosion") then return end
    if inflictor:IsNPC() then return end -- Prevent infinite chains
    local p = math.random()
    if p <= 0.2 then
        local ent = ents.Create("arccw_thr_medicgrenade")
        ent:SetPos(victim:GetPos())
        ent:SetModel(nil)
        ent:Spawn()
        ent:Detonate()
        ent:GetPhysicsObject():EnableMotion(false)
        timer.Simple(2.5, function() if ent:IsValid() then ent:Remove() end end)
    end
end