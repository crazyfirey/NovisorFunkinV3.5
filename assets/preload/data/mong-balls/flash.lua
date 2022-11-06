function onCreate()
    
	--THE TOP BAR
	makeLuaSprite('UpperBar', 'empty', 0, -120)
	makeGraphic('UpperBar', 1280, 120, '000000')
	setObjectCamera('UpperBar', 'hud')
	addLuaSprite('UpperBar', false)


	--THE BOTTOM BAR
	makeLuaSprite('LowerBar', 'empty', 0, 720)
	makeGraphic('LowerBar', 1280, 120, '000000')
	setObjectCamera('LowerBar', 'hud')
	addLuaSprite('LowerBar', false)
    
    makeLuaSprite('whiteflash', '', 0, 0)
    makeGraphic('whiteflash', 1280, 720, 'ffffff')
    setObjectCamera('whiteflash', 'hud')
    addLuaSprite('whiteflash', false)
    setProperty('whiteflash.alpha', 0)

end

function onBeatHit()

    if curBeat == 4 or curBeat == 36 or curBeat == 68 or curBeat == 102 or curBeat == 132 then
        setProperty('whiteflash.alpha', 1)
        doTweenAlpha('flash', 'whiteflash', 0, 2, 'expoOut')
    end

    if curBeat == 164 or curBeat == 196 or curBeat == 228 or curBeat == 260 or curBeat == 292 or curBeat == 324 then
        setProperty('whiteflash.alpha', 1)
        doTweenAlpha('flash', 'whiteflash', 0, 2, 'expoOut')
    end

    if curBeat == 227 then
        Cinematic();
    end

    if curBeat == 319 then
        CinematicOFF();
    end

end

function Cinematic()

    if not downscroll then
        doTweenY('Cinematics1', 'UpperBar', 0, 8, 'expoOut')
        doTweenY('Cinematics2', 'LowerBar', 600, 8, 'expoOut')
        noteTweenY('NOTEMOVE1', 0, 130, 8, 'expoOut')	
        noteTweenY('NOTEMOVE2', 1, 130, 8, 'expoOut')
        noteTweenY('NOTEMOVE3', 2, 130, 8, 'expoOut')
        noteTweenY('NOTEMOVE4', 3, 130, 8, 'expoOut')
        noteTweenY('NOTEMOVE5', 4, 130, 8, 'expoOut')
        noteTweenY('NOTEMOVE6', 5, 130, 8, 'expoOut')
        noteTweenY('NOTEMOVE7', 6, 130, 8, 'expoOut')
        noteTweenY('NOTEMOVE8', 7, 130, 8, 'expoOut')
        doTweenAlpha('AlphaTween3', 'scoreTxt', 0, 0.1)
        doTweenAlpha('AlphaTween6', 'timeBar', 0, 0.1)
        doTweenAlpha('AlphaTween7', 'timeBarBG', 0, 0.1)
        doTweenAlpha('AlphaTween8', 'timeBarName', 0, 0.1)
        doTweenAlpha('AlphaTween9', 'sickTxt', 0, 0.1)
        doTweenAlpha('AlphaTween10', 'goodTxt', 0, 0.1)
        doTweenAlpha('AlphaTween11', 'badTxt', 0, 0.1)
        doTweenAlpha('AlphaTween12', 'shitTxt', 0, 0.1)
    end

    if downscroll then
        doTweenY('Cinematics1', 'UpperBar', 0, 8, 'expoOut')
        doTweenY('Cinematics2', 'LowerBar', 600, 8, 'expoOut')
        noteTweenY('NOTEMOVE1', 0, 480, 8, 'expoOut')	
        noteTweenY('NOTEMOVE2', 1, 480, 8, 'expoOut')
        noteTweenY('NOTEMOVE3', 2, 480, 8, 'expoOut')
        noteTweenY('NOTEMOVE4', 3, 480, 8, 'expoOut')
        noteTweenY('NOTEMOVE5', 4, 480, 8, 'expoOut')
        noteTweenY('NOTEMOVE6', 5, 480, 8, 'expoOut')
        noteTweenY('NOTEMOVE7', 6, 480, 8, 'expoOut')
        noteTweenY('NOTEMOVE8', 7, 480, 8, 'expoOut')
        doTweenAlpha('AlphaTween3', 'scoreTxt', 0, 0.1)
        doTweenAlpha('AlphaTween6', 'timeBar', 0, 0.1)
        doTweenAlpha('AlphaTween7', 'timeBarBG', 0, 0.1)
        doTweenAlpha('AlphaTween8', 'timeBarName', 0, 0.1)
        doTweenAlpha('AlphaTween9', 'sickTxt', 0, 0.1)
        doTweenAlpha('AlphaTween10', 'goodTxt', 0, 0.1)
        doTweenAlpha('AlphaTween11', 'badTxt', 0, 0.1)
        doTweenAlpha('AlphaTween12', 'shitTxt', 0, 0.1)
    end

