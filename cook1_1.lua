-----------------------------------------------------------------------------------------
--
-- cook1_1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- 랜덤함수
math.randomseed(os.time())

-- 라이브러리 추가
local widget = require("widget")

-- 변수 받기
local arrow = composer.getVariable("arrow")
--local money = composer.getVariable("money")

-- 변수 선언
local background = {} -- 주방, 도마
local gameUI = {} -- 환경설정, 레시피, 카운터로 가기, 오픈된 레시피북
local btnUI = {} -- 휴지통 버튼, 완성 버튼
local igUI = {} -- 나열된 재료/ 김, 밥, 단무지, 달걀, 햄
local usedigUI = {} -- 도마 위 사용된 재료/ 김, 밥, 단무지, 달걀, 햄
local kimbapUI = {} -- 꼬마김밥, 다른김밥1, 다른김밥2 ...
local moneyUI = {} -- 표시, 금액
local flag
local money 


function scene:create( event )
	local sceneGroup = self.view
    
    -- [[ UI 배치 ]]
    -- 배경화면
    background[1] = display.newImageRect("image/kitchen.png", display.contentWidth, display.contentHeight)
    background[1].x, background[1].y = display.contentWidth/2, display.contentHeight/2
    
    -- 상단 우측 게임 UI
    gameUI[1] = display.newImage("image/back_arrow.png")
    gameUI[1].x, gameUI[1].y = 50, display.contentHeight/2-50
    
    -- 하단 우측 버튼 UI
    btnUI[1] = display.newImageRect("image/trashcan.png", 87, 102)
    btnUI[1].x, btnUI[1].y = display.contentWidth - 55, display.contentHeight - 150
    btnUI[2] = display.newImage("image/ok.png")
    btnUI[2].x, btnUI[2].y = display.contentWidth - 180, display.contentHeight - 55

    -- 좌측 나열된 재료
    igUI[1] = display.newImage("image/seaweed1.png")
    igUI[1].x, igUI[1].y = 130, 675
    igUI[2] = display.newImage("image/rice1.png")
    igUI[2].x, igUI[2].y = 800, 43
    igUI[3] = display.newImage("image/pickledradish.png")
    igUI[3].x, igUI[3].y = 134, 385
    igUI[4] = display.newImage("image/egg1.png")
    igUI[4].x, igUI[4].y = 134, 530
    igUI[5] = display.newImage("image/ham1.png")
    igUI[5].x, igUI[5].y = 134, 245
    for i = 1, 5, 1 do
        --igUI[i].x, igUI[i].y = 130, 100 + 130 * (i - 1)
        igUI[i].name = i
    end

    -- 도마위에 올려지고 사용되는 김밥 재료들
    usedigUI[1] = display.newImage("image/seaweed2.png")
    usedigUI[1].x, usedigUI[1].y = 670, 410
    usedigUI[2] = display.newImage("image/rice2.png")
    usedigUI[2].x, usedigUI[2].y = 670, 380
    usedigUI[3] = display.newImage("image/pickledradish2.png")
    usedigUI[4] = display.newImage("image/egg2.png")
    usedigUI[5] = display.newImage("image/ham2.png")
    for i = 3, 5, 1 do usedigUI[i].x, usedigUI[i].y = 670, 460 - 17 * (i - 1) end -- 재료 위치
    for i = 1, 5, 1 do usedigUI[i].alpha = 0 end

    -- 김밥들
    kimbapUI[1] = display.newImageRect("image/kimbap.png", 390, 130)
    kimbapUI[1].x, kimbapUI[1].y = 670, 360
    kimbapUI[1].alpha = 0
    kimbapUI[2] = display.newImageRect("image/kimbap_fail.png", 250, 250)
    kimbapUI[2].x, kimbapUI[2].y = 670, 360
    kimbapUI[2].alpha = 0

    --[[ 돈
    moneyUI[1] = display.newText("10000원", 1125, 160, "굴림")
    moneyUI[1]:setFillColor(0)
    moneyUI[1].size = 25
    money = 10000 ]]



    -- [[ 함수들 ]]
    -- 카운터로 이동하는 함수
    local function moveCounter()
        composer.gotoScene("counter1_1")
    end

    
    --[[ 재료 계산
    local function calcIg()
        money = money - 80
        moneyUI.text = string.format("%05d원", money)
    end ]]
    
    -- 도마 위에 재료를 올려놓는 함수
    local function putIg(event)
        usedigUI[event.target.name].alpha = 1
        igUI[event.target.name]:removeEventListener("tap", putIg)
        --calcIg()
    end
    
    
    local function regame()
        for i = 1, 5, 1 do igUI[i]:addEventListener("tap", putIg) end
    end
    
    --[[ 금액 계산
    local function calckimbap()
        --money = money + 1000
        --moneyUI.text = string.format("%05d원", money)
        for i = 1, 2, 1 do  kimbapUI[i].alpha = 0 end
        for i = 1, 5, 1 do usedigUI[i].alpha = 0 end
        kimbapUI[1]:removeEventListener("tap", calckimbap)
        regame()
    end ]]

    -- 휴지통 버튼 함수/ 사용된 재료 완성된 김밥 모두 삭제
    local function cancelIg()
        for i = 1, 2, 1 do  kimbapUI[i].alpha = 0 end
        for i = 1, 5, 1 do usedigUI[i].alpha = 0 end
        --if flag == 0 then
            regame()
        --end
    end
    

    -- 완성 버튼 함수
    local function finishIg()
        flag = 1
        
        for i = 1, 5, 1 do
            if usedigUI[i].alpha == 0 then
                flag = 0
                --break
            end
        end
        
        for i = 1, 2, 1 do  kimbapUI[i].alpha = 0 end
        for i = 1, 5, 1 do usedigUI[i].alpha = 0 end
        
        if flag == 0 then -- 김밥 실패
            kimbapUI[1].alpha = 0
            kimbapUI[2].alpha = 1
            for i = 1, 5, 1 do igUI[i]:removeEventListener("tap", putIg) end
        else -- 김밥 성공
            kimbapUI[1].alpha = 1
            kimbapUI[2].alpha = 0
            --kimbapUI[1]:addEventListener("tap", calckimbap)
            for i = 1, 5, 1 do igUI[i]:removeEventListener("tap", putIg) end
        end
    end
    


    -- 이벤트 등록
    gameUI[1]:addEventListener("tap", moveCounter) -- 카운터로 이동하기
    for i = 1, 5, 1 do igUI[i]:addEventListener("tap", putIg) end
    btnUI[1]:addEventListener("tap", cancelIg) -- 휴지통
    btnUI[2]:addEventListener("tap", finishIg) -- 완성버튼
    

    -- Scene 삽입
    sceneGroup:insert(background[1])
    for i = 1, 2, 1 do sceneGroup:insert(kimbapUI[i]) end
    for i = 1, 5, 1 do sceneGroup:insert(igUI[i]) end
    for i = 1, 5, 1 do sceneGroup:insert(usedigUI[i]) end
    sceneGroup:insert(gameUI[1])
    for i = 1, 2, 1 do sceneGroup:insert(btnUI[i]) end

end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene