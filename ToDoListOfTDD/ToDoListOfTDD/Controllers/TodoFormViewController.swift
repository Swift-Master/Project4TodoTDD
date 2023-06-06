
import UIKit
import SnapKit

// MARK: - form을 작성하고 새 todo를 생성하는 화면
class TodoFormViewController: UIViewController {
    
    // MARK: - 전역 변수/상수
    var datePicker = UIDatePicker()
    var itemManager : ModelManager?
    var pickerLabel = {
        let label = UILabel()
        label.text = "날짜"
        label.textAlignment = .center
        return label
    }()
    lazy var titleTextField = textField
    lazy var locationTextField = textField
    lazy var descriptionTextField = textField
    lazy var buttonStack : UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cancelButton,submitButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    lazy var cancelButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.addTarget(self, action: #selector(discardForm), for: .touchUpInside)
        return button
    }()
    lazy var submitButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.setTitle("완료", for: .normal)
        button.setTitleColor(.systemGray, for: .disabled)
        button.setTitleColor(.systemBlue, for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(submitForm), for: .touchUpInside)
        return button
    }()
    
    // MARK: - UITextField 생성 메서드
    var textField : UITextField {
        return {
            let textField = UITextField()
            textField.font = .systemFont(ofSize: 24)
            textField.textAlignment = .left
            textField.autocapitalizationType = .none
            textField.autocorrectionType = .no
            textField.spellCheckingType = .no
            textField.clearsOnBeginEditing = false
            textField.layer.cornerRadius = 5
            textField.layer.borderWidth = 1
            textField.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            return textField
        }()
    }
    
    // MARK: - 네비게이션 바의 back 버튼이 보이지 않도록 처리
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    // MARK: - 작성 form 외의 영역 터치시 키보드가 내려가도록 합니다.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        [titleTextField,locationTextField,descriptionTextField].forEach{$0.resignFirstResponder()}
    }
    
    func setUI() {
        setAttributes()
        setConstraints()
    }
    
    func setAttributes() {
        view.backgroundColor = .white
        setTextfieldAttributes()
        setDatePickerAttributes()
    }
    
    func setConstraints() {
        setTextfieldConstraints()
        setDatePickerConstraints()
        setButtonConstraints()
    }
    
    // MARK: - 텍스트필드 영역 속성 설정
    func setTextfieldAttributes() {
        titleTextField.placeholder = " 할일 명"
        locationTextField.placeholder = " 장소"
        descriptionTextField.placeholder = " 상세 설명"
        titleTextField.becomeFirstResponder()
        // 화면 로드시 바로 키보드가 올라오도록 만듭니다
    }
    
    // MARK: - DatePicker 속성 설정
    func setDatePickerAttributes() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.timeZone = .autoupdatingCurrent
        datePicker.date = Date()
        datePicker.addTarget(self, action: #selector(checkForm), for: .valueChanged)
        //값이 변할때마다 form 검사 메서드를 호출
    }
    
    // MARK: - UI 요소들 레이아웃 설정
    func setTextfieldConstraints() {
        [titleTextField,locationTextField,descriptionTextField].forEach{view.addSubview($0)}
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.width.equalTo(200)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        locationTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.top).offset(50)
            make.width.equalTo(200)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        descriptionTextField.snp.makeConstraints { make in
            make.top.equalTo(locationTextField.snp.top).offset(50)
            make.width.equalTo(200)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setDatePickerConstraints() {
        view.addSubview(datePicker)
        view.addSubview(pickerLabel)
        pickerLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionTextField.snp.top).offset(50)
            make.width.equalTo(200)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(pickerLabel.snp.bottom).offset(5)
            make.width.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setButtonConstraints() {
        view.addSubview(buttonStack)
        buttonStack.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom).offset(50)
            make.width.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - form 정보로 모델 객체 생성 및 테이블 뷰 참조 배열에 추가해주는 메서드
    func createItem(title : String, description : String, date : Date, location : String) {
        let newItem = TodoItem(title: title, description: description, rawDate: date, todoLocation: Location(name: location))
        itemManager?.addItem(newItem)
    }
    
    // MARK: - cancel 버튼 선택 시 이전 화면으로 돌아갑니다
    @objc func discardForm() {
        navigationController?.popViewController(animated: false)
    }
    
    // MARK: - form 정보로 모델 객체 생성 및 리스트에 추가 후 이전 화면으로 돌아갑니다
    @objc func submitForm() {
        guard let title = titleTextField.text,let location = locationTextField.text,let detail = descriptionTextField.text else {return}
        
        createItem(title: title, description: detail, date: datePicker.date, location: location)
        navigationController?.popViewController(animated: false)
    }
    
    // MARK: - form을 모두 입력했다면 submit 버튼을 활성화시킵니다
    @objc func checkForm() {
        guard let title = titleTextField.text,let location = locationTextField.text,let detail = descriptionTextField.text else {return}
        if title.count > 0 && location.count > 0 && detail.count > 0 {
            submitButton.isEnabled = true
        }
    }
}

// MARK: - form 입력 후 엔터(return) 입력 시 키보드를 내립니다
extension TodoFormViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
