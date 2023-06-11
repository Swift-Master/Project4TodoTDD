# Project4 : ToDoTDD

## 20230608

### Main 화면
- Navigation Item으로 Input 화면 이동
- TableView

### Input 화면
- TextField, DatePicker

## 20230609

### MVC 구조 변경
```markdown
- Project
    - Sources
        - AppDelegate.swift
        - SceneDelegate.swift
        - Models
            - ...
        - Views
            - ...
        - Controllers
            - ...
        - Helpers
            - ...
    - Resources
        - Assets.xcassets
        - ...
    - Supporting Files
        - Info.plist
        - ...
    - Tests
        - ...
```
info.plist의 경우 루트 경로가 지정되어 있어서 Build Setting에서 경로를 변경해주어야 됨

### Detail 화면
- `import MapKit`
- 입력한 주소를 지도 가운데로 이동
- Annotation을 사용하여 이동한 주소에 핀을 꽂고, 설명 출력

## 구현 화면
<img src="./ToDoTDD_step1.gif" width="300" />
