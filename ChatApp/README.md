
<br>

# chat_app

- [ ] chat_rooms_screen 내 대화방 개설 기능 구현(새 화면 이동 후 user 검색해서 목록에서 터치시 개설되는 형태로 구현)
  - [ ] 유저 목록 및 대화방 개설시 필요한 새 screen 구현
    - 화면 진입시 users collection fetch 후 username 을 key 로 map 생성
    - 유저 선택시 users > 본인 > `List<chatRooms>` 에서 이미 존재하는 상대와의 대화면 생성하지 않는다
    - 대화방 생성시 chat_detail_screen 이동
- [ ] chat_rooms_screen 진입시 chatRooms document fetch 및 해당 user 의 `List<chatRooms>` 와 비교하여 해당 유저 대화방만 노출
- [ ] chat_rooms_screen 내 특정 대화방 터치시 대화 내용 끌고와 뿌려준다. 새 대화 추가시 해당 document 에 추가