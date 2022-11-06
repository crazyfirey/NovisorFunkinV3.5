function onCreatePost()
    if (not downscroll) then
        makeLuaText('timer', '', 500, 35, 19)
        setObjectCamera('timer', 'hud')
        setTextAlignment('timer', 'left')
        setTextSize('timer', 20)
        setProperty('timer.alpha', 0)
        addLuaText('timer')

        makeLuaText('timertotal', '', 500, 70, 19)
        setObjectCamera('timertotal', 'hud')
        setTextAlignment('timertotal', 'right')
        setTextSize('timertotal', 20)
        setProperty('timertotal.alpha', 0)
        addLuaText('timertotal')
    end

    if (downscroll) then
        makeLuaText('timer', '', 500, 35, 683)
        setObjectCamera('timer', 'hud')
        setTextAlignment('timer', 'left')
        setTextSize('timer', 20)
        setProperty('timer.alpha', 0)
        addLuaText('timer')

        makeLuaText('timertotal', '', 500, 70, 683)
        setObjectCamera('timertotal', 'hud')
        setTextAlignment('timertotal', 'right')
        setTextSize('timertotal', 20)
        setProperty('timertotal.alpha', 0)
        addLuaText('timertotal')
    end
end

function onSongStart()
	doTweenAlpha('time', 'timer', 1, 0.5, 'circOut')
    doTweenAlpha('total', 'timertotal', 1, 0.5, 'circOut')
end

function onUpdatePost()
    --timer
    local  timeElapsed = math.floor(getProperty('songTime')/1000)
    local  timeTotal = math.floor(getProperty('songLength')/1000)
    local timeElapsedFixed = string.format("%.2d:%.2d", timeElapsed/60%60, timeElapsed%60)
    local timeTotalFixed = string.format("%.2d:%.2d", timeTotal/60%60, timeTotal%60)
    setTextString('timer', timeElapsedFixed)
    setTextString('timertotal', timeTotalFixed)
end

function onUpdate()

    if songName == 'Lights' then
        if curBeat == 96 then
            doTweenAlpha('time', 'timer', 0, 0.2)
            doTweenAlpha('total', 'timertotal', 0, 0.2)
        end

        if curBeat == 224 then
            doTweenAlpha('time', 'timer', 1, 0.2)
            doTweenAlpha('total', 'timertotal', 1, 0.2)
        end
    end

    if songName == 'Mong Balls' then
        if curBeat == 227 then
            doTweenAlpha('time', 'timer', 0, 0.2)
            doTweenAlpha('total', 'timertotal', 0, 0.2)
        end

        if curBeat == 319 then
            doTweenAlpha('time', 'timer', 1, 0.2)
            doTweenAlpha('total', 'timertotal', 1, 0.2)
        end
    end

end