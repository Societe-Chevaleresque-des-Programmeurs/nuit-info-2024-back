#------------------------------------------------------------
#        Script MySQL.
#------------------------------------------------------------


#------------------------------------------------------------
# Table: Users
#------------------------------------------------------------

CREATE TABLE Users(
        login    Varchar (50) NOT NULL ,
        password Char (50) NOT NULL
	,CONSTRAINT Users_PK PRIMARY KEY (login)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Questions
#------------------------------------------------------------

CREATE TABLE Questions(
        idQuestion Int  Auto_increment  NOT NULL ,
        text       Varchar (50) NOT NULL
	,CONSTRAINT Questions_PK PRIMARY KEY (idQuestion)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Answers
#------------------------------------------------------------

CREATE TABLE Answers(
        idAnswer   Int  Auto_increment  NOT NULL ,
        text       Varchar (50) NOT NULL ,
        isCorrect  Bool NOT NULL ,
        idQuestion Int NOT NULL
	,CONSTRAINT Answers_PK PRIMARY KEY (idAnswer)

	,CONSTRAINT Answers_Questions_FK FOREIGN KEY (idQuestion) REFERENCES Questions(idQuestion)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: users_answers
#------------------------------------------------------------

CREATE TABLE users_answers(
        idAnswer Int NOT NULL ,
        login    Varchar (50) NOT NULL
	,CONSTRAINT users_answers_PK PRIMARY KEY (idAnswer,login)

	,CONSTRAINT users_answers_Answers_FK FOREIGN KEY (idAnswer) REFERENCES Answers(idAnswer)
	,CONSTRAINT users_answers_Users0_FK FOREIGN KEY (login) REFERENCES Users(login)
)ENGINE=InnoDB;

