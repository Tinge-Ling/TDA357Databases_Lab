# Tables 

CREATE TABLE Department(
	name			VARCHAR(100) NOT NULL,		
	abbreviation		VARCHAR(5),
	PRIMARY KEY(abbreviation),
	UNIQUE(name)
);

CREATE TABLE StudyProgramme(
	name			VARCHAR(80),
	abbreviation		VARCHAR(5)  NOT NULL,
	PRIMARY KEY(name)
);

CREATE TABLE Branch(
	spName		VARCHAR(100) REFERENCES StudyProgramme,
	name			VARCHAR(100),
	PRIMARY KEY(spName, name)
);

CREATE TABLE Course(
	courseName		VARCHAR(80)  NOT NULL,
creditPoints		REAL   NOT NULL,
code			CHAR(6),
departAbb		VARCHAR(5)	REFERENCES Department,
PRIMARY KEY(code),
CONSTRAINT ValidCreditPoints CHECK (creditPoints>0)
);

CREATE TABLE LimitedCourse(
	courseCode		CHAR(6)	REFERENCES Course,
maxParticipants	INT,
PRIMARY KEY(courseCode),
CONSTRAINT ValidParticipants CHECK(maxParticipants>0)

);

CREATE TABLE Student(
	name			VARCHAR(40)  NOT NULL,
	id			CHAR(10),			
	spName		VARCHAR(80)	REFERENCES StudyProgramme,
	PRIMARY KEY(id),
	UNIQUE(id,spname)
);

CREATE TABLE Classification(
name			VARCHAR(30),
PRIMARY KEY(name)
);

CREATE TABLE HostBy(
	dAbbreviation		VARCHAR(5) REFERENCES Department,
	spName		VARCHAR(80) REFERENCES StudyProgramme,
	PRIMARY KEY(dAbbreviation, spName)
);

CREATE TABLE HasBranch(
	studentID		CHAR(10) REFERENCES Student,
bName			VARCHAR(80),
bProgramme		VARCHAR(80),
	PRIMARY KEY(studentID),
	FOREIGN KEY(bName, bProgramme) REFERENCES Branch(name,spname),
	FOREIGN KEY(studentID, bProgramme) REFERENCES Student(id,spname)
);

CREATE TABLE IsMandatory(
	courseCode 		CHAR(6)	REFERENCES Course,
	spName		VARCHAR(80) REFERENCES StudyProgramme,
	PRIMARY KEY(courseCode, spName)
);

CREATE TABLE IsRecommended(
courseCode		CHAR(6)	REFERENCES Course,
bName			VARCHAR(80),
bProgramme		VARCHAR(80),
PRIMARY KEY(courseCode, bName, bProgramme),
	FOREIGN KEY(bProgramme,bName) REFERENCES Branch
);

CREATE TABLE IsAddMandatory(
courseCode		CHAR(6)	REFERENCES Course,
bName			VARCHAR(80),
bProgramme		VARCHAR(80),
PRIMARY KEY(courseCode,bProgramme,bName),
	FOREIGN KEY(bProgramme,bName) REFERENCES Branch
);

CREATE TABLE IsRegistered(
	courseCode		CHAR(6)	REFERENCES Course,
	studentID		CHAR(10) REFERENCES Student,
	PRIMARY KEY(courseCode, studentID)
);

CREATE TABLE HasCompleted(
grade			CHAR(1),
	courseCode		CHAR(10)	REFERENCES Course,
studentID		CHAR(10) REFERENCES Student,
PRIMARY KEY(courseCode, studentID),
CONSTRAINT ValidGrade CHECK(grade in('U','3','4','5'))
);

CREATE TABLE IsWaiting(
	sinceDate		TIMESTAMP,
	studentID		CHAR(10) REFERENCES Student,
	courseCode		CHAR(6)	REFERENCES LimitedCourse,
PRIMARY KEY(studentID, courseCode),
UNIQUE(sinceDate, courseCode)
);

CREATE TABLE HasClassification(
	courseCode		CHAR(6)	REFERENCES Course,
	className		VARCHAR(80)	REFERENCES Classification,
PRIMARY KEY(courseCode, className)
);


CREATE TABLE isprerequisite (
    coursecode character(6) REFERENCES Course,
    prereq character(6) REFERENCES Course,
   PRIMARY KEY (coursecode, prereq)
);


# Views


/* Department */

INSERT INTO department (name, abbreviation) VALUES ('Electronics, Computer Science, Information & Technology', 'EDIT');
INSERT INTO department (name, abbreviation) VALUES ('Architecture, Construction Engeering', 'AT');
INSERT INTO department (name, abbreviation) VALUES ('Chemistry AND Biomedical Engineering', 'KBME');
INSERT INTO department (name, abbreviation) VALUES ('Mechanical Engineering', 'ME');
INSERT INTO department (name, abbreviation) VALUES ('Industrial Engineering AND Economics', 'I');
INSERT INTO department (name, abbreviation) VALUES ('Marine', 'OC');
INSERT INTO department (name, abbreviation) VALUES ('Physics AND Mathematical Engineering', 'F');



/* Course */

