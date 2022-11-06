

local u = false;
local r = 0;
local shot = false;
local agent = 1
local health = 0;
local xx = 0;
local yy = 0;
local xx2 = 0;
local yy2 = 0;
local ofs = 15;
local followchars = true;
local del = 0;
local del2 = 0;

local angleshit = 1;
local anglevar = 1;

function onCreatePost()
    setProperty('boyfriend.alpha', 0);
    
    for i = 0, getProperty('opponentStrums.length')-1 do
		setPropertyFromGroup('opponentStrums',i,'visible',false);
		setPropertyFromGroup('opponentStrums',i,'y',130);
		setPropertyFromGroup('opponentStrums',i,'x',-9999);
	end

    
    for i = 0, getProperty('playerStrums.length') do
        setPropertyFromGroup('playerStrums', i, 'x', getPropertyFromGroup('playerStrums', i, 'x') - 305);
    end
end

function onCreate()
	makeAnimatedLuaSprite('fx', 'vintage', 0, 0)
	addAnimationByPrefix('fx', 'idle', 'idle', 16, true)
	scaleObject('fx', 3, 3)
	setObjectCamera('fx', 'camHud')
	objectPlayAnimation('fx', 'idle', true)
	addLuaSprite('fx', false)
	setProperty('fx.alpha', 0)

    setProperty('timeBar.color', getColorFromHex('000000'))
    setProperty('timeBar.color', getColorFromHex('969696'))
end

function onUpdate()
    if del > 0 then
        del = del - 1
    end
    if del2 > 0 then
        del2 = del2 - 1
    end
    if followchars == true then
        if mustHitSection == false then
            setProperty('defaultCamZoom',0.9)
            if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
        else
            
            setProperty('defaultCamZoom',0.9)
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
            if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
            
        end
    else
        triggerEvent('Camera Follow Pos','','')
    end    
end

function onBeatHit()
    if curBeat == 28 then
        doTweenAlpha('static', 'fx', 0.7, 0.5, linear)
    end

    if curBeat == 32 then
        triggerEvent('Add Camera Zoom', 0.180, 0.180)
        setProperty('fx.alpha', 0.15)
    end

    if curBeat == 92 then
        doTweenAlpha('static', 'fx', 0.7, 0.5, linear)
    end

    if curBeat == 96 then
        triggerEvent('Add Camera Zoom', 0.180, 0.180)
        setProperty('fx.alpha', 0.15)
    end

    if curBeat == 124 then
        doTweenAlpha('static', 'fx', 0.7, 0.5, linear)
    end

    if curBeat == 128 then
        triggerEvent('Add Camera Zoom', 0.180, 0.180)
        setProperty('fx.alpha', 0.15)
    end

    if curBeat == 220 then
        doTweenAlpha('static', 'fx', 0.7, 0.5, linear)
    end

    if curBeat == 224 then
        triggerEvent('Add Camera Zoom', 0.180, 0.180)
        setProperty('fx.alpha', 0.15)
    end

    if curBeat == 316 then
        doTweenAlpha('static', 'fx', 0.7, 0.5, linear)
    end

    if curBeat == 320 then
        triggerEvent('Add Camera Zoom', 0.180, 0.180)
        setProperty('fx.alpha', 0.15)
    end

    if curBeat == 380 then
        doTweenAlpha('static', 'fx', 0.7, 0.5, linear)
    end

    if curBeat == 384 then
        triggerEvent('Add Camera Zoom', 0.180, 0.180)
        setProperty('fx.alpha', 0.15)
    end

    if curBeat == 388 then
        doTweenAlpha('static', 'fx', 0, 0.5, linear)
    end
end