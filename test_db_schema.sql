
CREATE TABLE Appointment (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_name VARCHAR(100),
    appointment_date DATE,
    department VARCHAR(50),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);



--1

create table patient(
patient_id int primary key,
name varchar(100) not null,
gender varchar(10),
date_of_birth Date,
contact_number varchar(15) 
);


-- 2
Alter table appointment add column status varchar(20);

--3
INSERT INTO patient (patient_id, name, gender, date_of_birth, contact_number)
VALUES
    (1, 'rahul', 'Male', '1985-07-12', '9398788998'),
    (2, 'kirtu', 'Female', '1990-03-22', '7368273839'),
    (3, 'frerro', 'Female', '1978-11-02', '738377383'),
    (4, 'raghav', 'Male', '1995-02-14', '647484944'),
    (5, 'bhoomi', 'Male', '1982-09-25', '647484994');

INSERT INTO Appointment (appointment_id, patient_id, doctor_name, appointment_date, department, status)
VALUES
    (1, 1, 'Dr. monica', '2025-05-01', 'Cardiology', 'Scheduled'),
    (2, 2, 'Dr. rethika', '2025-05-02', 'Dermatology', 'Completed'),
    (3, 3, 'Dr. willom', '2025-05-03', 'Neurology', 'Scheduled'),
    (4, 4, 'Dr. blora', '2025-05-04', 'Orthopedics', 'Cancelled'),
    (5, 5, 'Dr. strange', '2025-05-05', 'Pediatrics', 'Completed');


--4
update Appointment set department='Neurology' where appointment_id=2;

--5

alter table Appointment drop constraint appointment_patient_id_fkey;
alter table Appointment add constraint appointment_patient_id_fkey foreign key(patient_id) references patient(patient_id) on delete set null;
delete from patient where name='kirtu';

--6
select p.name,a.appointment_date,a.doctor_name from patient p left join appointment a on p.patient_id=a.patient_id;

--7
select p.*,a.department from patient p left join appointment a on p.patient_id=a.patient_id where a.department='Cardiology';

--8
select p.*,a.doctor_name from patient p join appointment a on p.patient_id=a.patient_id where a.doctor_name='Dr. blora';

--9
select a.*,p.date_of_birth from patient p join appointment a on p.patient_id=a.patient_id where p.date_of_birth<'1964-04-15';

--10   (data changed)
select p.* from patient p join appointment a on p.patient_id=a.patient_id group by p.patient_id having count(a.patient_id)>1;

--11
select * from patient where patient_id in (select patient_id from appointment group by patient_id order by count(patient_id) desc limit 1)

--12
select p.* from patient p where not exists(select 1 from appointment a WHERE a.patient_id = p.patient_id)

--13
SELECT name,(SELECT DATE_PART('year', CURRENT_DATE) - DATE_PART('year', p.date_of_birth)) AS age FROM patient p;

--14
select * from appointment where appointment_date between '2025-04-04' and '2025-05-04';

--15
select department,count(appointment_id) as appointment_number from appointment group by department;


--1
INSERT INTO Appointment (appointment_id, patient_id, doctor_name, appointment_date, department, status)
VALUES
    (6, 5, 'Dr. monica', '2025-05-04', 'Cardiology', 'Scheduled'),
	(7, 5, 'Dr. monica', '2025-05-05', 'Orthopedics', 'Scheduled');

select p.patient_id,p.name from patient p join appointment a on a.patient_id=p.patient_id group by p.patient_id,p.name HAVING COUNT(DISTINCT a.department) = (
SELECT COUNT(DISTINCT department) FROM appointment);

--2
select * from patient where patient_id in(
select patient_id from appointment where doctor_name='Dr. monica' order by appointment_date limit 1);

--3
select doctor_name,department from appointment group by doctor_name,department having count(distinct(patient_id))>2 and count(distinct(department))>1;

--4

--5
select p.name,count(a.patient_id) as app_count from patient p join appointment a on p.patient_id=a.patient_id group by p.name order by app_count desc limit 3;

--6



select * from patient;
select * from Appointment;