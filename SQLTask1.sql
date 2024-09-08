create table Classes(
[Id] int primary key identity(1,1),
[Name] nvarchar(100),

)

create table Students(
[Id] int primary key identity(1,1),
[Name] nvarchar(100),
[Surname] nvarchar(100),
[Address] nvarchar(100),
[Email] nvarchar(100) unique,
[Age] int,
[Birthday] datetime,
[ClassId] int,
[CityId] int,
foreign key (ClassId) references Classes(Id),

foreign key (CityId) references Cities(Id)
)

create table Teachers(
[Id] int primary key identity(1,1),
[FullName] nvarchar(100),
[Salary] nvarchar(100),
[Age] int,

)

alter table Teachers
add  Email nvarchar(100);
select * from Teachers

update Teachers
set Email='nihat@gmail.com'
where Id=1;

update Teachers
set Email='nuri@gmail.com'
where Id=2;

update Teachers
set Email='xeyal@gmail.com'
where Id=3;

update Teachers
set Email='elcin@gmail.com'
where Id=4;

create table TeacherClasses(
[Id] int primary key identity(1,1),
[TeacherId] int,
[ClassId] int,
foreign key (ClassId) references Classes(Id),
foreign key (TeacherId) references Teachers(Id)
)

create table Subjects(
[Id] int primary key identity(1,1),
[Name] nvarchar(100)
)
create table ClassSubjects(
[Id] int primary key identity(1,1),
[ClassId] int,
[SubjectId] int,
foreign key (ClassId) references Classes(Id),
foreign key (SubjectId) references Subjects(Id)
)

create table Rooms(
[Id] int primary key identity(1,1),
[Name] nvarchar(100)
)

create table RoomClasses(
[Id] int primary key identity(1,1),
[RoomId] int,
foreign key (RoomId) references Rooms(Id),
[ClassId] int,
foreign key (ClassId) references Classes(Id)
)

create table StaffMembers(
[Id] int primary key identity(1,1),
[FullName] nvarchar(100),
[Salary] int,
[CityId] int,
foreign key (CityId) references Cities(Id)

)
create table Roles(
[Id] int primary key identity(1,1),
[Name] nvarchar(100)
)

create table MemberRoles(
[Id] int primary key identity(1,1),
[StaffMemberId] int,
[RoleId] int,
foreign key (StaffMemberId) references StaffMembers(Id),
foreign key (RoleId) references Roles(Id)
)

create table Countries(
[Id] int primary key identity(1,1),
[Name] nvarchar(100)
)

create table Cities(
[Id] int primary key identity(1,1),
[Name] nvarchar(100),
[CountryId] int,
foreign key (CountryId) references Countries(Id)
)

insert into Students([Name],[Surname],[Address],[Email],[Age],[Birthday],[ClassId],[CityId])
values('Nihat','Eliyev','Ecemi','nihat@gmail.com',17,'2007-12-12',1,1),
('Fatime','Eliyeva','20 yanvar','fatime@gmail.com',16,'2008-10-09',3,3),
('Sadiq','Kerimli','Nesimi','sadiq@gmail.com',17,'2007-03-08',4,2),
('Royal','Ramazanov','Nesimi','royal@gmail.com',15,'2010-02-02',2,2),
('Emin','Kazimov','Moskva','emin@gmail.com',17,'2007-04-19',1,4)


insert into Countries([Name])
values('Azerbaycan'),
('Turkiye'),
('Rusiya')

insert into Cities([Name],[CountryId])
values('Baki',1),
('Oghuz',1),
('Seki',1),
('Moskva',3),
('Istanbul',2)
insert into Rooms([Name])
values('Sinig otagi'),
('Idman zali'),
('Kimya otagi')

insert into Classes([Name])
values('11a'),
('10b'),
('8a'),
('7b')

insert into Subjects([Name])
values('Riyaziyyat'),
('Fizika'),
('Kimya'),
('Informatika')

insert into Teachers([FullName],[Salary],[Age])
values('Nihat Camiyev',1500,25),
('Nuri Vahabov',1200,23),
('Xeyal Ramazanov',2000,29),
('Elcin Memmedov',1000,33)

insert into TeacherClasses([ClassId],[TeacherId])
values(1,1),
(2,3),
(3,4),
(4,2)

