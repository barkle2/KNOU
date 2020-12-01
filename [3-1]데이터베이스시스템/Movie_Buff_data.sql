INSERT INTO 감독 VALUES ('A001', '명감독', '남', '1969-09-14', '대구', 183, 100, 'AB');
INSERT INTO 감독 VALUES ('A002', '박찬욱', '남', '1963-08-23', '서울', 169, 70, 'O');
INSERT INTO 감독 VALUES ('A003', '이창동', '남', '1954-04-01', '대구', 181, 78, 'O');
INSERT INTO 감독 VALUES ('A004', '구혜선', '여', '1984-11-09', '인천', 163, 50, 'A');
INSERT INTO 감독 VALUES ('A005', '류승완', '남', '1973-12-15', '충남', 172, 64, 'B');

INSERT INTO 영화 VALUES ('M001', '기생충', 2019, '한국', 131, '2019-05-30', '바른손이앤에이', 'CJ엔터테인먼트');
INSERT INTO 영화 VALUES ('M002', '올드보이', 2003, '한국', 120, '2003-11-21', '(주)에그필름', '쇼이스트');
INSERT INTO 영화 VALUES ('M003', '오아시스', 2002, '한국', 132, '2002-08-15', '이스트필름', 'CJ엔터테인먼트');
INSERT INTO 영화 VALUES ('M004', '다우더', 2014, '한국', 83, '2014-11-06', '예스프로덕션', '어뮤즈');

INSERT INTO 배우 VALUES ('B001', '구혜선', '여', '1984-11-09', '인천', 163, 50, 'A');
INSERT INTO 배우 VALUES ('B002', '심혜진', '여', '1967-01-16', '서울', 169, 51, 'B');
INSERT INTO 배우 VALUES ('B003', '설경구', '남', '1967-05-14', '충남', 175, 70, 'O');
INSERT INTO 배우 VALUES ('B004', '문소리', '여', '1974-07-02', '부산', 164, 50, 'A');
INSERT INTO 배우 VALUES ('B005', '최민식', '남', '1962-05-30', '서울', 177, 72, 'B');
INSERT INTO 배우 VALUES ('B006', '강혜정', '여', '1982-01-04', '인천', 162, 46, 'O');
INSERT INTO 배우 VALUES ('B007', '송강호', '남', '1967-02-25', '경남', 180, 80, 'A');
INSERT INTO 배우 VALUES ('B008', '최우식', '남', '1990-03-26', '서울', 180, 65, 'O');

INSERT INTO 촬영 VALUES ('A001', 'M001');
INSERT INTO 촬영 VALUES ('A002', 'M002');
INSERT INTO 촬영 VALUES ('A003', 'M003');
INSERT INTO 촬영 VALUES ('A004', 'M004');

INSERT INTO 캐스팅 VALUES ('B001', 'M004', '여주인공');
INSERT INTO 캐스팅 VALUES ('B002', 'M004', '여주인공');
INSERT INTO 캐스팅 VALUES ('B003', 'M003', '남주인공');
INSERT INTO 캐스팅 VALUES ('B004', 'M003', '여주인공');
INSERT INTO 캐스팅 VALUES ('B005', 'M002', '남주인공');
INSERT INTO 캐스팅 VALUES ('B006', 'M002', '여조연');
INSERT INTO 캐스팅 VALUES ('B007', 'M001', '남주인공');
INSERT INTO 캐스팅 VALUES ('B008', 'M001', '남주인공');

SELECT * FROM 감독;
SELECT * FROM 배우;
SELECT * FROM 영화;
SELECT * FROM 촬영;
SELECT * FROM 캐스팅;

SELECT 이름, 성별, 출생지 FROM 배우;
SELECT 제목, 제작국가, 상영시간, 제작사 FROM 영화 WHERE 제작년도 = 2020;
SELECT 제목, 제작국가, 상영시간, 제작사 FROM 영화 WHERE YEAR(CURDATE()) - 제작년도 <= 3;
SELECT 제목 FROM 영화 WHERE 영화코드번호 IN (	SELECT 영화코드번호 FROM 촬영 WHERE 등록번호 IN (SELECT 등록번호 FROM 감독 WHERE 이름='명감독'));

 /* 감독이 촬영한 영화코드번호 리스트 */
 SELECT 촬영.영화코드번호 FROM 촬영 INNER JOIN 감독 ON 촬영.등록번호 = 감독.등록번호;
 /* 그 영화코드번호에 해당하는 영화에 출연한 배우번호 */
 SELECT 캐스팅.배우번호 FROM 캐스팅
 JOIN (SELECT 촬영.영화코드번호 FROM 촬영 INNER JOIN 감독 ON 촬영.등록번호 = 감독.등록번호) 영화리스트
 ON 영화리스트.영화코드번호 = 캐스팅.영화코드번호;
 /* 그 배우번호에 해당하는 배우의 이름, 생년월일 */
 SELECT 배우.이름, 배우.생년월일 FROM 배우
 JOIN (
	SELECT 캐스팅.배우번호 FROM 캐스팅
    JOIN (SELECT 촬영.영화코드번호 FROM 촬영 INNER JOIN 감독 ON 촬영.등록번호 = 감독.등록번호) 영화리스트
	ON 영화리스트.영화코드번호 = 캐스팅.영화코드번호) AS 배우리스트
ON 배우리스트.배우번호 = 배우.배우번호;

SELECT 영화.제목, 영화.제작국가, 영화.상영시간 FROM 영화
INNER JOIN 감독
INNER JOIN 배우
INNER JOIN 촬영
INNER JOIN 캐스팅
ON 영화.영화코드번호 = 촬영.영화코드번호 AND
   촬영.등록번호 = 감독.등록번호 AND
   영화.영화코드번호 = 캐스팅.영화코드번호 AND
   캐스팅.배우번호 = 배우.배우번호 AND
   감독.이름 = 배우.이름 AND
   감독.생년월일 = 배우.생년월일;