local intro_finish

function intro_load()
	gamestate = "intro"

	famicomcdlogo_duration = famicomcdlogo_introsound:getDuration('seconds') + 1
	
	introduration = famicomcdlogo_duration + 2
	blackafterintro = 0.3
	introfadetime = 0.5
	introprogress = -0.5
	
	screenwidth = width*16*scale
	screenheight = 224*scale
	allowskip = false
end

function intro_update(dt)
	allowskip = true
	if introprogress < introduration+blackafterintro then
		introprogress = introprogress + dt
		if introprogress > introduration+blackafterintro then
			introprogress = introduration+blackafterintro
		end
		
		if introprogress > 0.1 and playedwilhelm == nil then
			playsound(famicomcdlogo_introsound)
			
			playedwilhelm = true
		end
		
		if introprogress == introduration + blackafterintro then
			intro_finish()
		end
	end
	--intro_finish()
end

function intro_draw()
	local logoscale = scale
	if logoscale <= 1 then
		logoscale = 0.5
	else
		logoscale = 1
	end

	logoscale = logoscale*0.12

	if introprogress >= 0 and introprogress < introduration then
		if introprogress <= famicomcdlogo_duration then
			local a = 255
			if introprogress < introfadetime then
				a = introprogress/introfadetime * 255
			elseif introprogress >= famicomcdlogo_duration-introfadetime then
				a = (1-(introprogress-(famicomcdlogo_duration-introfadetime))/introfadetime) * 255
			end
			
			love.graphics.setColor(255, 255, 255, a)

			love.graphics.rectangle("fill", 0,0, love.graphics.getWidth(), love.graphics.getHeight())

			logoWidth, logoHeight = logo:getDimensions()

			love.graphics.draw(
				logo, screenwidth/2, screenheight/2, 0, logoscale-0.005, logoscale-0.005, logoWidth/2, logoHeight/2
			)
		end
	end
end

function intro_mousepressed()
	if not allowskip then
		return
	end
	stabsound:stop()
	intro_finish()
end

function intro_keypressed()
	if not allowskip then
		return
	end
	stabsound:stop()
	intro_finish()
end

function intro_finish()
	menu_load()
	logo = nil
	logoblood = nil
end