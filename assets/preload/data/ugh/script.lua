local allowCountdown = false


local u = false;
local r = 0;
local shot = false;
local agent = 1
local health = 0;
local xx = 500;
local yy = 550;
local xx2 = 750;
local yy2 = 550;
local ofs = 15;
local followchars = true;
local del = 0;
local del2 = 0;

local angleshit = 1;
local anglevar = 1;

function onCreate()
    setProperty('timeBar.color', getColorFromHex('000000'))
    setProperty('timeBar.color', getColorFromHex('ff0000'))
end

function onStartCountdown() 
    for i = 0, getProperty('opponentStrums.length')-1 do

        setPropertyFromGroup('opponentStrums', i, 'texture', 'notes/player');
        
        end
        
        for i = 0, getProperty('unspawnNotes.length')-1 do
        
        if getPropertyFromGroup('unspawnNotes', i, 'mustPress') == false then
        
        setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes/player');
        
        end
        
        end

    setProperty('gf.alpha', 0)

    for i = 0, getProperty('playerStrums.length')-1 do

        setPropertyFromGroup('playerStrums', i, 'texture', 'notes/veteran');
        
        end
        
        for i = 0, getProperty('unspawnNotes.length')-1 do
        
        if getPropertyFromGroup('unspawnNotes', i, 'mustPress') == false then
        
        setPropertyFromGroup('unspawnNotes', i, 'texture', 'notes/veteran');
        
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
            setProperty('defaultCamZoom',1)
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

            setProperty('defaultCamZoom',1)
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