INSERT INTO course (coursename, creditpoints, code, departabb) VALUES ('Mathematics1', 7.5, 'TDA123', 'AT');
INSERT INTO course (coursename, creditpoints, code, departabb) VALUES ('Mathematics Algebra', 7.5, 'TGF345', 'EDIT');
INSERT INTO course (coursename, creditpoints, code, departabb) VALUES ('Discret Mathematic', 7.5, 'ASD341', 'F');
INSERT INTO course (coursename, creditpoints, code, departabb) VALUES ('Sound 2', 7.5, 'TKG531', 'KBME');
INSERT INTO course (coursename, creditpoints, code, departabb) VALUES ('Linear Algebra', 7.5, 'TKD092', 'AT');
INSERT INTO course (coursename, creditpoints, code, departabb) VALUES ('Analysis', 7.5, 'MVA123', 'AT');
INSERT INTO course (coursename, creditpoints, code, departabb) VALUES ('Relation and IT', 7.5, 'MVE052', 'EDIT');
INSERT INTO course (coursename, creditpoints, code, departabb) VALUES ('Objective Programme', 7.5, 'MVV395', 'EDIT');
INSERT INTO course (coursename, creditpoints, code, departabb) VALUES ('Objective Programming 2', 7.5, 'MVY853', 'EDIT');
INSERT INTO course (coursename, creditpoints, code, departabb) VALUES ('Network 3', 3.5, 'KHU957', 'ME');
INSERT INTO course (coursename, creditpoints, code, departabb) VALUES ('Databases', 3.5, 'DTG678', 'ME');
INSERT INTO course (coursename, creditpoints, code, departabb) VALUES ('Databases and relation', 3.5, 'BAD431', 'OC');
INSERT INTO course (coursename, creditpoints, code, departabb) VALUES ('E-R diagram', 3.5, 'TLA124', 'OC');
INSERT INTO course (coursename, creditpoints, code, departabb) VALUES ('Datastructure', 3.5, 'MBD923', 'OC');
INSERT INTO course (coursename, creditpoints, code, departabb) VALUES ('Algoritmn', 3.5, 'TAS166', 'EDIT');
INSERT INTO course (coursename, creditpoints, code, departabb) VALUES ('Physics', 3.5, 'TOA194', 'F');
INSERT INTO course (coursename, creditpoints, code, departabb) VALUES ('Vibration', 3.5, 'VRT410', 'F');
INSERT INTO course (coursename, creditpoints, code, departabb) VALUES ('Economy A', 3.5, 'AIC692', 'F');
INSERT INTO course (coursename, creditpoints, code, departabb) VALUES ('English', 4, 'AKR245', 'I');
INSERT INTO course (coursename, creditpoints, code, departabb) VALUES ('Artificial Intelligence', 4, 'VMA581', 'I');
INSERT INTO course (coursename, creditpoints, code, departabb) VALUES ('Programming project', 4, 'JKN852', 'I');
INSERT INTO course (coursename, creditpoints, code, departabb) VALUES ('Sound1', 7.5, 'TKG431', 'KBME');
INSERT INTO course (coursename, creditpoints, code, departabb) VALUES ('Network 1', 7.5, 'KHU958', 'EDIT');
INSERT INTO course (coursename, creditpoints, code, departabb) VALUES ('Network 2', 7.5, 'KHU959', 'EDIT');
INSERT INTO course (coursename, creditpoints, code, departabb) VALUES ('English 2', 4, 'AKR246', 'F');
INSERT INTO course (coursename, creditpoints, code, departabb) VALUES ('Statistics', 7.5, 'AER682', 'I');



/* Classification */

INSERT INTO classification (name) VALUES ('Mathematics');
INSERT INTO classification (name) VALUES ('Research');
INSERT INTO classification (name) VALUES ('Physics');
INSERT INTO classification (name) VALUES ('Chemistry');
INSERT INTO classification (name) VALUES ('Environment');
INSERT INTO classification (name) VALUES ('Programming');
INSERT INTO classification (name) VALUES ('Music');
INSERT INTO classification (name) VALUES ('Art');
INSERT INTO classification (name) VALUES ('Biology');
INSERT INTO classification (name) VALUES ('Leadership');
INSERT INTO classification (name) VALUES ('Other');
INSERT INTO classification (name) VALUES ('Seminar');



/* StudyProgramme */

INSERT INTO studyprogramme (name, abbreviation) VALUES ('Information Technology', 'IT');
INSERT INTO studyprogramme (name, abbreviation) VALUES ('Computer Science', 'CS');
INSERT INTO studyprogramme (name, abbreviation) VALUES ('Physics Engineer', 'PE');
INSERT INTO studyprogramme (name, abbreviation) VALUES ('Architecture', 'A');
INSERT INTO studyprogramme (name, abbreviation) VALUES ('Society Technology', 'ST');
INSERT INTO studyprogramme (name, abbreviation) VALUES ('Industrial Technology', 'I');
INSERT INTO studyprogramme (name, abbreviation) VALUES ('Biotechnology', 'B');
INSERT INTO studyprogramme (name, abbreviation) VALUES ('Naval Commander', 'NC');
INSERT INTO studyprogramme (name, abbreviation) VALUES ('Mechanical', 'MT');
INSERT INTO studyprogramme (name, abbreviation) VALUES ('Mechatronics', 'M');
INSERT INTO studyprogramme (name, abbreviation) VALUES ('Chemistry Technology', 'C');
INSERT INTO studyprogramme (name, abbreviation) VALUES ('Electronics Engineering', 'E');
INSERT INTO studyprogramme (name, abbreviation) VALUES ('Marine', 'M');




