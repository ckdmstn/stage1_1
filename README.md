변경한 부분



counter1_1 (일단 이름 변경함)

1. toCook함수 cook -> cook1_1
2. gameUI[5] 변경 
3. 버튼들 overFile 일단 주석처리함
4. gameUI[9] 추가 : 돈 입력 바 
5. cook1_1에 있던 레시피 여기로 옮김(gameUI[10])
6. cook에 있던 openRecipe(), closeRecipe() 함수 여기에 추가
7. gameUI[5]:addEventListener("tap", openRecipe) 
   gameUI[10]:addEventListener("tap", closeRecipe) 추가함



cook1_1 (이름변경)

1. background[2] 삭제
2. gameUI[1], gameUI[2], gameUI[4] 삭제 -> gameUI[3->1]로 변경 
   gameUI[1], gameUI[2], gameUI[4] 부분은 counter1_1에서 연결
3. 돈 부분을 주석처리 해둠 
4. moveCounter함수 counter -> counter1_1 
5. calcIg()함수 일단 주석처리 
   (counter에서 돈 연결받아서 변경시키고자 했는데 안됨..ㅜㅜ.........)
6. putIg()함수에 igUI[event.target.name]:removeEventListener("tap", putIg) 추가함
   이유 : 재료를 눌러서 이미 재료값이 나갔는데 또 눌러보니 또 재료 값이 나감
	그래서 재료 한번 클릭하면 못 누르게 해둠
   calcIg() 주석처리
7. openRecipe(), closeRecipe() 삭제
8. calckimbap() 주석처리
9. cancelIg()에 flag==0이면 regame() 실행되게 해뒀었는데 이미 휴지통 누른 이상
   flag가 뭐든 간에 재료들 removeEvent시켜놔서 regame()을 해야 한다고 판단했음
10. finishIg() 김밥성공부분 
    kimbapUI[1]:addEventListener("tap", calckimbap<얘때문) 주석처리
11. 이벤트 등록부분
     gameUI[2], gameUI[4]삭제, gameUI[3->1] 변경
     scene삽입부분
     background[1]로 변경, 




전체적인 변경

디자이너분께서 보내주신 이미지로 변경
그에 따라 좌표도 변경



변경해야 하는 부분

1. 손님 + 주문부분 (graphics.newImageSheet를 쓰셔서 감히 손대기가 두려움..)
   첫단계라 꼬마김밥만 주문받음
   주문수락, 거절버튼, 대기바 추가 (대기바 줄어드는 것도...추가...)
2. 돈 - counter <-> cook (..........)
         cook에서는 재료를 쓰면 80원씩 줄어들기, 
         counter에서 김밥 제공하면 돈 증가
3. 돼지저금통 추가
4. 시간 흐름 (지금은 그냥 1초마다 month++여서..)
5. 체력, 정신력 -
   cook에서 음식 완성 버튼 누르면 체력--, 잘못만들면 정신력--, 잘만들면 정신력++
   근데 체력정신력은 counter에 있는데 cook에서 어떻게 할 수 있을까요
6. 시간 다 흐르면 날짜 넘어가서 게임 다시 플레이 
    -> 일단 시간 흐름 제대로 잡고 추후 수정(제가!)

(image에 이미지 이름이 한글인 건 아직 사용하지 않았다는 뜻 (전체적인UI제외))