local allowCountdown = false
local u = false;
local r = 0;
local shot = false;
local agent = 1
local health = 0;
local xx = 500;
local yy = 400;
local xx2 = 800;
local yy2 = 550;
local ofs = 15;
local followchars = true;
local del = 0;
local del2 = 0;
local angleshit = 1;
local anglevar = 1;
local defaultNotePos = {};
local shake = 4;

function onCreatePost()
    setProperty('dad.x', -130)
end

function onCreate()
    setProperty('timeBar.color', getColorFromHex('000000'))
    setProperty('timeBar.color', getColorFromHex('969696'))

    makeLuaSprite('gentleman', 'mirahq/dead gentleman', 50, 600)
    setGraphicSize('gentleman', 500, 300)
	addLuaSprite('gentleman', false)

    makeAnimatedLuaSprite('player', 'mirahq/player_mad', 1050, 350)
    addAnimationByPrefix('player', 'idle', 'player maqd', 24, true)
    objectPlayAnimation('player', 'idle', true)
    addLuaSprite('player', false)

    makeAnimatedLuaSprite('novisor', 'noescape/novisors', 150, 100)
    setGraphicSize('novisor', 1100, 500)
    setProperty('novisor.alpha', 0.05)
    addAnimationByPrefix('novisor', 'float', 'ghost instance 1', 24, true)
    objectPlayAnimation('novisor', 'float', true)
    addLuaSprite('novisor', false)

    makeLuaSprite('spotlightone', 'spotlight', 50, -150)
    setProperty('spotlightone.alpha', 0)
    addLuaSprite('spotlightone', true)

    makeLuaSprite('spotlighttwo', 'spotlight', 750, -100)
    setProperty('spotlighttwo.alpha', 0)
    addLuaSprite('spotlighttwo', true)

    makeLuaSprite('black', 'black', -300, 0)
    makeGraphic('black', 4000, 4000, '000000')
    setObjectCamera('black', 'camgame')
    setProperty('black.alpha', 0)
    addLuaSprite('black', false)

    makeLuaSprite('red', 'red', 0, 0)
    makeGraphic('red', 1280, 720, 'ff0000')
    setObjectCamera('red', 'hud')
    setProperty('red.alpha', 0)
    addLuaSprite('red', false)

    makeAnimatedLuaSprite('fx', 'vintage', 0, 0)
	addAnimationByPrefix('fx', 'idle', 'idle', 16, true)
	scaleObject('fx', 3, 3)
	setObjectCamera('fx', 'camHud')
	objectPlayAnimation('fx', 'idle', true)
	addLuaSprite('fx', false)
	setProperty('fx.alpha', 0)

    makeLuaSprite('bartop','',0,-100)
    makeGraphic('bartop',1280,100,'000000')
    addLuaSprite('bartop',false)
    setObjectCamera('bartop','hud')
    setScrollFactor('bartop',0,0)

    makeLuaSprite('barbot','',0, 800)
    makeGraphic('barbot',1280,100,'000000')
    addLuaSprite('barbot',false)
    setScrollFactor('barbot',0,0)
    setObjectCamera('barbot','hud')
end

function onStartCountdown()
    for i = 0, getProperty('opponentStrums.length')-1 do

        setPropertyFromGroup('opponentStrums', i, 'texture', 'notes/novisor');
        
        end
        
        for i = 0, getProperty('unspawnNotes.length')-1 do
        
        if getPropertyFromGroup('unspawnNotes', i, 'mustPress') == false then
        
        setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes/novisor');
        
        end
        
        end
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

function onBeatHit()

    if curStep > 240 and curStep < 255 then 
		triggerEvent('Add Camera Zoom', 0.15, 0.05)
	end

    if curStep > 376 and curStep < 383 then 
		triggerEvent('Add Camera Zoom', 0.3, 0.2)
	end
    
    if curStep > 384 and curStep < 640 then
		triggerEvent('Add Camera Zoom', 0.2, 0.1)
	end

    if curBeat == 224 or curBeat == 256 then
        opponentLight()
    end

    if curBeat == 240 or curBeat == 272 then
        BFLight()
    end

    if curBeat == 287 then
        setProperty('defaultCamZoom', 1.8)
    end
        
    if curStep > 1152 and curStep < 1409 then 
		triggerEvent('Add Camera Zoom', 0.2, 0.1)
        OffLight()
        setProperty('defaultCamZoom', 1)
	end

end

function onStepHit()
   
    if curStep == 240 then
        doTweenY('top', 'bartop', -30, 2, 'expoOut')
        doTweenY('bottom', 'barbot', 650, 2, 'expoOut')
    end
   
    if curStep == 384 or curStep == 1152 or curStep == 1664 then
        redSide()
    end

    if curStep == 640 or curStep == 1408 then
        redSideOFF()
    end
end

function redSide()
    setProperty('red.alpha', 1)
    doTweenAlpha('redtween', 'red', 0.4, 1.3, 'linear')
    setProperty('fx.alpha', 0.3)
    setProperty('novisor.alpha', 1)
    playSound('attack', 1, false)
    noteTweenAngle("NoteAngle", 0, -360, 0.5, 'expoOut')
    noteTweenAngle("NoteAngle1", 1, 360, 0.5, 'expoOut')
    noteTweenAngle("NoteAngle2", 2, -360, 0.5, 'expoOut')
    noteTweenAngle("NoteAngle3", 3, 360, 0.5, 'expoOut')
    noteTweenAngle("NoteAngle4", 4, -360, 0.5, 'expoOut')
    noteTweenAngle("NoteAngle5", 5, 360, 0.5, 'expoOut')
    noteTweenAngle("NoteAngle6", 6, -360, 0.5, 'expoOut')
    noteTweenAngle("NoteAngle7", 7, 360, 0.5, 'expoOut')
end

function redSideOFF()
    setProperty('red.alpha', 1)
    doTweenAlpha('redtween', 'red', 0, 1.3, 'linear')
    setProperty('fx.alpha', 0)
    setProperty('novisor.alpha', 0.05)
    playSound('attack', 1.5, false)
    noteTweenAngle("NoteAngle0", 0, 360, 0.5, 'expoOut')
    noteTweenAngle("NoteAngle1", 1, -360, 0.5, 'expoOut')
    noteTweenAngle("NoteAngle2", 2, 360, 0.5, 'expoOut')
    noteTweenAngle("NoteAngle3", 3, -360, 0.5, 'expoOut')
    noteTweenAngle("NoteAngle4", 4, 360, 0.5, 'expoOut')
    noteTweenAngle("NoteAngle5", 5, -360, 0.5, 'expoOut')
    noteTweenAngle("NoteAngle6", 6, 360, 0.5, 'expoOut')
    noteTweenAngle("NoteAngle7", 7, -360, 0.5, 'expoOut')
end

function opponentLight()
    setProperty('spotlightone.alpha', 0.4)
    setProperty('spotlighttwo.alpha', 0)
    setProperty('black.alpha', 0.8)
    setProperty('defaultCamZoom', 1.2)
    playSound('SpotlightSound', 1, false)
end

function BFLight()
    setProperty('spotlightone.alpha', 0)
    setProperty('spotlighttwo.alpha', 0.4)
    setProperty('black.alpha', 0.8)
    playSound('SpotlightSound', 1, false)
end

function OffLight()
    setProperty('spotlightone.alpha', 0)
    setProperty('spotlighttwo.alpha', 0)
    doTweenAlpha('black', 'black', 0, 1, 'linear')
    setProperty('defaultCamZoom', 0.95)
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	triggerEvent('Screen Shake', '1, 0.003', 'null')
end