/* Student */

INSERT INTO student (name, id, spname) VALUES ('TestTrigger2 case2 queuepos1', '2121212121', 'Mechanical');
INSERT INTO student (name, id, spname) VALUES ('TestTrigger2 case2 queuepos2', '1111122222', 'Biotechnology');
INSERT INTO student (name, id, spname) VALUES ('RasmusDavidsson', '9505182270', 'Information Technology');
INSERT INTO student (name, id, spname) VALUES ('Göran Svensson', '7601236413', 'Architecture');
INSERT INTO student (name, id, spname) VALUES ('Oscmage Evertsson', '9402287512', 'Industrial Technology');
INSERT INTO student (name, id, spname) VALUES ('Filip Pysen', '9306236412', 'Physics Engineer');
INSERT INTO student (name, id, spname) VALUES ('Saser Persson', '9409182432', 'Computer Science');
INSERT INTO student (name, id, spname) VALUES ('Jakob Holmus', '9910222231', 'Naval Commander');
INSERT INTO student (name, id, spname) VALUES ('Lovre Bergbom', '9104021896', 'Society Technology');
INSERT INTO student (name, id, spname) VALUES ('Vikky Bogren', '8903128301', 'Mechatronics');
INSERT INTO student (name, id, spname) VALUES ('Dumle Brånnsgård', '5407015273', 'Industrial Technology');
INSERT INTO student (name, id, spname) VALUES ('Tiny Mostafavi', '9602072717', 'Mechatronics');
INSERT INTO student (name, id, spname) VALUES ('Jaxxy Boy', '9411111121', 'Mechanical');
INSERT INTO student (name, id, spname) VALUES ('Bäski Bexxarsson', '9405051262', 'Electronics Engineering');
INSERT INTO student (name, id, spname) VALUES ('Rasmus Davidsson', '9505181337', 'Biotechnology');
INSERT INTO student (name, id, spname) VALUES ('Fishy Erlandsson', '9409214275', 'Naval Commander');
INSERT INTO student (name, id, spname) VALUES ('Aarne Ranta', '7801126312', 'Computer Science');
INSERT INTO student (name, id, spname) VALUES ('Tingy Liiing', '9402116421', 'Society Technology');
INSERT INTO student (name, id, spname) VALUES ('Maddy H', '9310052735', 'Architecture');
INSERT INTO student (name, id, spname) VALUES ('Bosse Ragnarsson', '8204206413', 'Marine');
INSERT INTO student (name, id, spname) VALUES ('Fishy', '9307126312', 'Computer Science');
INSERT INTO student (name, id, spname) VALUES ('Tino', '8512121212', 'Naval Commander');
INSERT INTO student (name, id, spname) VALUES ('TestTrigger1 allPrereq ', '3131313131', 'Society Technology');
INSERT INTO student (name, id, spname) VALUES ('TestTrigger1 raiseEx1', '1212121212', 'Naval Commander');
INSERT INTO student (name, id, spname) VALUES ('TestTrigger1 raiseEx2', '3232323232', 'Information Technology');
INSERT INTO student (name, id, spname) VALUES ('TestTrigger1 raiseEx3', '1313131313', 'Mechanical');
INSERT INTO student (name, id, spname) VALUES ('TestTrigger1 noPrereq', '4141414141', 'Architecture');
INSERT INTO student (name, id, spname) VALUES ('TestTrigger2 case2', '2222222222', 'Architecture');
INSERT INTO student (name, id, spname) VALUES ('TestTrigger2 case1', '1111111111', 'Physics Engineer');
INSERT INTO student (name, id, spname) VALUES ('TestTrigger2 case3', '3333333333', 'Marine');





/* LimitedCourse */

INSERT INTO limitedcourse (coursecode, maxparticipants) VALUES ('VRT410', 120);
INSERT INTO limitedcourse (coursecode, maxparticipants) VALUES ('AIC692', 30);
INSERT INTO limitedcourse (coursecode, maxparticipants) VALUES ('AKR245', 3);
INSERT INTO limitedcourse (coursecode, maxparticipants) VALUES ('VMA581', 15);
INSERT INTO limitedcourse (coursecode, maxparticipants) VALUES ('JKN852', 40);
INSERT INTO limitedcourse (coursecode, maxparticipants) VALUES ('AER682', 1);
INSERT INTO limitedcourse (coursecode, maxparticipants) VALUES ('MVV395', 5);



/* Branch */ 

