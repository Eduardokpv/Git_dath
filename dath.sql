drop database if exists dath;
create database if not exists dath character set = utf8mb4 COLLATE utf8mb4_unicode_ci;
use dath;

#Usuario/Médico/Convênio
create table Convenio(
	id int auto_increment not null,
    tipo enum('Empresarial', 'Pessoal', 'Coletivo'),
    contratada varchar(30),
    primary key(id)
);

insert into Convenio values
	(null, 'Pessoal','Unimed');

CREATE TABLE Usuario (
    id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    email VARCHAR(70) UNIQUE NOT NULL,
    senha VARCHAR(70) NOT NULL,
    tel CHAR(13) NOT NULL,
    CPF CHAR(14) UNIQUE NOT NULL,
    nasc DATE NOT NULL,
    tipo_s ENUM('A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-') NOT NULL,
    sexo ENUM('Masculino', 'Feminino') NOT NULL,
    id_convenio int,
    constraint fk_ConvenioUsuario foreign key(id_convenio) references Convenio(id)
);

create table Medico(
	id int not null auto_increment,
    nome varchar(50) not null,
    crm int not null,
    primary key(id)
);

insert into Medico values
	(null, 'Aline Fernanda', 2701),
	(null, 'Denis Campos', 7498),
	(null, 'Evelyn Pedrosa', 6492);

create table MedicoConvenio(
	id_medico int not null,
    id_convenio int not null,
    constraint fk_MedicoConvenio foreign key(id_medico) references Medico(id),
    constraint fk_ConvenioMedico foreign key(id_convenio) references Convenio(id)
);

insert into MedicoConvenio values
	(1, 1),
	(3, 1);

#Endereço
create table Pais(
	id int auto_increment not null,
    nome char(2),
    primary key(id)
);

insert into Pais values
	(null, 'BR');

create table Estado(
	id int auto_increment not null,
    nome char(2),
    id_pais int not null,
	primary key(id),
    constraint fk_PaisEstado foreign key(id_pais) references Pais(id)
);

insert into Estado values
	(null, 'SP', 1);

create table Cidade(
	id int auto_increment not null auto_increment,
    nome varchar(60),
    id_estado int not null,
    constraint fk_EstadoCidade foreign key(id_estado) references Estado(id),
    primary key(id)
);

insert into Cidade values
	(null, 'Caraguatatuba', 1);

create table Rua(
	id int auto_increment not null auto_increment,
    nome varchar(60) not null,
    primary key(id)
);

insert into Rua values
	(null, 'Av. Miguel Varlez'),
	(null, 'Av. Anchieta'),
	(null, 'Av. Rio Grande do Sul'),
    (null, 'Rua Indaiá'),
    (null, 'Av. Pres. Castelo Branco'),
    (null, 'Av. Maranhão');

create table Endereco(
	id int auto_increment not null auto_increment,
	id_pais int not null,
    id_Estado int not null,
    id_cidade int not null,
    id_rua int not null,
    num_predio int not null,
    cep int not null,
    primary key(id),
    constraint fk_PaisEndereco foreign key(id_pais) references Pais(id),
    constraint fk_EstadoEndereco foreign key(id_estado) references Estado(id),
    constraint fk_CidadeEndereco foreign key(id_cidade) references Cidade(id),
    constraint fk_RuaEndereco foreign key(id_rua) references Rua(id)
);

insert into Endereco values
	(null, 1, 1, 1, 1, 980, 11660650),
	(null, 1, 1, 1, 2, 215, 11660010),
	(null, 1, 1, 1, 3, 1750, 11665030),
    (null, 1, 1, 1, 4, 854, 11675050),
    (null, 1, 1, 1, 5, 349, 11661200),
    (null, 1, 1, 1, 6, 219, 11660660);
#Hospital    
create table Hospital (
	id int auto_increment not null auto_increment,
    nome varchar(50) not null,
    id_endereco int not null,
    primary key(id),
    constraint fk_EnderecoHospital foreign key(id_endereco) references Endereco(id)
);

insert into Hospital values
	(null, 'Casa de Saúde Stella Maris', 1),
	(null, 'Hospital de Olhos e Clínicas - HOC', 2),
	(null, 'Santa Casa', 1),
	(null, 'Hospital Santos Dumont', 3),
    (null, 'AME Caraguatatuba', 4),
    (null, 'Centro Médico São Camilo', 5),
    (null, 'Madre Tereza - CEAMI', 6);

create table HospitalConvenio(
	id_hospital int not null,
    id_convenio int not null,
    constraint fk_HospitalConvenio foreign key(id_hospital) references Hospital(id),
    constraint fk_ConvenioHospital foreign key(id_convenio) references Convenio(id)
);

#Exa/Con
create table Exacon (
	id int auto_increment not null auto_increment,
	id_hospital int not null,
    id_medico int not null,
    horario DATETIME NOT NULL,
	id_usuario int,
    primary key(id),
    constraint fk_UsuarioExacon foreign key(id_usuario) references Usuario(id),
    constraint fk_HospitalExacon foreign key(id_hospital) references Hospital(id),
    constraint fk_MedicoExacon foreign key(id_medico) references Medico(id)
);

create table Exa(
	id int not null auto_increment,
	id_exacon int not null,
    tipo varchar(100) not null,
    primary key(id),
    constraint fk_ExaCon foreign key(id_exacon) references Exacon(id)
);