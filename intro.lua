local intro_finish

function intro_load()
	gamestate = "intro"

	famicomcdlogo_duration = famicomcdlogo_introsound:getDuration('seconds') + 1
	
	introduration = famicomcdlogo_duration + 2
	blackafterintro = 0.3
	introfadetime = 0.5
	introprogress = 0
	
	screenwidth = width*16*scale
	screenheight = 224*scale
	allowskip = false
end

function intro_update(dt)
	allowskip = false
	if introprogress < introduration+blackafterintro then
		introprogress = introprogress + dt
		if introprogress > introduration+blackafterintro then
			introprogress = introduration+blackafterintro
		end
		
		if introprogress > 0.5 and playedwilhelm == nil then
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
		local a = 255
		if introprogress < introfadetime then
			a = introprogress/introfadetime * 255
		elseif introprogress >= introduration-introfadetime then
			a = (1-(introprogress-(introduration-introfadetime))/introfadetime) * 255
		end
		
		love.graphics.setColor(255, 255, 255, a)

		love.graphics.rectangle("fill", 0,0, love.graphics.getWidth(), love.graphics.getHeight())

		logoWidth, logoHeight = logo:getDimensions()

		love.graphics.draw(
			logo, screenwidth/2, screenheight/2, 0, logoscale, logoscale, logoWidth/2, logoHeight/2
		)
		
		local a2 = math.max(0, (1-(introprogress-.5)/0.3)*255)
		love.graphics.setColor(150, 150, 150, a2)
		properprint("loading mari0..", love.graphics.getWidth()/2-string.len("loading mari0..")*4*scale, 20*scale)
		love.graphics.setColor(50, 50, 50, a2)
		properprint(loadingtext, love.graphics.getWidth()/2-string.len(loadingtext)*4*scale, love.graphics.getHeight()/2+165*logoscale)

		love.graphics.setColor(255,255,255, a2)
		love.graphics.rectangle("fill", 0, (height*16-3)*scale, (width*16)*scale, 3*scale)
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