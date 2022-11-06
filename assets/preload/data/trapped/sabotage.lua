function onCreate()
    makeLuaSprite('sabotage', '', 0, 0)
    makeGraphic('sabotage', 1280, 720, 'ff0000')
    setObjectCamera('sabotage', 'hud')
    setProperty('sabotage.alpha', 0)
    addLuaSprite('sabotage')
    
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

function alert()
    setProperty('sabotage.alpha', 0.9)
    doTweenAlpha('alert', 'sabotage', 0, 0.5, 'linear')
end

function onBeatHit()

    if curBeat == 8 then
        alert()
    end

    if curBeat == 16 then
        alert()
    end

    if curBeat == 24 then
        alert()
    end

    if curBeat == 32 then
        alert()
    end

    if curBeat == 40 then
        alert()
    end

    if curBeat == 48 then
        alert()
    end

    if curBeat == 56 then
        alert()
    end

    if curBeat == 64 then
        alert()
    end

    if curBeat == 72 then
        alert()
    end

    if curBeat == 80 then
        alert()
    end

    if curBeat == 88 then
        alert()
    end

    if curBeat == 96 then
        alert()
    end

    if curBeat == 104 then
        alert()
    end

    if curBeat == 112 then
        alert()
    end

    if curBeat == 120 then
        alert()
    end

    if curBeat == 128 then
        alert()
    end

    if curBeat == 136 then
        alert()
    end

    if curBeat == 144 then
        alert()
    end

    if curBeat == 152 then
        alert()
    end

    if curBeat == 160 then
        alert()
    end

    if curBeat == 168 then
        alert()
    end

    if curBeat == 176 then
        alert()
    end

    if curBeat == 184 then
        alert()
    end

    if curBeat == 192 then
        alert()
    end

    if curBeat == 200 then
        alert()
    end

    if curBeat == 208 then
        alert()
    end

    if curBeat == 216 then
        alert()
    end

    if curBeat == 224 then
        alert()
    end

    if curBeat == 232 then
        alert()
    end

    if curBeat == 240 then
        alert()
    end

    if curBeat == 248 then
        alert()
    end

    if curBeat == 256 then
        alert()
    end

    if curBeat == 264 then
        alert()
    end

    if curBeat == 272 then
        alert()
    end

    if curBeat == 280 then
        alert()
    end

    if curBeat == 288 then
        alert()
    end

    if curBeat == 296 then
        alert()
    end

    if curBeat == 304 then
        alert()
    end

    if curBeat == 312 then
        alert()
    end

    if curBeat == 320 then
        alert()
    end

    if curBeat == 328 then
        alert()
    end

    if curBeat == 336 then
        alert()
    end

    if curBeat == 344 then
        alert()
    end

    if curBeat == 352 then
        alert()
    end

    if curBeat == 360 then
        alert()
    end

    if curBeat == 368 then
        alert()
    end

    if curBeat == 376 then
        alert()
    end

    if curBeat == 384 then
        alert()
    end

    if curBeat == 392 then
        alert()
    end

    if curBeat == 400 then
        alert()
    end

    if curBeat == 408 then
        alert()
    end

    if curBeat == 416 then
        alert()
    end

    if curBeat == 424 then
        alert()
    end

    if curBeat == 432 then
        alert()
    end

    if curBeat == 440 then
        alert()
    end

    if curBeat == 448 then
        alert()
    end

    if curBeat == 456 then
        alert()
    end

    if curBeat == 464 then
        alert()
    end

    if curBeat == 472 then
        alert()
    end

    if curBeat == 480 then
        alert()
    end

    if curBeat == 488 then
        alert()
    end

    if curBeat == 496 then
        alert()
    end

    if curBeat == 504 then
        alert()
    end

    if curBeat == 512 then
        alert()
    end

    if curBeat == 520 then
        alert()
    end

    if curBeat == 528 then
        alert()
    end

    if curBeat == 536 then
        alert()
    end

    if curBeat == 544 then
        alert()
    end

    if curBeat == 552 then
        alert()
    end

    if curBeat == 560 then
        alert()
    end

    if curBeat == 568 then
        alert()
    end

    if curBeat == 576 then
        alert()
    end

    if curBeat == 584 then
        alert()
    end

    if curBeat == 592 then
        alert()
    end

    if curBeat == 600 then
        alert()
    end

    if curBeat == 608 then
        alert()
    end

    if curBeat == 616 then
        alert()
    end

    if curBeat == 624 then
        alert()
    end

    if curBeat == 632 then
        alert()
    end

    if curBeat == 640 then
        alert()
    end

    if curBeat == 648 then
        alert()
    end

    if curBeat == 656 then
        alert()
    end

    if curBeat == 664 then
        alert()
    end

    if curBeat == 672 then
        alert()
    end

    if curBeat == 680 then
        alert()
    end

    if curBeat == 688 then
        alert()
    end

    if curBeat == 696 then
        alert()
    end

    if curBeat == 704 then
        alert()
    end

    if curBeat == 712 then
        alert()
    end

    if curBeat == 720 then
        alert()
    end

    if curBeat == 728 then
        alert()
    end

    if curBeat == 736 then
        alert()
    end

    if curBeat == 744 then
        alert()
    end

    if curBeat == 752 then
        alert()
    end

    if curBeat == 760 then
        alert()
    end

    if curBeat == 768 then
        alert()
    end

    if curBeat == 776 then
        alert()
    end

    if curBeat == 784 then
        alert()
    end

    if curBeat == 792 then
        alert()
    end

    if curBeat == 800 then
        alert()
    end

    if curBeat == 808 then
        alert()
    end

    if curBeat == 816 then
        alert()
    end

    if curBeat == 824 then
        alert()
    end

    if curBeat == 832 then
        alert()
    end

    if curBeat == 840 then
        alert()
    end

    if curBeat == 848 then
        alert()
    end

    if curBeat == 856 then
        alert()
    end

    if curBeat == 864 then
        alert()
    end

    if curBeat == 872 then
        alert()
    end

    if curBeat == 880 then
        alert()
    end

    if curBeat == 888 then
        alert()
    end

    if curBeat == 896 then
        alert()
    end

    if curBeat == 904 then
        alert()
    end

    if curBeat == 912 then
        alert()
    end

    if curBeat == 920 then
        alert()
    end

    if curBeat == 928 then
        alert()
    end

    if curBeat == 936 then
        alert()
    end

    if curBeat == 944 then
        alert()
    end

    if curBeat == 952 then
        alert()
    end

    if curBeat == 960 then
        alert()
    end

    if curBeat == 968 then
        alert()
    end

    if curBeat == 976 then
        alert()
    end

    if curBeat == 984 then
        alert()
    end

    if curBeat == 992 then
        alert()
    end

end

function onStepHit()

    if curStep == 1 then
        alert()
    end
end