package member.model;

public class MemberVO {
	private String userid;  // 회원아이디
    private String pwd;  //SHA-256 암호화 대상
    private String name;  // 이름
    private String email;  // AES-256 암호화/복호화 대상
    private String mobile;  // 핸드폰번호
    private String postcode;  // 우편번호
    private String address;  // 주소
    private String detailaddress;  // 상세주소
    private String extraaddress;  // 참고항목
    private String gender;  // 성별 남자 1 여자 2
    private String birthday;  // 생년월일
    private int coin;  // 코인액
    private int point;  // 포인트
    private String registerday;  // 가입일자
    private String lastpwdchangedate;  // 마지막 암호 변경 날짜
    private int status;  // 회원탈퇴유무 1: 사용가능 2: 사용불가
    private int idle;  // 휴면 유무 0: 활동중 1: 휴면중
    
    
    private String birthyyyy;
    private String birthmm;
    private String birthdd;
    
    private boolean requirePwdChange;
    
    
    
    public MemberVO() {
		// TODO Auto-generated constructor stub
	}
    
    
	public MemberVO(String userid, String pwd, String name, String email, String mobile, String postcode,
			String address, String detailaddress, String extraaddress, String gender, String birthday) {
		super();
		this.userid = userid;
		this.pwd = pwd;
		this.name = name;
		this.email = email;
		this.mobile = mobile;
		this.postcode = postcode;
		this.address = address;
		this.detailaddress = detailaddress;
		this.extraaddress = extraaddress;
		this.gender = gender;
		this.birthday = birthday;
		
	}


	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getPostcode() {
		return postcode;
	}
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getDetailaddress() {
		return detailaddress;
	}
	public void setDetailaddress(String detailaddress) {
		this.detailaddress = detailaddress;
	}
	public String getExtraaddress() {
		return extraaddress;
	}
	public void setExtraaddress(String extraaddress) {
		this.extraaddress = extraaddress;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public int getCoin() {
		return coin;
	}
	public void setCoin(int coin) {
		this.coin = coin;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public String getRegisterday() {
		return registerday;
	}
	public void setRegisterday(String registerday) {
		this.registerday = registerday;
	}
	public String getLastpwdchangedate() {
		return lastpwdchangedate;
	}
	public void setLastpwdchangedate(String lastpwdchangedate) {
		this.lastpwdchangedate = lastpwdchangedate;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getIdle() {
		return idle;
	}
	public void setIdle(int idle) {
		this.idle = idle;
	}


	public String getBirthyyyy() {
		return birthyyyy;
	}


	public void setBirthyyyy(String birthyyyy) {
		this.birthyyyy = birthyyyy;
	}


	public String getBirthmm() {
		return birthmm;
	}


	public void setBirthmm(String birthmm) {
		this.birthmm = birthmm;
	}


	public String getBirthdd() {
		return birthdd;
	}


	public void setBirthdd(String birthdd) {
		this.birthdd = birthdd;
	}


	public boolean isRequirePwdChange() {
		return requirePwdChange;
	}


	public void setRequirePwdChange(boolean requirePwdChange) {
		this.requirePwdChange = requirePwdChange;
	}
	
	
	
    
    
}
