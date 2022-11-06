local allowCountdown = false

local u = false;
local r = 0;
local shot = false;
local agent = 1
local health = 0;
local xx = 520;
local yy = 550;
local xx2 = 800;
local yy2 = 550;
local ofs = 15;
local followchars = true;
local del = 0;
local del2 = 0;

local angleshit = 1;
local anglevar = 1;

function onCreate()
    setProperty('timeBar.color', getColorFromHex('000000'))
    setProperty('timeBar.color', getColorFromHex('ffff00'))

    makeLuaSprite('spotlightone', 'spotlight', 90, -150)
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
    
    makeLuaSprite('white', '', 0, 0)
    makeGraphic('white', 1280, 720, 'ffffff')
    setObjectCamera('white', 'hud')
    setProperty('white.alpha', 0)
    addLuaSprite('white', false)

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

        setPropertyFromGroup('opponentStrums', i, 'texture', 'notes/veteran');
        
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
    
	if curBeat == 96 then
        doTweenAlpha('rating', 'scoreTxt', 0, 0.2)
        doTweenAlpha('botplay', 'botplayTxt', 0, 0.2)
        doTweenAlpha('time1', 'timeBar', 0, 0.2)
        doTweenAlpha('time2', 'timeBarBG', 0, 0.2)
        doTweenAlpha('time3', 'timeBarName', 0, 0.2)
        doTweenAlpha('sick', 'sickTxt', 0, 0.2)
        doTweenAlpha('good', 'goodTxt', 0, 0.2)
        doTweenAlpha('bad', 'badTxt', 0, 0.2)
        doTweenAlpha('shit', 'shitTxt', 0, 0.2)
    end

    if curBeat == 224 then
        doTweenAlpha('rating', 'scoreTxt', 1, 0.2)
        doTweenAlpha('botplay', 'botplayTxt', 1, 0.2)
        doTweenAlpha('time1', 'timeBar', 1, 0.2)
        doTweenAlpha('time2', 'timeBarBG', 1, 0.2)
        doTweenAlpha('time3', 'timeBarName', 1, 0.2)
        doTweenAlpha('sick', 'sickTxt', 1, 0.2)
        doTweenAlpha('good', 'goodTxt', 1, 0.2)
        doTweenAlpha('bad', 'badTxt', 1, 0.2)
        doTweenAlpha('shit', 'shitTxt', 1, 0.2)
    end
end

function onBeatHit()
    if curBeat == 36 then
        triggerEvent('Add Camera Zoom', 0.4, 'null')
    end
    
    if curStep > 144 and curStep < 255 then
		triggerEvent('Add Camera Zoom', 0.2, 'null')
	end

    if curStep > 272 and curStep < 399 then
		triggerEvent('Add Camera Zoom', 0.2, 'null')
	end

    if curBeat == 66 then
        ZoomIn()
    end

    if curBeat == 68 then
        ZoomDefault()
        Whiteflash()
    end
    
    if curBeat == 96 then
        doTweenY('top', 'bartop', -30, 2, 'expoOut')
        doTweenY('bottom', 'barbot', 650, 2, 'expoOut')
        CinemaNotes()
    end

    if curStep > 400 and curStep < 623 then
		triggerEvent('Add Camera Zoom', 0.3, 'null')
	end

    if curBeat == 156 or curBeat == 228 then
		triggerEvent('Add Camera Zoom', 0.6, 'null')
    end

    if curBeat == 162 then
        ZoomIn()
    end

    if curBeat == 164 then
        ZoomDefaultTWO()
        Whiteflash()
    end

    if curStep > 652 and curStep < 911 then
		triggerEvent('Add Camera Zoom', 0.3, 'null')
	end

    if curStep > 912 and curStep < 1039 then
		triggerEvent('Add Camera Zoom', 0.2, 'null')
	end

    if curBeat == 260 or curBeat == 264 or curBeat == 268 or curBeat == 272 then
		triggerEvent('Add Camera Zoom', 0.3, 'null')
	end

    if curBeat == 274 then
        ZoomIn()
    end

    if curBeat == 276 then
		triggerEvent('Add Camera Zoom', 0.3, 'null')
        Whiteflash()
        ZoomDefault()
	end

    if curBeat == 280 or curBeat == 284 or curBeat == 288 then
        triggerEvent('Add Camera Zoom', 0.3, 'null')
    end

    if curBeat == 292 then
        triggerEvent('Add Camera Zoom', 0.6, 'null')
        Whiteflash()
    end
    
    if curBeat == 100 then
        Light()
    end

    if curBeat == 224 then
        doTweenY('top', 'bartop', -100, 2, 'expoIn')
        doTweenY('bottom', 'barbot', 800, 2, 'expoIn')
        CinemaNotesOUT()
    end

    if curBeat == 228 then
        OffLight()
    end
