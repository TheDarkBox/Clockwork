--[[
	� 2014 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).

	Clockwork was created by Conna Wiles (also known as kurozael.)
	http://cloudsixteen.com/license/clockwork.html
--]]


--Called when the plugin is initialized.
function cwStaticEnts:Initialize()
	CW_CONVAR_STATICESP = Clockwork.kernel:CreateClientConVar("cwStaticESP", 0, true, true);
	
	Clockwork.setting:AddCheckBox("Admin ESP", "Show static entities.", "cwStaticESP", "Whether or not to show static entities in the admin ESP.", function()
		return Clockwork.player:IsAdmin(Clockwork.Client);
	end);
end;

local classTranslate = {
	["gmod_light"] = "Light",
	["prop_physics"] = "Prop",
	["prop_ragdoll"] = "Ragdoll",
	["gmod_lamp"] = "Lamp"
};

-- Called when the ESP info is needed.
function cwStaticEnts:GetAdminESPInfo(info)
	local info = info;

	if (self.staticEnts) then
		if (CW_CONVAR_STATICESP:GetInt() == 1) then
			for k, v in ipairs(self.staticEnts) do
				local class = classTranslate[v.class] or v.class;

				table.insert(info,{
					position = v.pos + Vector(0, 0, 32),
					color = Color(0, 210, 255, 255),
					text = "[Static "..class.."]"
				});
			end;
		end;
	end;
end;

-- Called to sync the ESP data.
Clockwork.datastream:Hook("staticESPSync", function(data)
	cwStaticEnts.staticEnts = data;
end);