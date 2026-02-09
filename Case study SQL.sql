use mystery ;

select*from crime_scene ; -- Date, Type, Description, City 

select*from drivers_license ;	 -- Id, Age, Height, Eye_Color, Hair_Color, Gender, Plate_Number, Car_Make, Car_Model

select*from gym_check_in ; -- Membership_Id, Check_In_Date, Check_In_Time, Check_Out_Time 

select*from gym_members ; -- Id, Person_Id, Name, Membership_Start_Date, Membership_Status 

select*from person  ; -- Id, Name, License_Id, Address_Number, Address_Street_Name 

-- 1) Show all people records
SELECT * FROM person ;   
           
-- 2) Find all crime scenes in a omaha city
SELECT *from crime_scene
WHERE city ="omaha";  

-- 3) List all active gym members
SELECT *FROM gym_members
WHERE membership_status ="active";

-- 4) Get people who own a car
SELECT 
    p.name, d.car_make, d.car_model
FROM
    person p
        JOIN
    drivers_license d ON p.license_id = d.id;
    
-- 5) Count total crime incidents  
SELECT COUNT(*) AS total_crimes
FROM crime_scene ;     

-- 6) Find members who checked in on a specific date
SELECT 
    m.name, c.check_in_date
FROM
    gym_members m
        JOIN
    gym_check_in c ON m.id = c.membership_id
WHERE
    c.check_in_date = '2018-01-09';
    
-- 7) Find people older than 40
SELECT 
    p.name, d.age
FROM
    person p
        JOIN
    drivers_license d ON p.license_id = d.id
WHERE
    D.age > 40;
    
-- 8) Show crimes ordered by date
SELECT *FROM crime_scene
ORDER BY DATE DESC ;

-- 9) find gym members who visit frequently
	SELECT 
    m.Name, COUNT(c.Check_In_Date) AS Total_Visits
FROM
    gym_members m
        JOIN
    gym_check_in c ON m.Id = c.Membership_Id
GROUP BY m.Name
HAVING COUNT(c.check_in_date) > 5;

-- 10) Find people with matching car plate numbers  
SELECT 
    p.name, d.plate_number
FROM
    person p
        JOIN
    drivers_license d ON p.license_id = d.id
WHERE
    d.plate_number LIKE '%H24%';
    

-- 11) Find people who never visited the gym
SELECT 
    name
FROM
    gym_members
WHERE
    id NOT IN (SELECT 
            membership_id
        FROM
            gym_check_in);
            
  -- 12) Find people who never visited the gym
 SELECT 
    m.Name
FROM
    gym_members m
        LEFT JOIN
    gym_check_in c ON m.Id = c.Membership_Id
WHERE
    c.Membership_Id IS NULL;
    
 -- 13) Find the most common crime type
SELECT 
    Type, COUNT(*) AS Crime_Count
FROM
    crime_scene
GROUP BY Type
ORDER BY Crime_Count DESC
LIMIT 1;

-- 14) Find cities with more than 2 crime
SELECT 
    City, COUNT(*) AS Total_Crimes
FROM
    crime_scene
GROUP BY City
HAVING COUNT(*) > 2;

-- 15) Find people who own a car and are gym members
SELECT DISTINCT
    p.Name
FROM
    person p
        JOIN
    drivers_license d ON p.License_Id = d.Id
        JOIN
    gym_members m ON p.Id = m.Person_Id;
    
-- 16) Find people living on the same street
SELECT 
    Address_Street_Name, COUNT(*) AS People_Count
FROM
    person
GROUP BY Address_Street_Name
HAVING COUNT(*) > 1;