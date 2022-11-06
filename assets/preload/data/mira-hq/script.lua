local allowCountdown = false

local u = false;
local r = 0;
local shot = false;
local agent = 1
local health = 0;
local xx = 400;
local yy = 800;
local xx2 = 1000;
local yy2 = 800;
local ofs = 15;
local followchars = true;
local del = 0;
local del2 = 0;

local angleshit = 1;
local anglevar = 1;

function onCreate()
    setProperty('timeBar.color', getColorFromHex('000000'))
    setProperty('timeBar.color', getColorFromHex('ff0000'))

    makeLuaSprite('red', 'red', 0, 0);
    setObjectCamera('red', 'hud');

    makeLuaSprite('green', 'green', 0, 0);
    setObjectCamera('green', 'hud');

    makeLuaSprite('white', '', 0, 0)
    makeGraphic('white', 1280, 720, 'ffffff')
    setObjectCamera('white', 'hud')
    setProperty('white.alpha', 0)
    addLuaSprite('white', false)
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

    if curBeat == 32 or curBeat == 33 or curBeat == 34 or curBeat == 35 or curBeat == 36 or curBeat == 37 or curBeat == 38 or curBeat == 39 or curBeat == 40 or curBeat == 41 or curBeat == 42 or curBeat == 43 or curBeat == 44 or curBeat == 45 or curBeat == 46 or curBeat == 47 or curBeat == 48 or curBeat == 49 or curBeat == 50 or curBeat == 51 or curBeat == 52 or curBeat == 53 or curBeat == 54 or curBeat == 55 or curBeat == 56 or curBeat == 57 or curBeat == 58 or curBeat == 59 or curBeat == 60 or curBeat == 61 or curBeat == 62 or curBeat == 63 then
        triggerEvent('Add Camera Zoom', '0.070');
    end

    if curBeat == 96 then
        setProperty('white.alpha', 1)
        doTweenAlpha('flash', 'white', 0, 1, 'linear')
        triggerEvent('Add Camera Zoom', '0.070');
        addLuaSprite('red', false);
    end

    if curBeat == 97 or curBeat == 98 or curBeat == 99 or curBeat == 100 or curBeat == 101 or curBeat == 102 or curBeat == 103 or curBeat == 104 or curBeat == 104 or curBeat == 105 or curBeat == 106 or curBeat == 107 or curBeat == 108 or curBeat == 109 or curBeat == 110 or curBeat == 111 or curBeat == 112 or curBeat == 113 or curBeat == 114 or curBeat == 115 or curBeat == 116 or curBeat == 117 or curBeat == 118 or curBeat == 119 or curBeat == 120 or curBeat == 121 or curBeat == 122 or curBeat == 123 or curBeat == 124 or curBeat == 125 or curBeat == 126 or curBeat == 128 then
        triggerEvent('Add Camera Zoom', '0.070');
    end

    if curBeat == 160 then
        setProperty('white.alpha', 1)
        doTweenAlpha('flash', 'white', 0, 1, 'linear')
        triggerEvent('Add Camera Zoom', '0.070');
        addLuaSprite('green', false);
        removeLuaSprite('red', false);
    end

    if curBeat == 161 or curBeat == 162 or curBeat == 163 or curBeat == 164 or curBeat == 165 or curBeat == 166 or curBeat == 167 or curBeat == 168 or curBeat == 169 or curBeat == 170 or curBeat == 171 or curBeat == 172 or curBeat == 173 or curBeat == 174 or curBeat == 175 or curBeat == 176 or curBeat == 177 or curBeat == 178 or curBeat == 179 or curBeat == 180 or curBeat == 181 or curBeat == 182 or curBeat == 183 or curBeat == 184 or curBeat == 185 or curBeat == 186 or curBeat == 187 or curBeat == 188 or curBeat == 189 or curBeat == 190 or curBeat == 191 then
        triggerEvent('Add Camera Zoom', '0.070');
    end

    if curBeat == 224 then
        doTweenAlpha('shutdown', 'green', 0, 0.5, 'linear');
    end

end