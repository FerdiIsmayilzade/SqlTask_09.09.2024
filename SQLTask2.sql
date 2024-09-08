create table Brands(
[Id] int primary key identity(1,1),
[Name] nvarchar(100),
[PriceID] int,
[TransmitterId] int,
foreign key (PriceId) references Prices(Id),
foreign key (TransmitterId) references Transmitters(Id)
)

create table Models(
[Id] int primary key identity(1,1),
[Name] nvarchar(100),
[BrandId] int,
foreign key (BrandId) references Brands(Id),
[GearId] int,
foreign key (GearId) references Gears(Id),
[YearId] int,
foreign key (YearId) references Years(Id),
[EngineId] int,
foreign key (EngineId) references Engines(Id),
[CarCountryId] int,
foreign key (CarCountryId) references CarCountries(Id),
[PictureId] int,
foreign key (PictureId) references Pictures(Id)
)

create table Prices(
[Id] int primary key identity(1,1),
[Value] int,
[CurrencyId] int,
foreign key (CurrencyId) references Currency(Id)
)

create table Currency(
[Id] int primary key identity(1,1),
[Type] nvarchar(100)
)

create table Transmitters(
[Id] int primary key identity(1,1),
[Name] nvarchar(100)
)

create table Situations(
[Id] int primary key identity(1,1),
[Name] nvarchar(100)
)

create table BrandSituations(
[Id] int primary key identity(1,1),
[BrandId] int,
[SituationId] int,
foreign key (BrandId) references Brands(Id),
foreign key (SituationId) references Situations(Id)
)
create table Fuels(
[Id] int primary key identity(1,1),
[Name] nvarchar(100)
)

create table BrandFuels(
[Id] int primary key identity(1,1),
[BrandId] int,
[FuelId] int,
foreign key (BrandId) references Brands(Id),
foreign key (FuelId) references Fuels(Id)
)

create table Owners(
[Id] int primary key identity(1,1),
[Number] int,
[CityId] int,
foreign key (CityId) references Cities(Id)
)

create table BrandOwners(
[Id] int primary key identity(1,1),
[BrandId] int,
[OwnerId] int,
foreign key (BrandId) references Brands(Id),
foreign key (OwnerId) references Owners(Id)
) 

create table Cities(
[Id] int primary key identity(1,1),
[Name] nvarchar(100)
)

create table Colors(
[Id] int primary key identity(1,1),
[Name] nvarchar(100)
)

create table BrandColors(
[Id] int primary key identity(1,1),
[BrandId] int,
[ColorId] int,
foreign key (BrandId) references Brands(Id),
foreign key (ColorId) references Colors(Id)
)

create table Gears(
[Id] int primary key identity(1,1),
[Name] nvarchar(100)
)

create table Years(
[Id] int primary key identity(1,1),
[Year] datetime
)

create table Engines(
[Id] int primary key identity(1,1),
[Strong] int
)

create table CarCountries(
[Id] int primary key identity(1,1),
[Name] nvarchar(100)
)

create table Seats(
[Id] int primary key identity(1,1),
[Count] int
)

create table ModelSeats(
[Id] int primary key identity(1,1),
[ModelId] int,
[SeatId] int,
foreign key (ModelId) references Models(Id),
foreign key (SeatId) references Seats(Id)
)

create table Bans(
[Id] int primary key identity(1,1),
[Name] nvarchar(100)
)

create table ModelBans(
[Id] int primary key identity(1,1),
[ModelId] int,
[BanId] int,
foreign key (ModelId) references Models(Id),
foreign key (BanId) references Bans(Id)
)
 create table Pictures(
 [Id] int primary key identity(1,1),
 [Picture] varbinary(Max)
 )

 

 select * from Brands
 select * from Models
 select * from Prices
 select * from Currency
 select * from Transmitters
 select * from Situations
 select * from BrandSituations
 select * from Fuels
 select * from BrandFuels
 select * from Colors
 select * from BrandColors
 select * from Cities
 select * from BrandOwners
 select * from Gears
 select * from Years
 select * from Engines
 select * from CarCountries
 select * from Seats
 select * from ModelSeats
 select * from Bans
 select * from ModelBans
 select * from Pictures