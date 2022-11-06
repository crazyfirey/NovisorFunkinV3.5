local ok = false
local E = false

function onCreate()
    makeLuaSprite('blackblack', '', 0, 0)
    makeGraphic('blackblack', 1280, 720, '000000')
    setObjectCamera('blackblack', 'other')
    addLuaSprite('blackblack', true)
    
    makeLuaSprite('cardboard', 'endscreen/cardboard', 70, 64.2)
    setObjectCamera('cardboard', 'other')
    addLuaSprite('cardboard', true)

    makeLuaText('complete', 'Song Completed', 1000, 115, 100)
	setTextAlignment('complete', 'left')
	setObjectCamera('complete', 'other')
    setTextFont('complete', 'arial.ttf')
	setTextSize('complete', 70)
	addLuaText('complete', true)
    
    makeLuaText('name', 'Song: '..songName, 1000, getProperty('complete.x'), 180)
	setTextAlignment('name', 'left')
	setObjectCamera('name', 'other')
    setTextFont('name', 'arial.ttf')
	setTextSize('name', 40)
	addLuaText('name', true)

    makeLuaText('enter', 'Press Space to Skip', 1000, getProperty('complete.x'), 550)
	setTextAlignment('enter', 'left')
	setObjectCamera('enter', 'other')
    setTextFont('enter', 'arial.ttf')
	setTextSize('enter', 50)
	addLuaText('enter', true)

    makeLuaText('score', 'Score: 0', 1000, getProperty('complete.x'), 250)
	setTextAlignment('score', 'left')
	setObjectCamera('score', 'other')
    setTextFont('score', 'arial.ttf')
	setTextSize('score', 30)
	addLuaText('score', true)

    makeLuaText('misses', 'Combo Breaks: 0', 1000, getProperty('complete.x'), getProperty('score.y') + 30)
	setTextAlignment('misses', 'left')
	setObjectCamera('misses', 'other')
    setTextFont('misses', 'arial.ttf')
	setTextSize('misses', 30)
	addLuaText('misses', true)

    makeLuaText('acc', 'Accuracy: 0%', 1000, getProperty('complete.x'), getProperty('misses.y') + 30)
	setTextAlignment('acc', 'left')
	setObjectCamera('acc', 'other')
    setTextFont('acc', 'arial.ttf')
	setTextSize('acc', 30)
	addLuaText('acc', true)

    makeLuaText('rating', 'N/A', 1000, getProperty('complete.x'), getProperty('acc.y') + 30)
	setTextAlignment('rating', 'left')
	setObjectCamera('rating', 'other')
    setTextFont('rating', 'arial.ttf')
	setTextSize('rating', 30)
	addLuaText('rating', true)

    makeLuaText('sick', 'Sicks: 0', 1000, getProperty('complete.x'), 400)
	setTextAlignment('sick', 'left')
	setObjectCamera('sick', 'other')
    setTextFont('sick', 'arial.ttf')
	setTextSize('sick', 30)
	addLuaText('sick', true)

    makeLuaText('good', 'Goods: 0', 1000, getProperty('complete.x'), getProperty('sick.y') + 30)
	setTextAlignment('good', 'left')
	setObjectCamera('good', 'other')
    setTextFont('good', 'arial.ttf')
	setTextSize('good', 30)
	addLuaText('good', true)

    makeLuaText('bad', 'Bads: 0', 1000, getProperty('complete.x'), getProperty('good.y') + 30)
	setTextAlignment('bad', 'left')
	setObjectCamera('bad', 'other')
    setTextFont('bad', 'arial.ttf')
	setTextSize('bad', 30)
	addLuaText('bad', true)

    makeLuaText('shit', 'Shits: 0', 1000, getProperty('complete.x'), getProperty('bad.y') + 30)
	setTextAlignment('shit', 'left')
	setObjectCamera('shit', 'other')
    setTextFont('shit', 'arial.ttf')
	setTextSize('shit', 30)
	addLuaText('shit', true)

    setProperty('blackblack.alpha', 0)
    setProperty('cardboard.alpha', 0)
    setProperty('complete.alpha', 0)
    setProperty('name.alpha', 0)
    setProperty('enter.alpha', 0)
    setProperty('score.alpha', 0)
    setProperty('misses.alpha', 0)
    setProperty('acc.alpha', 0)
    setProperty('rating.alpha', 0)
    setProperty('sick.alpha', 0)
    setProperty('good.alpha', 0)
    setProperty('bad.alpha', 0)
    setProperty('shit.alpha', 0)
end

function onUpdatePost(elasped)
    if E == true then
    endSong()
    end

    songacc = math.floor(rating*10000)/100;
end

function onUpdate(elasped)
    if ok == true and keyJustPressed('space') then
         E = true
       end

    local songscore = getProperty('songScore')
    local songmiss = getProperty('songMisses')
    local songsick = getProperty('sicks')
    local songgood = getProperty('goods')
    local songbad = getProperty('bads')
    local songshit = getProperty('shits')
    local songratingfc = getProperty('ratingFC')
    local songrating = getProperty('ratingName')

    setTextString('sick', 'Sicks: '..songsick)
    setTextString('good', 'Goods: '..songgood)
    setTextString('bad', 'Bads: '..songbad)
    setTextString('shit', 'Shits: '..songshit)

    setTextString('score', 'Score: '..songscore)
    setTextString('misses', 'Combo Breaks: '..songmiss)
    setTextString('acc', 'Accuracy: '..songacc..'%')
    setTextString('rating', 'Rating: '..songratingfc..songrating)
end

function onEndSong()
    if not botPlay then
       setProperty('bot.visible',false)
  end
    if E == true then
       return Function_Continue;
  end

  doTweenAlpha('endsong1', 'cardboard', 1, 0.3, 'linear')
  doTweenAlpha('endsong2', 'complete', 1, 0.3, 'linear')
  doTweenAlpha('endsong3', 'name', 1, 0.3, 'linear')
  doTweenAlpha('endsong4', 'enter', 1, 0.3, 'linear')
  doTweenAlpha('endsong5', 'score', 1, 0.3, 'linear')
  doTweenAlpha('endsong6', 'misses', 1, 0.3, 'linear')
  doTweenAlpha('endsong7', 'acc', 1, 0.3, 'linear')
  doTweenAlpha('endsong8', 'rating', 1, 0.3, 'linear')
  doTweenAlpha('endsong9', 'sick', 1, 0.3, 'linear')
  doTweenAlpha('endsong10', 'good', 1, 0.3, 'linear')
  doTweenAlpha('endsong11', 'bad', 1, 0.3, 'linear')
  doTweenAlpha('endsong12', 'shit', 1, 0.3, 'linear')
  doTweenAlpha('endsong13', 'blackblack', 0.8, 0.3, 'linear')

ok = true

return Function_Stop;

end

function onPause()
   if ok == true then
     return Function_Stop;
  end
end