INSERT INTO branch (spname, name) VALUES ('Information Technology', 'Interaction Design');
INSERT INTO branch (spname, name) VALUES ('Society Technology', 'Sound and Vibration');
INSERT INTO branch (spname, name) VALUES ('Society Technology', 'Design for Sustainable Development');
INSERT INTO branch (spname, name) VALUES ('Industrial Technology', 'Design for Sustainable Development');
INSERT INTO branch (spname, name) VALUES ('Industrial Technology', 'Product Development');
INSERT INTO branch (spname, name) VALUES ('Marine', 'Maritime Management');
INSERT INTO branch (spname, name) VALUES ('Naval Commander', 'Maritime Management');
INSERT INTO branch (spname, name) VALUES ('Physics Engineer', 'Nanotechnology');
INSERT INTO branch (spname, name) VALUES ('Physics Engineer', 'Applied Mechanics');
INSERT INTO branch (spname, name) VALUES ('Mechanical', 'Applied Mechanics');
INSERT INTO branch (spname, name) VALUES ('Mechanical', 'Automotive Engineering');
INSERT INTO branch (spname, name) VALUES ('Mechanical', 'Materials Engineering');
INSERT INTO branch (spname, name) VALUES ('Electronics Engineering', 'Sound and Vibration');
INSERT INTO branch (spname, name) VALUES ('Electronics Engineering', 'Embedded Electronic System Design');
INSERT INTO branch (spname, name) VALUES ('Information Technology', 'Entrepreneurship and Business Design');
INSERT INTO branch (spname, name) VALUES ('Computer Science', 'Software Engineering ');
INSERT INTO branch (spname, name) VALUES ('Computer Science', 'Computer Systems and Networks');
INSERT INTO branch (spname, name) VALUES ('Chemistry Technology', 'Biotechnology');
INSERT INTO branch (spname, name) VALUES ('Chemistry Technology', 'Industrial Ecology');
INSERT INTO branch (spname, name) VALUES ('Architecture', 'Architecture and Urban Design');
INSERT INTO branch (spname, name) VALUES ('Architecture', 'Design for Sustainable Development');
INSERT INTO branch (spname, name) VALUES ('Information Technology', 'CS, Algorithms, Language and Logic');



/* HasBranch */

INSERT INTO hasbranch (studentid, bname, bprogramme) VALUES ('9505182270', 'Interaction Design', 'Information Technology');
INSERT INTO hasbranch (studentid, bname, bprogramme) VALUES ('9411111121', 'Automotive Engineering', 'Mechanical');
INSERT INTO hasbranch (studentid, bname, bprogramme) VALUES ('9405051262', 'Sound and Vibration', 'Electronics Engineering');
INSERT INTO hasbranch (studentid, bname, bprogramme) VALUES ('9104021896', 'Sound and Vibration', 'Society Technology');
INSERT INTO hasbranch (studentid, bname, bprogramme) VALUES ('9310052735', 'Design for Sustainable Development', 'Architecture');
INSERT INTO hasbranch (studentid, bname, bprogramme) VALUES ('8512121212', 'Maritime Management', 'Naval Commander');



/* HasClassification */

INSERT INTO hasclassification (coursecode, classname) VALUES ('MVA123', 'Art');
INSERT INTO hasclassification (coursecode, classname) VALUES ('MVE052', 'Biology');
INSERT INTO hasclassification (coursecode, classname) VALUES ('KHU957', 'Chemistry');
INSERT INTO hasclassification (coursecode, classname) VALUES ('DTG678', 'Environment');
INSERT INTO hasclassification (coursecode, classname) VALUES ('BAD431', 'Art');
INSERT INTO hasclassification (coursecode, classname) VALUES ('TLA124', 'Environment');
INSERT INTO hasclassification (coursecode, classname) VALUES ('TOA194', 'Leadership');
INSERT INTO hasclassification (coursecode, classname) VALUES ('VRT410', 'Leadership');
INSERT INTO hasclassification (coursecode, classname) VALUES ('AER682', 'Music');
INSERT INTO hasclassification (coursecode, classname) VALUES ('JKN852', 'Music');
INSERT INTO hasclassification (coursecode, classname) VALUES ('TKD092', 'Physics');
INSERT INTO hasclassification (coursecode, classname) VALUES ('AKR245', 'Programming');
INSERT INTO hasclassification (coursecode, classname) VALUES ('VMA581', 'Programming');
INSERT INTO hasclassification (coursecode, classname) VALUES ('AER682', 'Research');
INSERT INTO hasclassification (coursecode, classname) VALUES ('JKN852', 'Research');
INSERT INTO hasclassification (coursecode, classname) VALUES ('TGF345', 'Mathematics');
INSERT INTO hasclassification (coursecode, classname) VALUES ('TKD092', 'Mathematics');
INSERT INTO hasclassification (coursecode, classname) VALUES ('MVV395', 'Seminar');
INSERT INTO hasclassification (coursecode, classname) VALUES ('MVY853', 'Seminar');
INSERT INTO hasclassification (coursecode, classname) VALUES ('TDA123', 'Seminar');
INSERT INTO hasclassification (coursecode, classname) VALUES ('TDA123', 'Mathematics');



/* HasCompleted */

