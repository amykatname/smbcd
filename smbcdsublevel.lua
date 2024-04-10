smbcdsublevel = class:new()

function smbcdsublevel:init(x, y, r, music)
	self.x = x
	self.y = y
	self.cox = x
	self.coy = y
	self.r = r
	local vars = {music}
	if music:find("|") then
		vars = music:split("|")
	end
	self.m = readlevelfilesafe(vars[1] or "")
	self.customn = vars[2] or 1
	self.music = "none"
	if self.m == "overworld" then
		self.music = "overworld"
	elseif self.m == "underground" then
		self.music = "underground"
	elseif self.m == "castle" then
		self.music = "castle"
	elseif self.m == "underwater" then
		self.music = "underwater"
	elseif self.m == "star" then
		self.music = "starmusic"
	elseif self.m == "custom" then
		if vars[2] then
			if custommusics[tonumber(self.customn) or 1] then
				self.music = custommusics[tonumber(self.customn) or 1]
			end
		else
			if custommusic then
				self.music = custommusic
			end
		end
	else
		self.music = mappackfolder .. "/" .. mappack .. "/" .. self.m
	end
	self.visible = ((vars[3] or "true") == "true")
	self.on = false
	
	self.outtable = {}
end

function smbcdsublevel:link()
	if #self.r > 3 then
		for j, w in pairs(outputs) do
			for i, v in pairs(objects[w]) do
				if tonumber(self.r[5]) == v.cox and tonumber(self.r[6]) == v.coy then
					v:addoutput(self)
				end
			end
		end
	end
end

function smbcdsublevel:draw()
	if self.visible then
	end
end

function smbcdsublevel:play()
	subleveltriggered = true
	fade_state = "Fade_To_Black"
	self.on = true
	donteatassinthehalls = true
end

function smbcdsublevel:stop()
	self.on = false
end


function smbcdsublevel:input(t)
	if t == "off" then
		if self.on then
			self:stop()
		end
	elseif t == "on" then
		if not self.on then
			self:play()
		end
	else
		if not self.on then
			self:play()
		else
			self:stop()
		end
	end
end