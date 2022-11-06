
local followchars = true
local modchart = true
local xx = 960
local yy = 660
local xx2 = 960
local yy2 = 660
local ofs = 15
local del = 0
local del2 = 0
local bgs = {'corrupted', 'player'}

function onCreate()
	makeAnimatedLuaSprite('fx', 'corrupted/vintage', 0, 0)
	addAnimationByPrefix('fx', 'idle', 'idle', 16, true)
	scaleObject('fx', 3, 3)
	setObjectCamera('fx', 'camHud')
	objectPlayAnimation('fx', 'idle', true)
	setProperty('fx.alpha', 0)

	makeLuaSprite('player', 'corrupted/player', 0, 0)
	addLuaSprite('player', false)

	makeLuaSprite('corrupted', 'corrupted/corrupted', 0, 0)
	setProperty('corrupted.alpha', 0)
	addLuaSprite('corrupted', false)

	addCharacterToList('corruptedbf', 'boyfriend')
	precacheSound('stat')

	setPropertyFromClass('GameOverSubstate', 'characterName', 'playerbf')
end

function onCreatePost()
	setProperty('boyfriend.x', 760)
	setProperty('boyfriend.y', 430)

	setProperty('gf.x', 760)
	setProperty('gf.y', 430)
end

function onSongStart()
	addLuaSprite('fx', true)
	setProperty('timeBar.color', getColorFromHex('000000'))
    setProperty('timeBar.color', getColorFromHex('00c5ff'))
end

function onUpdate(elapsed)
	if modchart == true then
		for i = 0,3 do
			setPropertyFromGroup('strumLineNotes', i, 'alpha', 0)
		end
	end
	if followchars == true then
		if mustHitSection == false then
		  if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
			triggerEvent('Camera Follow Pos',xx-ofs,yy)
		  end
		  if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
			triggerEvent('Camera Follow Pos',xx+ofs,yy)
		  end
		  if getProperty('dad.animation.curAnim.name') == 'singUP' then
			triggerEvent('Camera Follow Pos',xx,yy-ofs)
		  end
		  if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
			triggerEvent('Camera Follow Pos',xx,yy+ofs)
		  end
		  if getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' then
			triggerEvent('Camera Follow Pos',xx-ofs,yy)
		  end
		  if getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' then
			triggerEvent('Camera Follow Pos',xx+ofs,yy)
		  end
		  if getProperty('dad.animation.curAnim.name') == 'singUP-alt' then
			triggerEvent('Camera Follow Pos',xx,yy-ofs)
		  end
		  if getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
			triggerEvent('Camera Follow Pos',xx,yy+ofs)
		  end
		  if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
			triggerEvent('Camera Follow Pos',xx,yy)
		  end
		  if getProperty('dad.animation.curAnim.name') == 'idle' then
			triggerEvent('Camera Follow Pos',xx,yy)
		  end
		else
		  if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
			triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
		  end
		  if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
			triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
		  end
		  if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
			triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
		  end
		  if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
			triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
		  end
		  if getProperty('boyfriend.animation.curAnim.name') == 'idle-alt' then
			triggerEvent('Camera Follow Pos',xx2,yy2)
		  end
		  if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
			triggerEvent('Camera Follow Pos',xx2,yy2)
		  end
		end
	else
		triggerEvent('Camera Follow Pos','','')
	end
end

function onStartCountdown()
	setProperty('gf.alpha', 0)
	setProperty('dad.alpha', 0)
	setProperty('iconP2.alpha', 0)

	return Function_Continue
end

function onBeatHit()
	
	if curStep > 127 and curStep < 382 then 
		triggerEvent('Add Camera Zoom', 0.18, 0.1)
	end

	if curStep > 1024 and curStep < 1151 then 
		triggerEvent('Add Camera Zoom', 0.18, 0.1)
	end

	if curStep > 1408 and curStep < 1663 then 
		triggerEvent('Add Camera Zoom', 0.18, 0.1)
	end
end

function onStepHit()
	if curStep == 10 then
		modchart = false
	end
	if curStep == 384 or curStep == 768 or curStep == 1151 or curStep == 1172 or curStep == 1276 or curStep == 1282 or curStep == 1304 or curStep == 1536 or curStep == 1922 or curStep == 1937 or curStep == 1943 or curStep == 1956 then
		fleetON()
	end
	if curStep == 640 or curStep == 1024 or curStep == 1154 or curStep == 1176 or curStep == 1279 or curStep == 1300 or curStep == 1408 or curStep == 1792 or curStep == 1926 or curStep == 1940 or curStep == 1946 or curStep == 1960 then
		fleetOFF()
	end
end

function fleetON()
	setProperty('fx.alpha', 0.8)
	setProperty('playerbf.alpha', 0)
	doTweenAlpha('fleetON', 'fx', 0, 1, 'linear')
	playSound('stat', 0.3)
	setProperty('timeBar.color', getColorFromHex('000000'))
    setProperty('timeBar.color', getColorFromHex('ff0097'))
	setProperty('corrupted.alpha', 1)
	setProperty('player.alpha', 0)
	triggerEvent('Add Camera Zoom', 0.6, 0.4)
	triggerEvent('Change Character', 0, 'corruptedbf')
end

function fleetOFF()
	setProperty('fx.alpha', 0.8)
	setProperty('playerbf.alpha', 1)
	doTweenAlpha('fleetON', 'fx', 0, 1, 'linear')
	playSound('stat', 0.3)
	setProperty('timeBar.color', getColorFromHex('000000'))
    setProperty('timeBar.color', getColorFromHex('00c5ff'))
	setProperty('corrupted.alpha', 0)
	setProperty('player.alpha', 1)
	triggerEvent('Add Camera Zoom', 0.6, 0.4)
	triggerEvent('Change Character', 0, 'playerbf')
end

function onGameOver()
	modchart = false
	return Function_Continue;
end