INSERT INTO hascompleted (grade, coursecode, studentid) VALUES ('U', 'MVV395    ', '5407015273');
INSERT INTO hascompleted (grade, coursecode, studentid) VALUES ('U', 'TLA124    ', '7801126312');
INSERT INTO hascompleted (grade, coursecode, studentid) VALUES ('3', 'AKR245    ', '7801126312');
INSERT INTO hascompleted (grade, coursecode, studentid) VALUES ('3', 'TKG531    ', '7601236413');
INSERT INTO hascompleted (grade, coursecode, studentid) VALUES ('3', 'ASD341    ', '9104021896');
INSERT INTO hascompleted (grade, coursecode, studentid) VALUES ('3', 'KHU957    ', '9104021896');
INSERT INTO hascompleted (grade, coursecode, studentid) VALUES ('3', 'KHU957    ', '8903128301');
INSERT INTO hascompleted (grade, coursecode, studentid) VALUES ('4', 'DTG678    ', '8903128301');
INSERT INTO hascompleted (grade, coursecode, studentid) VALUES ('4', 'DTG678    ', '5407015273');
INSERT INTO hascompleted (grade, coursecode, studentid) VALUES ('4', 'BAD431    ', '9306236412');
INSERT INTO hascompleted (grade, coursecode, studentid) VALUES ('3', 'BAD431    ', '9910222231');
INSERT INTO hascompleted (grade, coursecode, studentid) VALUES ('3', 'VRT410    ', '9402287512');
INSERT INTO hascompleted (grade, coursecode, studentid) VALUES ('3', 'VRT410    ', '9306236412');
INSERT INTO hascompleted (grade, coursecode, studentid) VALUES ('4', 'BAD431    ', '5407015273');
INSERT INTO hascompleted (grade, coursecode, studentid) VALUES ('5', 'MVE052    ', '9602072717');
INSERT INTO hascompleted (grade, coursecode, studentid) VALUES ('5', 'MVE052    ', '9409182432');
INSERT INTO hascompleted (grade, coursecode, studentid) VALUES ('5', 'MVY853    ', '9411111121');
INSERT INTO hascompleted (grade, coursecode, studentid) VALUES ('5', 'TKD092    ', '9910222231');
INSERT INTO hascompleted (grade, coursecode, studentid) VALUES ('U', 'AKR245    ', '7601236413');
INSERT INTO hascompleted (grade, coursecode, studentid) VALUES ('U', 'AKR245    ', '8204206413');
INSERT INTO hascompleted (grade, coursecode, studentid) VALUES ('5', 'MVV395    ', '7601236413');
INSERT INTO hascompleted (grade, coursecode, studentid) VALUES ('U', 'MVV395    ', '9307126312');
INSERT INTO hascompleted (grade, coursecode, studentid) VALUES ('U', 'TOA194    ', '9310052735');
INSERT INTO hascompleted (grade, coursecode, studentid) VALUES ('5', 'TKD092    ', '9602072717');
INSERT INTO hascompleted (grade, coursecode, studentid) VALUES ('3', 'TDA123    ', '9910222231');
INSERT INTO hascompleted (grade, coursecode, studentid) VALUES ('4', 'TDA123    ', '9411111121');
INSERT INTO hascompleted (grade, coursecode, studentid) VALUES ('3', 'AER682    ', '9411111121');
INSERT INTO hascompleted (grade, coursecode, studentid) VALUES ('4', 'BAD431    ', '8512121212');
INSERT INTO hascompleted (grade, coursecode, studentid) VALUES ('5', 'TDA123    ', '8512121212');
INSERT INTO hascompleted (grade, coursecode, studentid) VALUES ('3', 'TGF345    ', '8512121212');
INSERT INTO hascompleted (grade, coursecode, studentid) VALUES ('3', 'TKD092    ', '8512121212');
INSERT INTO hascompleted (grade, coursecode, studentid) VALUES ('4', 'JKN852    ', '8512121212');
INSERT INTO hascompleted (grade, coursecode, studentid) VALUES ('3', 'AKR245    ', '8512121212');
INSERT INTO hascompleted (grade, coursecode, studentid) VALUES ('4', 'TDA123    ', '3131313131');
INSERT INTO hascompleted (grade, coursecode, studentid) VALUES ('3', 'MVY853    ', '3232323232');
INSERT INTO hascompleted (grade, coursecode, studentid) VALUES ('4', 'TKG531    ', '1313131313');
INSERT INTO hascompleted (grade, coursecode, studentid) VALUES ('3', 'TKG431    ', '1313131313');



/* HostBy */

INSERT INTO hostby (dabbreviation, spname) VALUES ('AT', 'Architecture');
INSERT INTO hostby (dabbreviation, spname) VALUES ('KBME', 'Biotechnology');
INSERT INTO hostby (dabbreviation, spname) VALUES ('KBME', 'Chemistry Technology');
INSERT INTO hostby (dabbreviation, spname) VALUES ('EDIT', 'Computer Science');
INSERT INTO hostby (dabbreviation, spname) VALUES ('EDIT', 'Electronics Engineering');
INSERT INTO hostby (dabbreviation, spname) VALUES ('I', 'Industrial Technology');
INSERT INTO hostby (dabbreviation, spname) VALUES ('OC', 'Marine');
INSERT INTO hostby (dabbreviation, spname) VALUES ('ME', 'Mechanical');
INSERT INTO hostby (dabbreviation, spname) VALUES ('ME', 'Mechatronics');
INSERT INTO hostby (dabbreviation, spname) VALUES ('OC', 'Naval Commander');
INSERT INTO hostby (dabbreviation, spname) VALUES ('F', 'Physics Engineer');
INSERT INTO hostby (dabbreviation, spname) VALUES ('AT', 'Society Technology');
INSERT INTO hostby (dabbreviation, spname) VALUES ('EDIT', 'Information Technology');




/* IsAddMandatory */

