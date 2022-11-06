function onEvent(name, value1, value2)
	if name == "sabotage" then
		makeLuaSprite('red', 'red', 0, 0)
		makeGraphic('red', 1280, 720, 'ff0000')
		setObjectCamera('red', 'hud')
		setProperty('red.alpha', 0)
		addLuaSprite('red', false)
	end
end

function onTimerCompleted(tag, loops, loopsleft)
	if tag == 'wait' then
		doTweenAlpha('redtween', 'red', 0, 0.6, 'linear')
	end
end

function onTweenCompleted(tag)
	if tag == 'byebye' then
		removeLuaSprite('redtween', true);
	end
end