function onCreate()
    makeLuaSprite('defeat', 'freeplay/defeatbackground', 0, 0)
	addLuaSprite('defeat', false)
end

function onCreatePost()
	setProperty('boyfriend.x', 1160)
	setProperty('boyfriend.y', 400)

    setProperty('dad.x', 200)
	setProperty('dad.y', 150)
end