INSERT INTO isaddmandatory (coursecode, bprogramme, bname) VALUES ('MVE052', 'Electronics Engineering', 'Sound and Vibration');
INSERT INTO isaddmandatory (coursecode, bprogramme, bname) VALUES ('TDA123', 'Society Technology', 'Sound and Vibration');
INSERT INTO isaddmandatory (coursecode, bprogramme, bname) VALUES ('TOA194', 'Architecture', 'Design for Sustainable Development');
INSERT INTO isaddmandatory (coursecode, bprogramme, bname) VALUES ('MBD923', 'Chemistry Technology', 'Industrial Ecology');
INSERT INTO isaddmandatory (coursecode, bprogramme, bname) VALUES ('MVV395', 'Computer Science', 'Software Engineering ');
INSERT INTO isaddmandatory (coursecode, bprogramme, bname) VALUES ('MVV395', 'Information Technology', 'Entrepreneurship and Business Design');
INSERT INTO isaddmandatory (coursecode, bprogramme, bname) VALUES ('MVY853', 'Information Technology', 'Interaction Design');
INSERT INTO isaddmandatory (coursecode, bprogramme, bname) VALUES ('TAS166', 'Chemistry Technology', 'Biotechnology');
INSERT INTO isaddmandatory (coursecode, bprogramme, bname) VALUES ('TKG531', 'Mechanical', 'Applied Mechanics');
INSERT INTO isaddmandatory (coursecode, bprogramme, bname) VALUES ('TLA124', 'Society Technology', 'Design for Sustainable Development');
INSERT INTO isaddmandatory (coursecode, bprogramme, bname) VALUES ('DTG678', 'Mechanical', 'Applied Mechanics');
INSERT INTO isaddmandatory (coursecode, bprogramme, bname) VALUES ('BAD431', 'Marine', 'Maritime Management');
INSERT INTO isaddmandatory (coursecode, bprogramme, bname) VALUES ('TGF345', 'Electronics Engineering', 'Embedded Electronic System Design');
INSERT INTO isaddmandatory (coursecode, bprogramme, bname) VALUES ('ASD341', 'Mechanical', 'Automotive Engineering');
INSERT INTO isaddmandatory (coursecode, bprogramme, bname) VALUES ('TGF345', 'Mechanical', 'Materials Engineering');



/* IsMandatory */

INSERT INTO ismandatory (coursecode, spname) VALUES ('TKD092', 'Information Technology');
INSERT INTO ismandatory (coursecode, spname) VALUES ('TKD092', 'Industrial Technology');
INSERT INTO ismandatory (coursecode, spname) VALUES ('TKD092', 'Computer Science');
INSERT INTO ismandatory (coursecode, spname) VALUES ('MVV395', 'Information Technology');
INSERT INTO ismandatory (coursecode, spname) VALUES ('MVV395', 'Computer Science');
INSERT INTO ismandatory (coursecode, spname) VALUES ('MVY853', 'Information Technology');
INSERT INTO ismandatory (coursecode, spname) VALUES ('TAS166', 'Computer Science');
INSERT INTO ismandatory (coursecode, spname) VALUES ('AKR245', 'Society Technology');
INSERT INTO ismandatory (coursecode, spname) VALUES ('AKR245', 'Marine');
INSERT INTO ismandatory (coursecode, spname) VALUES ('AKR245', 'Architecture');
INSERT INTO ismandatory (coursecode, spname) VALUES ('AKR245', 'Naval Commander');
INSERT INTO ismandatory (coursecode, spname) VALUES ('JKN852', 'Computer Science');
INSERT INTO ismandatory (coursecode, spname) VALUES ('JKN852', 'Electronics Engineering');
INSERT INTO ismandatory (coursecode, spname) VALUES ('TOA194', 'Physics Engineer');
INSERT INTO ismandatory (coursecode, spname) VALUES ('MVV395', 'Architecture');
INSERT INTO ismandatory (coursecode, spname) VALUES ('JKN852', 'Mechatronics');



/* IsPrerequisite */

INSERT INTO isprerequisite (coursecode, prereq) VALUES ('MVV395', 'MVY853');
INSERT INTO isprerequisite (coursecode, prereq) VALUES ('TKG431', 'TKG531');
INSERT INTO isprerequisite (coursecode, prereq) VALUES ('DTG678', 'BAD431');
INSERT INTO isprerequisite (coursecode, prereq) VALUES ('MBD923', 'TAS166');
INSERT INTO isprerequisite (coursecode, prereq) VALUES ('KHU958', 'KHU959');
INSERT INTO isprerequisite (coursecode, prereq) VALUES ('KHU959', 'KHU957');
INSERT INTO isprerequisite (coursecode, prereq) VALUES ('TOA194', 'VMA581');
INSERT INTO isprerequisite (coursecode, prereq) VALUES ('AKR246', 'AKR245');
INSERT INTO isprerequisite (coursecode, prereq) VALUES ('AER682', 'TDA123');

/* IsRecommended */