insert into RoomClasses([ClassId],[RoomId])
values(1,2),
(2,3),
(3,4),
(4,1)

insert into StaffMembers([FullName],[Salary],[CityId])
values('Emin Memmedov',1000,1),
('Ayxan Mahmudlu',1200,2),
('Namiq Namiqov',800,3)

insert into Roles([Name])
values('Direktor'),
('Zavuc'),
('Xadime')

insert into MemberRoles([RoleId],[StaffMemberId])
values(1,2),
(2,1),
(3,3)


--1) Telebelerin ve muellimlerin orta yashlarinin hasilini tapin.
create function fn_StudentsAndTeachersAverageAgeProduct()
returns int
begin 
declare @student int=(select Avg(Age) from Students)
declare @teacher int =(select Avg(Age) from Teachers)

return @student * @teacher
end

select dbo.fn_StudentsAndTeachersAverageAgeProduct()

--2) Bakidan qiraqda yashayan telebelerin sayini tapin.

create function fn_CountWithoutBakuu()
returns int
begin
declare @result int=(select COUNT(*) from Students where CityId>1)
return @result
end

select dbo.fn_CountWithoutBakuu()

select * from Students

--3) Butun telebe ve muellimlerin yashlarinin cemini tapin.

create function fn_StudentsAndTeachersAgeSum()
returns int
begin
declare @studentAge int=(select SUM(Age) from Students)
declare @teacherAge int =(select SUM(Age) from Teachers)
declare @result int=@studentAge+@teacherAge
return @result
end

select dbo. fn_StudentsAndTeachersAgeSum()

--4) Telebeleri Adini,Soyadini,Email-ni,Age-ni, Yashadigi seheri, Olkeni, onlarin oxudugu sinifi,
--tedris kecdiyi otagi birlikde gosteren bir view yazin.

create view vw_StudentInfos
as 
select std.Name,std.Surname,std.Address,std.Age,std.Email,ct.Name as 'City',co.Name as 'Country',cl.Name as 'Class'  from Students std
inner join Cities ct
on std.CityId=ct.Id
join Classes cl
on std.ClassId=cl.Id
inner join Countries co
on ct.CountryId=co.Id

select * from vw_StudentInfos

--5) Sinifleri fennleri ile birlikde gosteren view yazin.

create view vw_ClassSubjects
as
select cl.Name as 'Class',rm.Name as 'Room' from Classes cl
inner join RoomClasses rc
on cl.Id=rc.ClassId
join Rooms rm
on rm.Id=rc.RoomId

select * from  vw_ClassSubjects

--6) Telebeler ucun parametr olaraq serchText qebul eden search function yazin. (Name ve surname-e gore)

create function fn_Search2(@searchText nvarchar(100))
returns table 
as
return select * from Students where Name=@searchText

select * from Students
select * from fn_Search2('Nihat')

--7) Mektebin daxili ishcilerini rollari ile birlikde gosterin.

create view vw_ShowMembersRollers
as
select sfm.FullName ,rl.Name as 'Role' from StaffMembers sfm
inner join MemberRoles mr
on sfm.Id=mr.StaffMemberId
join Roles rl
on rl.Id=mr.RoleId

select * from vw_ShowMembersRollers

--8) Telebeler ucun age qebul eden function yazin. Function yashi gelen age-den ashagi olan telebelerin sayini qaytarsin.

create function fn_GetCountByAge(@age int)
returns int
begin 
declare @result int=(select COUNT(*) from Students where [Age]>@age)
return @result
end

select dbo.fn_GetCountByAge(15)

--9) Bazaya telebele elave eden procedure yazin.
create procedure usp_CreateStudent2
@name nvarchar(100),
@surname nvarchar(100),
@address nvarchar(100),
@email nvarchar(100),
@age int,
@birthDay datetime,
@classId int,
@cityId int



as
insert into Students([Name],[Surname],[Address],[Email],[Age],[Birthday],[ClassId],[CityId])
values(@name,@surname,@address,@email,@age,@birthDay,@classId,@cityId)

exec usp_CreateStudent 'Eli','Eliyev','Nerimanov','eli@gmail.com',14,null,1,2

select * from Students

--10) Muellimin datalarini bazadan silen procedure yazin.(SoftDelete ile)