end

function Light()
    setProperty('spotlightone.alpha', 0.4)
    setProperty('spotlighttwo.alpha', 0.4)
    setProperty('black.alpha', 0.8)
    setProperty('defaultCamZoom', 1.2)
    playSound('SpotlightSound', 1, false)
    setProperty('white.alpha', 1)
    doTweenAlpha('flash', 'white', 0, 1, 'linear')
end

function OffLight()
    setProperty('spotlightone.alpha', 0)
    setProperty('spotlighttwo.alpha', 0)
    setProperty('black.alpha', 0)
    setProperty('defaultCamZoom', 0.95)
    playSound('SpotlightSound', 1, false)
    setProperty('white.alpha', 1)
    doTweenAlpha('flash', 'white', 0, 1, 'linear')
end

function Whiteflash()
    setProperty('white.alpha', 1)
    doTweenAlpha('flash', 'white', 0, 0.8, 'linear')
end

function ZoomIn()
    setProperty('defaultCamZoom', 1.4)
end

function ZoomDefaultTWO()
    setProperty('defaultCamZoom', 1.2)
end

function ZoomDefault()
    setProperty('defaultCamZoom', 0.95)
end

function CinemaNotes()
    if not downscroll then
        noteTweenY('NOTEMOVE1', 0, 90, 2, 'expoOut')	
        noteTweenY('NOTEMOVE2', 1, 90, 2, 'expoOut')
        noteTweenY('NOTEMOVE3', 2, 90, 2, 'expoOut')
        noteTweenY('NOTEMOVE4', 3, 90, 2, 'expoOut')
        noteTweenY('NOTEMOVE5', 4, 90, 2, 'expoOut')
        noteTweenY('NOTEMOVE6', 5, 90, 2, 'expoOut')
        noteTweenY('NOTEMOVE7', 6, 90, 2, 'expoOut')
        noteTweenY('NOTEMOVE8', 7, 90, 2, 'expoOut')
    end

    if downscroll then
        noteTweenY('NOTEMOVE1', 0, 530, 2, 'expoOut')	
        noteTweenY('NOTEMOVE2', 1, 530, 2, 'expoOut')
        noteTweenY('NOTEMOVE3', 2, 530, 2, 'expoOut')
        noteTweenY('NOTEMOVE4', 3, 530, 2, 'expoOut')
        noteTweenY('NOTEMOVE5', 4, 530, 2, 'expoOut')
        noteTweenY('NOTEMOVE6', 5, 530, 2, 'expoOut')
        noteTweenY('NOTEMOVE7', 6, 530, 2, 'expoOut')
        noteTweenY('NOTEMOVE8', 7, 530, 2, 'expoOut')
    end
end

function CinemaNotesOUT()
    if not downscroll then
        noteTweenY('NOTEMOVE1', 0, 50, 2, 'expoOut')	
        noteTweenY('NOTEMOVE2', 1, 50, 2, 'expoOut')
        noteTweenY('NOTEMOVE3', 2, 50, 2, 'expoOut')
        noteTweenY('NOTEMOVE4', 3, 50, 2, 'expoOut')
        noteTweenY('NOTEMOVE5', 4, 50, 2, 'expoOut')
        noteTweenY('NOTEMOVE6', 5, 50, 2, 'expoOut')
        noteTweenY('NOTEMOVE7', 6, 50, 2, 'expoOut')
        noteTweenY('NOTEMOVE8', 7, 50, 2, 'expoOut')
    end

    if downscroll then
        noteTweenY('NOTEMOVE1', 0, 570, 2, 'expoOut')	
        noteTweenY('NOTEMOVE2', 1, 570, 2, 'expoOut')
        noteTweenY('NOTEMOVE3', 2, 570, 2, 'expoOut')
        noteTweenY('NOTEMOVE4', 3, 570, 2, 'expoOut')
        noteTweenY('NOTEMOVE5', 4, 570, 2, 'expoOut')
        noteTweenY('NOTEMOVE6', 5, 570, 2, 'expoOut')
        noteTweenY('NOTEMOVE7', 6, 570, 2, 'expoOut')
        noteTweenY('NOTEMOVE8', 7, 570, 2, 'expoOut')
    end
end