INSERT INTO isrecommended (coursecode, bprogramme, bname) VALUES ('AER682', 'Marine', 'Maritime Management');
INSERT INTO isrecommended (coursecode, bprogramme, bname) VALUES ('MVV395', 'Marine', 'Maritime Management');
INSERT INTO isrecommended (coursecode, bprogramme, bname) VALUES ('AER682', 'Architecture', 'Architecture and Urban Design');
INSERT INTO isrecommended (coursecode, bprogramme, bname) VALUES ('MVV395', 'Information Technology', 'Entrepreneurship and Business Design');
INSERT INTO isrecommended (coursecode, bprogramme, bname) VALUES ('MVV395', 'Computer Science', 'Computer Systems and Networks');
INSERT INTO isrecommended (coursecode, bprogramme, bname) VALUES ('MVY853', 'Computer Science', 'Computer Systems and Networks');
INSERT INTO isrecommended (coursecode, bprogramme, bname) VALUES ('JKN852', 'Computer Science', 'Software Engineering ');
INSERT INTO isrecommended (coursecode, bprogramme, bname) VALUES ('TKG431', 'Mechanical', 'Automotive Engineering');
INSERT INTO isrecommended (coursecode, bprogramme, bname) VALUES ('AER682', 'Physics Engineer', 'Applied Mechanics');
INSERT INTO isrecommended (coursecode, bprogramme, bname) VALUES ('AKR245', 'Architecture', 'Design for Sustainable Development');
INSERT INTO isrecommended (coursecode, bprogramme, bname) VALUES ('MVA123', 'Physics Engineer', 'Nanotechnology');
INSERT INTO isrecommended (coursecode, bprogramme, bname) VALUES ('TDA123', 'Architecture', 'Architecture and Urban Design');



/* IsRegistered */

INSERT INTO isregistered (coursecode, studentid) VALUES ('AER682', '5407015273');
INSERT INTO isregistered (coursecode, studentid) VALUES ('AIC692', '7601236413');
INSERT INTO isregistered (coursecode, studentid) VALUES ('AKR245', '7801126312');
INSERT INTO isregistered (coursecode, studentid) VALUES ('ASD341', '8903128301');
INSERT INTO isregistered (coursecode, studentid) VALUES ('BAD431', '9104021896');
INSERT INTO isregistered (coursecode, studentid) VALUES ('DTG678', '9306236412');
INSERT INTO isregistered (coursecode, studentid) VALUES ('JKN852', '9402287512');
INSERT INTO isregistered (coursecode, studentid) VALUES ('KHU957', '9405051262');
INSERT INTO isregistered (coursecode, studentid) VALUES ('MBD923', '9409182432');
INSERT INTO isregistered (coursecode, studentid) VALUES ('MVA123', '9409214275');
INSERT INTO isregistered (coursecode, studentid) VALUES ('MVE052', '9411111121');
INSERT INTO isregistered (coursecode, studentid) VALUES ('MVV395', '9505181337');
INSERT INTO isregistered (coursecode, studentid) VALUES ('TDA123', '9505182270');
INSERT INTO isregistered (coursecode, studentid) VALUES ('TDA123', '9602072717');
INSERT INTO isregistered (coursecode, studentid) VALUES ('TDA123', '9910222231');
INSERT INTO isregistered (coursecode, studentid) VALUES ('TAS166', '9505182270');
INSERT INTO isregistered (coursecode, studentid) VALUES ('AIC692', '8512121212');
INSERT INTO isregistered (coursecode, studentid) VALUES ('MVV395', '3232323232');
INSERT INTO isregistered (coursecode, studentid) VALUES ('AIC692', '4141414141');
INSERT INTO isregistered (coursecode, studentid) VALUES ('VRT410', '8903128301');



/* IsWaiting */

INSERT INTO iswaiting (sincedate, studentid, coursecode) VALUES ('2012-01-24', '9411111121', 'AER682');
INSERT INTO iswaiting (sincedate, studentid, coursecode) VALUES ('2015-10-13', '9402287512', 'AER682');
INSERT INTO iswaiting (sincedate, studentid, coursecode) VALUES ('2014-04-28', '9409182432', 'AER682');
INSERT INTO iswaiting (sincedate, studentid, coursecode) VALUES ('2015-10-12', '9310052735', 'AER682');
INSERT INTO iswaiting (sincedate, studentid, coursecode) VALUES ('2016-01-06', '5407015273', 'AER682');
INSERT INTO iswaiting (sincedate, studentid, coursecode) VALUES ('2013-08-26', '7601236413', 'JKN852');
INSERT INTO iswaiting (sincedate, studentid, coursecode) VALUES ('2014-12-28', '9505181337', 'VMA581');
INSERT INTO iswaiting (sincedate, studentid, coursecode) VALUES ('2015-02-28', '8903128301', 'VRT410');
INSERT INTO iswaiting (sincedate, studentid, coursecode) VALUES ('2015-08-07', '9602072717', 'VMA581');







/* StudentsFollowing */

CREATE VIEW studentsfollowing AS
SELECT student.id, student.name, student.spname, hasbranch.bname FROM (student 
	-- add the branch of the student to the view by using left join. Left join allows adding student who yet have no branch 
	LEFT JOIN hasbranch ON ((student.id = hasbranch.studentid)));



/* FinishedCourses */ 

CREATE VIEW finishedcourses AS
SELECT student.name, hascompleted.grade, hascompleted.coursecode, course.creditpoints, student.id FROM ((hascompleted 
	-- "left join student" gives the student id 
	LEFT JOIN student ON ((student.id = hascompleted.studentid)))
	-- joining course gives us the course code
	 JOIN course ON ((hascompleted.coursecode = course.code)));



/* Registrations */

CREATE VIEW registrations AS
SELECT isregistered.coursecode, isregistered.studentid, 'registered' AS status FROM isregistered 
	-- union iswaiting-table and isregistered-table add the students from isgregistered-table and iswaiting to the view
	UNION SELECT iswaiting.coursecode, iswaiting.studentid, 'waiting' AS status FROM iswaiting;



