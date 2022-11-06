--custom opponent note skin <3 V2.2
--credit to vCherry.kAI.16 <3 if you remove this text then you're not allowed to use this

  --Handy little guide!
-- "Strums_Texture" must exactly match the .png and .xml file you want to use for *THE OPPONENT'S* strums(located in images)
-- "Notes_Texture" must exactly match the .png and .xml file you want to use for *THE OPPONENT'S* notes(located in images)
-- Please put the texture names within the empty apostrophes(aka the '')!
-- If you want to add a custom note type to the list, go to Line 16 and add " or '(note_type)'" after 'GF Sing'

--REPLACE THESE!!!
local Strums_Texture_Red = 'notes/player'
local Notes_Texture_Red = 'notes/player'

local Strums_Texture_Yellow = 'notes/veteran'
local Notes_Texture_Yellow = 'notes/veteran'

local Strums_Texture_Novisor = 'notes/novisor'
local Notes_Texture_Novisor = 'notes/novisor'

local Strums_Texture_Black = 'notes/black'
local Notes_Texture_Black = 'notes/black'

local Strums_Texture_Pink = 'notes/pink'
local Notes_Texture_Pink = 'notes/pink'

local Strums_Texture_Gentleman = 'notes/gentleman'
local Notes_Texture_Gentleman = 'notes/gentleman'

local Strums_Texture_Ria = 'notes/ria'
local Notes_Texture_Ria = 'notes/ria'

local Splashes_Texture_Red = 'notes/player_splash'
local Splashes_Texture_Yellow = 'notes/yellow_splash'

local Strums_Texture_Brown = 'notes/aiden'
local Notes_Texture_Brown = 'notes/aiden'

function onUpdatePost()
  
  if songName == 'Skeld' or songName == 'Mira HQ' or songName == 'Ugh' or songName == 'ChallengEdd' then
    for i = 0, getProperty('opponentStrums.length')-1 do
  
      setPropertyFromGroup('opponentStrums', i, 'texture', Strums_Texture_Red);
  
      if not getPropertyFromGroup('notes', i, 'mustPress') and getPropertyFromGroup('notes', i, 'noteType') == ('' or 'Hey!' or 'No Animation' or 'GF Sing') then
        setPropertyFromGroup('notes', i, 'texture', Notes_Texture_Red);
      end
  
    end
  end

  if songName == 'Custom' then
    for i = 0, getProperty('opponentStrums.length')-1 do
  
      setPropertyFromGroup('opponentStrums', i, 'texture', Strums_Texture_Brown);
  
      if not getPropertyFromGroup('notes', i, 'mustPress') and getPropertyFromGroup('notes', i, 'noteType') == ('' or 'Hey!' or 'No Animation' or 'GF Sing') then
        setPropertyFromGroup('notes', i, 'texture', Notes_Texture_Brown);
      end
  
    end
  end

  if songName == 'Dark Electrical' then
    for i = 0, getProperty('opponentStrums.length')-1 do
  
      setPropertyFromGroup('opponentStrums', i, 'texture', Strums_Texture_Gentleman);
  
      if not getPropertyFromGroup('notes', i, 'mustPress') and getPropertyFromGroup('notes', i, 'noteType') == ('' or 'Hey!' or 'No Animation' or 'GF Sing') then
        setPropertyFromGroup('notes', i, 'texture', Notes_Texture_Gentleman);
      end
  
    end
  end

  if songName == 'Ria Roll' then
    for i = 0, getProperty('opponentStrums.length')-1 do
  
      setPropertyFromGroup('opponentStrums', i, 'texture', Strums_Texture_Ria);
  
      if not getPropertyFromGroup('notes', i, 'mustPress') and getPropertyFromGroup('notes', i, 'noteType') == ('' or 'Hey!' or 'No Animation' or 'GF Sing') then
        setPropertyFromGroup('notes', i, 'texture', Notes_Texture_Ria);
      end
  
    end
  end

  if songName == 'Lights' or songName == 'Airship' then
    for i = 0, getProperty('opponentStrums.length')-1 do
  
      setPropertyFromGroup('opponentStrums', i, 'texture', Strums_Texture_Yellow);
  
      if not getPropertyFromGroup('notes', i, 'mustPress') and getPropertyFromGroup('notes', i, 'noteType') == ('' or 'Hey!' or 'No Animation' or 'GF Sing') then
        setPropertyFromGroup('notes', i, 'texture', Notes_Texture_Yellow);
      end
  
    end
  end

  if songName == 'Visor' or songName == 'Confronting Yourself' then
    for i = 0, getProperty('opponentStrums.length')-1 do
  
      setPropertyFromGroup('opponentStrums', i, 'texture', Strums_Texture_Black);
  
      if not getPropertyFromGroup('notes', i, 'mustPress') and getPropertyFromGroup('notes', i, 'noteType') == ('' or 'Hey!' or 'No Animation' or 'GF Sing') then
        setPropertyFromGroup('notes', i, 'texture', Notes_Texture_Black);
      end
  
    end
  end

  if songName == 'Corrupted' or songName == 'Trapped' or songName == 'Escape' or songName == 'Distraught' or songName == 'No Escape' then
    for i = 0, getProperty('opponentStrums.length')-1 do
  
      setPropertyFromGroup('opponentStrums', i, 'texture', Strums_Texture_Novisor);
  
      if not getPropertyFromGroup('notes', i, 'mustPress') and getPropertyFromGroup('notes', i, 'noteType') == ('' or 'Hey!' or 'No Animation' or 'GF Sing') then
        setPropertyFromGroup('notes', i, 'texture', Notes_Texture_Novisor);
      end
  
    end
  end

  if songName == 'Distraught' then
    for i = 0, getProperty('playerStrums.length')-1 do

      setPropertyFromGroup('playerStrums', i, 'texture', Strums_Texture_Red);
  
      if getPropertyFromGroup('notes', i, 'mustPress') and getPropertyFromGroup('notes', i, 'noteType') == ('' or 'Hey!' or 'No Animation' or 'GF Sing') then
        setPropertyFromGroup('notes', i, 'texture', Notes_Texture_Red);
        setPropertyFromGroup('notes', i, 'noteSplashTexture', Splashes_Texture_Red);
      end
  end
end

if songName == 'Ugh' then
  for i = 0, getProperty('playerStrums.length')-1 do

    setPropertyFromGroup('playerStrums', i, 'texture', Strums_Texture_Yellow);

    if getPropertyFromGroup('notes', i, 'mustPress') and getPropertyFromGroup('notes', i, 'noteType') == ('' or 'Hey!' or 'No Animation' or 'GF Sing') then
      setPropertyFromGroup('notes', i, 'texture', Notes_Texture_Yellow);
      setPropertyFromGroup('notes', i, 'noteSplashTexture', Splashes_Texture_Yellow);
    end
end
end

  if songName == 'Report' then
    for i = 0, getProperty('opponentStrums.length')-1 do
  
      setPropertyFromGroup('opponentStrums', i, 'texture', Strums_Texture_Pink);
  
      if not getPropertyFromGroup('notes', i, 'mustPress') and getPropertyFromGroup('notes', i, 'noteType') == ('' or 'Hey!' or 'No Animation' or 'GF Sing') then
        setPropertyFromGroup('notes', i, 'texture', Notes_Texture_Pink);
      end
  
    end
  end

end