end

function CinematicOFF()

    if not downscroll then
        doTweenY('Cinematics1', 'UpperBar', -120, 8, 'expoOut')
        doTweenY('Cinematics2', 'LowerBar', 720, 8, 'expoOut')
        noteTweenY('NOTEMOVE1', 0, 50, 8, 'expoOut')	
        noteTweenY('NOTEMOVE2', 1, 50, 8, 'expoOut')
        noteTweenY('NOTEMOVE3', 2, 50, 8, 'expoOut')
        noteTweenY('NOTEMOVE4', 3, 50, 8, 'expoOut')
        noteTweenY('NOTEMOVE5', 4, 50, 8, 'expoOut')
        noteTweenY('NOTEMOVE6', 5, 50, 8, 'expoOut')
        noteTweenY('NOTEMOVE7', 6, 50, 8, 'expoOut')
        noteTweenY('NOTEMOVE8', 7, 50, 8, 'expoOut')
        doTweenAlpha('AlphaTween3', 'scoreTxt', 1, 0.1)
        doTweenAlpha('AlphaTween6', 'timeBar', 1, 0.1)
        doTweenAlpha('AlphaTween7', 'timeBarBG', 1, 0.1)
        doTweenAlpha('AlphaTween8', 'timeBarName', 1, 0.1)
        doTweenAlpha('AlphaTween9', 'sickTxt', 1, 0.1)
        doTweenAlpha('AlphaTween10', 'goodTxt', 1, 0.1)
        doTweenAlpha('AlphaTween11', 'badTxt', 1, 0.1)
        doTweenAlpha('AlphaTween12', 'shitTxt', 1, 0.1)
    end

    if downscroll then
        doTweenY('Cinematics1', 'UpperBar', -120, 8, 'expoOut')
        doTweenY('Cinematics2', 'LowerBar', 720, 8, 'expoOut')
        noteTweenY('NOTEMOVE1', 0, 570, 8, 'expoOut')	
        noteTweenY('NOTEMOVE2', 1, 570, 8, 'expoOut')
        noteTweenY('NOTEMOVE3', 2, 570, 8, 'expoOut')
        noteTweenY('NOTEMOVE4', 3, 570, 8, 'expoOut')
        noteTweenY('NOTEMOVE5', 4, 570, 8, 'expoOut')
        noteTweenY('NOTEMOVE6', 5, 570, 8, 'expoOut')
        noteTweenY('NOTEMOVE7', 6, 570, 8, 'expoOut')
        noteTweenY('NOTEMOVE8', 7, 570, 8, 'expoOut')
        doTweenAlpha('AlphaTween3', 'scoreTxt', 1, 0.1)
        doTweenAlpha('AlphaTween6', 'timeBar', 1, 0.1)
        doTweenAlpha('AlphaTween7', 'timeBarBG', 1, 0.1)
        doTweenAlpha('AlphaTween8', 'timeBarName', 1, 0.1)
        doTweenAlpha('AlphaTween9', 'sickTxt', 1, 0.1)
        doTweenAlpha('AlphaTween10', 'goodTxt', 1, 0.1)
        doTweenAlpha('AlphaTween11', 'badTxt', 1, 0.1)
        doTweenAlpha('AlphaTween12', 'shitTxt', 1, 0.1)
    end
end