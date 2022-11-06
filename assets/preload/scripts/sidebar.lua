local composer

local charter

local color

function onCreate()
	
	if songName == 'Skeld' then composer = 'NEWEGGROLLZ' end
	if songName == 'Lights' then composer = 'NEWEGGROLLZ' end
	if songName == 'Visor' then composer = 'EGGLO' end
	if songName == 'Custom' then composer = 'NEWEGGROLLZ' end
	if songName == 'Corrupted' then composer = 'NEWEGGROLLZ' end
	if songName == 'Trapped' then composer = 'EGGLO' end
	if songName == 'Mira HQ' then composer = 'EGGLO' end
	if songName == 'Ria Roll' then composer = 'TERRARUNEOFFICIAL' end
	if songName == 'Escape' then composer = 'NI' end
	if songName == 'Report' then composer = 'NEWEGGROLLZ' end
	if songName == 'Dark Electrical' then composer = 'NEWEGGROLLZ' end
	if songName == 'No Escape' then composer = 'NI' end
	if songName == 'Mong Balls' then composer = 'NEWEGGROLLZ' end

	if songName == 'Telesussy' then composer = 'EGGLO' end
	if songName == 'Lord' then composer = 'EGGLO' end
	if songName == 'Express' then composer = 'EGGLO' end

	if songName == 'Fried Eggs' then composer = 'EGGLO' end

	if songName == 'Distraught' then composer = 'CASE' end
	if songName == 'Monovisor' then composer = 'ADAM MCHUMMUS' end
	if songName == 'Phantasm' then composer = 'BIDDLE3' end
	if songName == 'Ugh' then composer = 'KAWAI SPRITE' end
	if songName == 'Cone' then composer = 'RAREBLIN' end
	if songName == 'Madness' then composer = 'ROZEBUDS' end

	if songName == 'Skeld' then charter = 'VEXXOEXXO' end
	if songName == 'Lights' then charter = 'VEXXOEXXO' end
	if songName == 'Visor' then charter = 'EGGLO' end
	if songName == 'Custom' then charter = 'EGPOTATO' end
	if songName == 'Corrupted' then charter = 'EGPOTATO' end
	if songName == 'Trapped' then charter = 'EGPOTATO' end
	if songName == 'Mira HQ' then charter = 'EGPOTATO' end
	if songName == 'Ria Roll' then charter = 'VEXXOEXXO' end
	if songName == 'Escape' then charter = 'TYPLAYZ36' end
	if songName == 'Report' then charter = 'EGGLO' end
	if songName == 'Dark Electrical' then charter = 'EGGLO' end
	if songName == 'No Escape' then charter = 'EGPOTATO' end
	if songName == 'Mong Balls' then charter = 'NEWEGGROLLZ' end

	if songName == 'Telesussy' then charter = 'EGGLO' end
	if songName == 'Lord' then charter = 'JOSE VITOR' end
	if songName == 'Express' then charter = 'EGGLO' end

	if songName == 'Fried Eggs' then charter = 'EGGLO' end

	if songName == 'Phantasm' then charter = 'EGGLO' end
	if songName == 'Distraught' then charter = 'NEWEGGROLLZ' end
	if songName == 'Monovisor' then charter = 'SUSSY' end
	if songName == 'Ugh' then charter = 'EGGLO' end
	if songName == 'Cone' then charter = 'EGGLO' end
	if songName == 'Madness' then charter = 'EGGLO' end

	if songName == 'Skeld' then color = 'ff0000' end
	if songName == 'Lights' then color = 'ffff33' end
	if songName == 'Visor' then color = '606060' end
	if songName == 'Custom' then color = '894600' end
	if songName == 'Corrupted' then color = '660000' end
	if songName == 'Trapped' then color = '660000' end
	if songName == 'Mira HQ' then color = 'ff0000' end
	if songName == 'Ria Roll' then color = '32ff00' end
	if songName == 'Escape' then color = '606060' end
	if songName == 'Report' then color = 'ff30e3' end
	if songName == 'Dark Electrical' then color = '21071e' end
	if songName == 'No Escape' then color = '606060' end

	if songName == 'Telesussy' then color = 'ffffff' end
	if songName == 'Lord' then color = 'ffffff' end
	if songName == 'Express' then color = 'ffffff' end

	if songName == 'Fried Eggs' then color = 'ffff33' end

	if songName == 'Distraught' then color = '606060' end
	if songName == 'Monovisor' then color = '606060' end
	if songName == 'Phantasm' then color = 'ff0000' end
	if songName == 'Ugh' then color = 'ff0000' end

	if songName == 'Cone' then color = '606060' end
	if songName == 'Madness' then color = '606060' end

	if songName == 'Mong Balls' then color = 'cbb98f' end
	
	makeLuaSprite('box', '', -700, 200)
	makeGraphic('box', 500, 150, color)
	setObjectCamera('box', 'other')
	setProperty('box.alpha', 0.7)
	addLuaSprite('box', true)

	if songName == 'Dark Electrical' then
		makeGraphic('box', 700, 150, color)
	end

	if songName == 'Ria Roll' then
		makeGraphic('box', 600, 150, color)
	end

    makeLuaText('songname', songName, 1000, getProperty('box.x') + 70, getProperty('box.y'))
	setTextAlignment('songname', 'left')
	setObjectCamera('songname', 'other')
	setTextSize('songname', 70)
	addLuaText('songname', true)

	makeLuaText('composer', 'COMPOSER: '..composer, 500, getProperty('box.x') + 70, getProperty('box.y') + 75)
	setTextAlignment('composer', 'left')
	setObjectCamera('composer', 'other')
	setTextSize('composer', 30)
	addLuaText('composer', true)

	makeLuaText('charter', 'CHARTER: '..charter, 500, getProperty('box.x') + 70, getProperty('box.y') + 110)
	setTextAlignment('charter', 'left')
	setObjectCamera('charter', 'other')
	setTextSize('charter', 30)
	addLuaText('charter', true)

	if songName == 'Distraught' or songName == 'Monovisor' or songName == 'Phantasm' or songName == 'Ugh' or songName == 'Cone' or songName == 'Madness' then
		setTextString('charter', 'COVER: '..charter)
	end
end

function onUpdate()
    setProperty('songname.x', getProperty('box.x') + 70)
    setProperty('composer.x', getProperty('box.x') + 70)
    setProperty('charter.x', getProperty('box.x') + 70)
end

function onSongStart()
	doTweenX('sidebarin', 'box', -50, 2, 'expoOut')
end

function onTweenCompleted(tag)
    if tag == 'sidebarin' then
        runTimer('tweentimer', 1.5)
    end
    if tag == 'sidebarout' then
        removeLuaText('composer')
        removeLuaText('charter')
        removeLuaText('songname')
        removeLuaSprite('box')
    end
end

function onTimerCompleted(tag)
    if tag == 'tweentimer' then
        doTweenX('songtweenout','box', -700, 1.5,'expoIn')
    end
end