/* PassedCourses */

--get the data from finishedcourses besides the one with grade U
CREATE VIEW passedcourses AS
SELECT finishedcourses.name, finishedcourses.grade, finishedcourses.coursecode, finishedcourses.creditpoints, finishedcourses.id FROM finishedcourses WHERE (finishedcourses.grade <> 'U');



/* UnReadMandatory */

CREATE VIEW unreadmandatory AS
SELECT student.id, student.name, student.spname, hasbranch.bname, ismandatory.coursecode, hascompleted.grade 
	
	-- get students id and mandatory programme
	FROM ((((student JOIN ismandatory ON (((student.spname) = (ismandatory.spname))))
	
		--join course so we get the courses that are mandatory for both branch and the studyprogramme 
			JOIN course ON ((ismandatory.coursecode = course.code))) LEFT JOIN hasbranch ON ((student.id = hasbranch.studentid))) 

	-- left join hascompleted so we only get programme mandatory courses that are not passed
	LEFT JOIN hascompleted ON (((student.id = hascompleted.studentid) AND (ismandatory.coursecode = hascompleted.coursecode)))) WHERE ((hascompleted.grade IS NULL) OR (hascompleted.grade = 'U')) 

	-- union allows us to get branch mandatory courses as well. Do the same things as above queries
	UNION SELECT student.id, student.name, hasbranch.bprogramme AS spname, hasbranch.bname, course.code AS coursecode, hascompleted.grade 

		FROM ((((student JOIN hasbranch ON ((student.id = hasbranch.studentid))) JOIN isaddmandatory ON ((((isaddmandatory.bname) = (hasbranch.bname)) AND ((isaddmandatory.bprogramme) = (hasbranch.bprogramme))))) JOIN course ON ((course.code = isaddmandatory.coursecode))) 

		-- left join hascompleted so we only get branch mandatory courses that are not passed
		LEFT JOIN hascompleted ON (((hasbranch.studentid = hascompleted.studentid) AND (isaddmandatory.coursecode = hascompleted.coursecode)))) WHERE ((hascompleted.grade IS NULL) OR (hascompleted.grade = 'U'));



/* PathToGraduation */

CREATE VIEW pathtograduation AS
SELECT p.id, p.name, COALESCE(cred.totalcreditpoints, (0)) AS totalcreditpoints, COALESCE(unman.unpassed_mandatory, (0)) AS unreadmandatorycourses, COALESCE(mathpoints.math_credits, (0)) AS mathcredits, COALESCE(respoints.res_credits, (0)) AS researchcredits, COALESCE(sem.nbrseminar, (0)) AS nbrofseminar, 
	
	-- Checks if a student is qualified to graduate
	CASE 
		WHEN (((((unman.unpassed_mandatory IS NULL) AND (mathpoints.math_credits >= (20))) AND (respoints.res_credits >= (10))) AND (sem.nbrseminar >= 1)) AND (recomcred.recompoints >= (10))) THEN 'yes' ELSE 'no' END AS isqualifiedtograduate 


	FROM ((((((studentsfollowing p 
		-- get total credit points for the student
		NATURAL LEFT JOIN (SELECT passedcourses.id, sum(passedcourses.creditpoints) AS totalcreditpoints FROM passedcourses GROUP BY passedcourses.id) cred) 
		
		-- get the number of unread mandatory  courses
		NATURAL LEFT JOIN (SELECT unreadmandatory.id, count(unreadmandatory.coursecode) AS unpassed_mandatory FROM unreadmandatory GROUP BY unreadmandatory.id) unman) 

		-- get the total credit points of mathematical courses
		NATURAL LEFT JOIN (SELECT pc.id, sum(pc.creditpoints) AS math_credits FROM (passedcourses pc JOIN hasclassification hc ON ((pc.coursecode = hc.coursecode))) WHERE ((hc.classname) = 'Mathematics') GROUP BY pc.id) mathpoints) 
		
		-- get the total credit points of research courses
		NATURAL LEFT JOIN (SELECT pc.id, sum(pc.creditpoints) AS res_credits FROM (passedcourses pc JOIN hasclassification hc ON ((pc.coursecode = hc.coursecode))) WHERE ((hc.classname) = 'Research') GROUP BY pc.id) respoints) 
		
		-- get the total credit points of seminar courses
		NATURAL LEFT JOIN (SELECT pc.id, count(pc.coursecode) AS nbrseminar FROM (passedcourses pc JOIN hasclassification hc ON ((pc.coursecode = hc.coursecode))) WHERE ((hc.classname) = 'Seminar') GROUP BY pc.id) sem) 
		
		-- its for checking if a student is qualified to graduate. This doesn't display in the view.
		NATURAL LEFT JOIN (SELECT pc.id, sum(pc.creditpoints) AS recompoints FROM (passedcourses pc JOIN isrecommended ir ON ((pc.coursecode = ir.coursecode))) GROUP BY pc.id) recomcred);


/* Course Queue Positions */
CREATE OR REPLACE VIEW coursequeuepositions AS
SELECT sincedate, studentid, coursecode, ROW_NUMBER() OVER (PARTITION BY coursecode ORDER BY sincedate) AS POSITION
FROM isWaiting


