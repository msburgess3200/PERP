


function GM.CalcRagdollEyes ( Player, Origin, Angles, FOV )
	if Player:Alive() then return; end
	
	local Ragdoll = Player:GetRagdollEntity();
	if !Ragdoll or !Ragdoll:IsValid() then return; end
	
	local EyePos = Ragdoll:GetAttachment(Ragdoll:LookupAttachment("eyes"));
	
	local NView = {
		origin = EyePos.Pos,
		angles = EyePos.Ang,
		fov = 90
	};
	
	return NView;
end
hook.Add('CalcView', 'GM.CalcRagdollEyes', GM.CalcRagdollEyes);