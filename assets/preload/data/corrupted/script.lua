local allowCountdown = false

local u = false;
local r = 0;
local shot = false;
local agent = 1
local health = 0;
local xx = 490;
local yy = 480;
local xx2 = 860;
local yy2 = 500;
local ofs = 15;
local followchars = true;
local del = 0;
local del2 = 0;

local defaultNotePos = {};
local shake = 4;

local angleshit = 1;
local anglevar = 1;
function onCreatePost()
    addVCREffect('camGame')
end

function onCreate()
    
    makeLuaSprite('red', 'red', -500, -100)
    makeGraphic('red', 10000, 5000, 'ff0000')
    setProperty('red.alpha', 0)
    addLuaSprite('red', true)

    makeAnimatedLuaSprite('fx', 'vintage', 0, 0)
	addAnimationByPrefix('fx', 'idle', 'idle', 16, true)
	scaleObject('fx', 3, 3)
	setObjectCamera('fx', 'camHud')
	objectPlayAnimation('fx', 'idle', true)
	addLuaSprite('fx', false)
	setProperty('fx.alpha', 0)
    
    makeLuaSprite('dark', '', 0, 0)
    makeGraphic('dark', 1280, 720, '000000')
    addLuaSprite('dark', false)
    setObjectCamera('dark', 'hud')
    setProperty('dark.alpha', 0.7)

    setProperty('timeBar.color', getColorFromHex('000000'))
    setProperty('timeBar.color', getColorFromHex('8b0000'))

    makeLuaSprite('bartop','',0,-30)
    makeGraphic('bartop',1280,100,'000000')
    addLuaSprite('bartop',false)
    setObjectCamera('bartop','hud')
    setScrollFactor('bartop',0,0)

    makeLuaSprite('barbot','',0,650)
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

function onSongStart()
    for i = 0,7 do 
        x = getPropertyFromGroup('strumLineNotes', i, 'x')
 
        y = getPropertyFromGroup('strumLineNotes', i, 'y')
 
        table.insert(defaultNotePos, {x,y})
    end
end

function onUpdate()
    songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 300) * (bpm / 200)
    
    if curStep >= 320 and curStep < 3000 then
        for i = 0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + getRandomInt(-shake, shake) + math.sin((currentBeat + i*0.25) * math.pi))
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + getRandomInt(-shake, shake) + math.sin((currentBeat + i*0.25) * math.pi))
        end
    end

    if curStep == 3000 then
        for i = 0,7 do 
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1])
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2])
        end
    end
    
    
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

function redSide()
    setProperty('red.alpha', 1)
    doTweenAlpha('redtween', 'red', 0.6, 1.3, 'linear')
    setProperty('fx.alpha', 0.3)
    setProperty('novisor.alpha', 1)
    playSound('attack', 0.5, false)
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
    setProperty('novisor.alpha', 1)
    playSound('attack', 0.5, false)
    noteTweenAngle("NoteAngle", 0, 360, 0.5, 'expoOut')
    noteTweenAngle("NoteAngle1", 1, -360, 0.5, 'expoOut')
    noteTweenAngle("NoteAngle2", 2, 360, 0.5, 'expoOut')
    noteTweenAngle("NoteAngle3", 3, -360, 0.5, 'expoOut')
    noteTweenAngle("NoteAngle4", 4, 360, 0.5, 'expoOut')
    noteTweenAngle("NoteAngle5", 5, -360, 0.5, 'expoOut')
    noteTweenAngle("NoteAngle6", 6, 360, 0.5, 'expoOut')
    noteTweenAngle("NoteAngle7", 7, -360, 0.5, 'expoOut')
end

function onBeatHit()
    
    if curBeat == 76 then
        setProperty('defaultCamZoom', 1.05);
    end

    if curBeat == 78 then
        setProperty('defaultCamZoom', 1.2);
    end

    if curBeat == 79 then
        setProperty('defaultCamZoom', 1.5);
    end

    if curBeat == 80 then
        setProperty('defaultCamZoom', 0.9);
        redSide()
    end

    if curBeat == 304 or curBeat == 672 then
        redSideOFF()
    end

    if curBeat == 384 then
        redSide()
    end

end