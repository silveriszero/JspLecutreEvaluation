# JSP 강의 평가 사이트

## 소개

JSP 강의 평가 사이트는 사용자가 강의에 대한 평가를 남기고, 다른 사용자의 평가를 확인할 수 있는 웹 애플리케이션입니다. 이 프로젝트는 JSP와 MySQL을 활용하여 구현되었습니다.

## 기능

- 회원가입 및 로그인
- 강의 목록 조회
- 강의별 평가 작성
- 평가 수정 및 삭제
- 이메일 인증을 통한 회원가입 확인

## 기술 스택

- **Backend**: JSP
- **Frontend**: HTML, CSS, JavaScript, JSP
- **Database**: MySQL
- **IDE**: Eclipse
- **Server**: Apache Tomcat

## 프로젝트 구조

```
Lecture-Evaluation/
│── src/main/java/
│   ├── model/        # 데이터 모델 및 DAO
│   ├── servlet/      # 서블릿 클래스
│── src/main/webapp/
│   ├── css/          # CSS
│   ├── js/           # JavaScript
│   ├── .JSP          # 설정 파일 및 JSP 페이지
```

## ⚙️ 프로젝트 설정 및 실행 방법
1. 프로젝트 클론
```bash
git clone https://github.com/your-repository/jsp-lecture-evaluation.git
cd jsp-lecture-evaluation
```

2. 데이터베이스 설정
   - MySQL에 `lecture_evaluation` 데이터베이스 생성
   - `db.properties` 파일에 MySQL 접속 정보 입력

3. 프로젝트 빌드 및 실행
   - Tomcat 서버에 프로젝트 배포 후 실행

4. 웹사이트 접속
   - 브라우저에서 `http://localhost:8080/lecture-evaluation` 접속


## 📌 개발자
- **이름:** 이은영
- **이메일:** eunyoung0753@naver.com
- **GitHub:** [github.com/silveriszero](https://github.com/silveriszero)