alter table Teachers
add SoftDeleted bit not null
default 0
with values

create procedure usp_SoftDeleteteacherById
@id int
as
update Teachers
set SoftDeleted=1
where [Id]=@id

exec usp_SoftDeleteteacherById 4

select * from Teachers
select * from Teachers where [SoftDeleted]='true'

--11) Function yazirsiz. Function TeacherId qebul edecek. 
--Hemin function, Muellimi functiona gelen id-li muellime beraber olan telebelerin butun datalarini ve muelliminin adini qaytarsin.

create function fn_GetAllStudentsByTeacherId(@id int)
returns table
as 

return
select std.*,tc.FullName from Teachers tc
inner join TeacherClasses tcl
on tc.Id=tcl.TeacherId
join Classes cl
on cl.Id=tcl.ClassId
join Students std
on std.ClassId=cl.Id
where tc.Id=@id

select * from dbo.fn_GetAllStudentsByTeacherId(2)

--12) Telebeler ucun function yazirsiz.
--Dogum tarixi functiona gelen tarixler arasinda olan telebelerin sayini hemin function qaytarsin.

create function fn_GetStudentsByBirthday(@fromDate datetime,@toDate datetime)
returns table
as
return select * from Students where Birthday between @fromDate and @toDate

select * from dbo.fn_GetStudentsByBirthday('2000-10-10','2007-10-10')
select * from Students

--13) StaffMembers ucun function yazirsiz.
--Function Maashi functiona gelen 2 maash araliginda olan member-lerin maashlarinin cemini qaytarsin.

create function fn_StaffMembersSalarySum(@fromSalary int,@toSalary int)
returns int
begin
declare @result int=(select Sum([Salary]) from StaffMembers where Salary between @fromSalary and @toSalary)
return @result
end

select dbo.fn_StaffMembersSalarySum(500,1100)

select * from StaffMembers

--14) Muellimler ucun Procedure yazirsiz.
--Procedure muellimin Id-sine gore maashini deyise bilsin. Id procedura parametr olaraq gelecek.

create procedure usp_AlterSalaryById
@id int,
@newSalary int
as
update Teachers
set Salary=@newSalary
where [Id]=@id

exec usp_AlterSalaryById 1,1600
select * from Teachers

--15) Function yazirsiz.
--Function 2 parametr qebul edir, Hemin function yashlari hemin araqlinda olan butun muellimlerin, telebelerin sayini qaytarsin.

create function fn_CountTeacherAndStudentAgeBetweenAge(@fromAge int,@toAge int)
returns int
begin
declare @studentAge int=(select Count(Age) from Students where Age between @fromAge and @toAge)
declare @teacherAge int=(select Count(Age) from Teachers where Age between @fromAge and @toAge)

return @studentAge+@teacherAge

end

select dbo.fn_CountTeacherAndStudentAgeBetweenAge(14,30)

select * from Teachers
select * from Students

--16) Muellimler ucun function yazirsiz.
--Function emaili hemin functiona gelen parametrle bashlayan muellimlerin yash ortalamasini qaytarsin.

create function fn_AverageTeacherBySearchText(@searchText nvarchar(100))
returns int
begin
 declare @result int=(select AVG([Age]) from Teachers where Email like @searchText + '%')
 return @result
end

select dbo.fn_AverageTeacherBySearchText('n');

--17) View yaradirsiz. Viewda StaffMember-ler, Onlarin yashadigi olke ve sheher gorunmelidir.

create view vw_StaffMembers
as
select sm.*,ct.Name as 'City',co.Name as 'Country' from StaffMembers sm
inner join Cities ct
on sm.CityId=ct.Id
join Countries co
on ct.CountryId=co.Id

select * from vw_StaffMembers

--18) Telebeler table-dan en boyuk yash ile muellimler table-dan en kicik yashi tapib onlarin hasilini geri qaytaran function yazin.

create function fn_SumOfMaxStudentAgeAndMinTeacherAge()
returns int
begin
declare @maxStudentAge int=(select Max([Age]) from Students)
declare @minTeacherAge int=(select Min([Age]) from Teachers)
return @maxStudentAge * @minTeacherAge
end

select dbo.fn_SumOfMaxStudentAgeAndMinTeacherAge()