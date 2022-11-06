local allowCountdown = false


local u = false;
local r = 0;
local shot = false;
local agent = 1
local health = 0;
local xx = 500;
local yy = 450;
local xx2 = 750;
local yy2 = 450;
local ofs = 15;
local followchars = true;
local del = 0;
local del2 = 0;

local angleshit = 1;
local anglevar = 1;

function onCreate()
    setProperty('timeBar.color', getColorFromHex('000000'))
    setProperty('timeBar.color', getColorFromHex('ff1493'))

    makeLuaSprite('red', 'red', 0, 0)
    makeGraphic('red', 1280, 720, 'ff0000')
    setObjectCamera('red', 'hud')
    setProperty('red.alpha', 0)
    addLuaSprite('red', false)
end

function onStartCountdown()
    for i = 0, getProperty('opponentStrums.length')-1 do

        setPropertyFromGroup('opponentStrums', i, 'texture', 'notes/pink');
        
        end
        
        for i = 0, getProperty('unspawnNotes.length')-1 do
        
        if getPropertyFromGroup('unspawnNotes', i, 'mustPress') == false then
        
        setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes/pink');
        
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

    if curBeat == 48 or curBeat == 144 then
        triggerEvent('Add Camera Zoom', 0.20, 0.15)
    end

    if curBeat == 52 or curBeat == 60 or curBeat == 68 or curBeat == 76 or curBeat == 148 or curBeat == 156 or curBeat == 164 or curBeat == 172 or curBeat == 223 then
        setProperty('defaultCamZoom', 1.5)
    end

    if curBeat == 56 or curBeat == 64 or curBeat == 72 or curBeat == 80 or curBeat == 148 or curBeat == 152 or curBeat == 160 or curBeat == 168 or curBeat == 176 or curBeat == 224 then
        setProperty('defaultCamZoom', 1)
    end

    if curBeat == 48 or curBeat == 52 or curBeat == 56 or curBeat == 60 or curBeat == 64 or curBeat == 68 or curBeat == 72 or curBeat == 76 then
        sabotage()
    end

    if curBeat == 144 or curBeat == 148 or curBeat == 152 or curBeat == 156 or curBeat == 160 or curBeat == 164 or curBeat == 168 or curBeat == 172 then
        sabotage()
    end

end

function sabotage()
    setProperty('red.alpha', 0.6)
    doTweenAlpha('redtween', 'red', 0, 0.6, 'linear')
end