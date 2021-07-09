Create table Gender(
	id int primary key identity,
	name varchar(32) not null,

	constraint UniqueGenderName unique(name)
);

Create table Users(
	id int primary key identity,
	email varchar(128) not null unique,
	photoid int unique,
	name varchar(64) not null,
	dob date not null,
	idGender int not null,
	password char(128) not null, --SHA512 returns *always* a 128 char hash

	constraint UniqueUserEmail unique(email),
	constraint UniqueUserPhoto unique (photoid),
	constraint FK_Users_idGender Foreign Key(idGender) references Gender(id)
);

Create table UserTokens(
	id int primary key identity,
	idUser int not null,
	token char(128) not null,
	issuedOn datetime,

	constraint FK_UserTokens_idUser Foreign Key(idUser) references Users(id) on delete cascade
);

Create table ApplicationMasterCategory(
	id int primary key identity,
	name varchar(64) not null,
	constraint UniqueAplicationMasterCategoryName unique(name)
);

Create table AplicationCategory
(
	id int primary key identity,
	MasterCategoryID int not null,
	name varchar(64) not null,

	constraint FK_AplicationCategory_MasterCategoryID Foreign Key(MasterCategoryID) references ApplicationMasterCategory(id),
	constraint UniqueAplicationCategoryName unique(name,MasterCategoryID)
);

Create table Developer(
	id int primary key identity,
	idUser int not null,
	devName varchar(64) not null,
	secEmail varchar(128) null,
	phoneNum varchar(64) not null,
	
	CreatedOn datetime not null default sysdatetime(), --ReadOnly

	constraint FK_Developer_idUser Foreign Key(idUser) references Users(id),
	constraint UniqueDeveloperPerUser unique(idUser)
);

Create table Aplication(
	id int primary key identity,
	idDeveloper int not null,
	name varchar(128) not null,
	nameinstore varchar(64) not null,
	minsdkversion int not null,
	applicationSize decimal,

	constraint UniqueAplicationName unique(name)
);

Create table AppPhotoType(
	id int primary key identity,
	name varchar(32) not null,

	constraint UniqueAppPhotoTypeName unique(name)
);

Create table ApplicationPhotos(
	id int primary key identity,
	idApp int not null,
	photoType int not null,
	PhotoPath varchar(64),

	constraint UniquePhotoPath unique(PhotoPath),
	constraint FK_ApplicationPhotos_idApp Foreign Key(idApp) references Aplication(id),
	constraint FK_ApplicationPhotos_PhotoType Foreign Key(photoType) references AppPhotoType(id)
);

Create table UserLibrary
(
	id int primary key identity,
	idUser int not null,
	idApp int not null,

	constraint FK_UserLibrary_idUser foreign key(idUser) references Users(id),
	constraint FK_UserLibrary_idApp foreign key(idApp) references Aplication(id),

	constraint Unique_UserLibrary_UserApp unique(idUser,idApp)
);

Insert into Gender values('Male'),('Female'),('Other');
Insert into AppPhotoType values('App-Icon'),('Banner'),('Phone Screenshot'),('Tablet Screenshot');