create database capstone_2;
Use capstone_2;
 
 select * from covid_data  ;
 
-- Find the number of corona patients who faced shortness of breath.
with corona as (select * from covid_data where Corona='positive')
select * from corona where Shortness_of_breath = 'True' order by Ind_ID;

-- Find the number of negative corona patients who have fever and sore_throat. 
with corona as (select * from covid_data where Corona='negative')
select * from corona where Sore_throat = 'True' and Fever='True';

-- Group the data by month and rank the number of positive cases.
with corona as (select * from covid_data having Corona = 'positive'),
corona1 as (select month(test_date) as test_month ,count(*) as no_of_cases from covid_data group by test_month order by test_month) 
select *,Rank() over(order by no_of_cases desc) as rank_of_months from corona1;

-- Find the female negative corona patients who faced cough and headache.
with corona as ( select * from covid_data where Sex='Female'and Corona='negative')
select * from corona where Cough_symptoms ='True' and Headache='True'; 

-- How many elderly corona patients have faced breathing problems?
with corona as ( select * from covid_data where Age_60_above = 'yes' and Corona='positive')
select * from corona where Shortness_of_breath= 'True' ;

-- Which three symptoms were more common among COVID positive patients?
with corona as (select * from covid_data where corona = 'positive'),
fever_tb as (select fever, count(*) as fever_count from corona group by fever),
cough_tb as (select cough_symptoms, count(*) as cough_count from corona group by cough_symptoms),
sore_tb as (select sore_throat, count(*) as sore_count from corona group by sore_throat),
breath_tb as (select shortness_of_breath, count(*) as breath_count from corona group by shortness_of_breath),
ache_tb as (select headache, count(*) as ache_count from corona group by headache),
final_tb as (select A.fever as true_false , A.fever_count,B.cough_count,C.sore_count,D.breath_count,e.ache_count from fever_tb as a inner join cough_tb as b on a.fever = b.cough_symptoms inner join 
sore_tb as c on b.cough_symptoms = c.sore_throat inner join breath_tb as d on c.sore_throat = d.shortness_of_breath inner join ache_tb as e on d.shortness_of_breath = e.headache)
select * from final_tb where true_false = 'True';


-- Which symptom was less common among COVID negative people?
with corona as (select * from covid_data where corona = 'negative'),
fever_tb as (select fever, count(*) as fever_count from corona group by fever),
cough_tb as (select cough_symptoms, count(*) as cough_count from corona group by cough_symptoms),
sore_tb as (select sore_throat, count(*) as sore_count from corona group by sore_throat),
breath_tb as (select shortness_of_breath, count(*) as breath_count from corona group by shortness_of_breath),
ache_tb as (select headache, count(*) as ache_count from corona group by headache),
final_tb as (select A.fever as true_false , A.fever_count,B.cough_count,C.sore_count,D.breath_count,e.ache_count from fever_tb as a inner join cough_tb as b on a.fever = b.cough_symptoms inner join 
sore_tb as c on b.cough_symptoms = c.sore_throat inner join breath_tb as d on c.sore_throat = d.shortness_of_breath inner join ache_tb as e on d.shortness_of_breath = e.headache)
select * from final_tb where true_false = 'True';

-- What are the most common symptoms among COVID positive males whose known contact was abroad? 
with corona as (select * from covid_data where corona = 'positive' and sex = 'male' and Known_contact='abroad'),
fever_tb as (select fever, count(*) as fever_count from corona group by fever),
cough_tb as (select cough_symptoms, count(*) as cough_count from corona group by cough_symptoms),
sore_tb as (select sore_throat, count(*) as sore_count from corona group by sore_throat),
breath_tb as (select shortness_of_breath, count(*) as breath_count from corona group by shortness_of_breath),
ache_tb as (select headache, count(*) as ache_count from corona group by headache),
final_tb as (select A.fever as true_false , A.fever_count,B.cough_count,C.sore_count,D.breath_count,e.ache_count from fever_tb as a inner join cough_tb as b on a.fever = b.cough_symptoms inner join 
sore_tb as c on b.cough_symptoms = c.sore_throat inner join breath_tb as d on c.sore_throat = d.shortness_of_breath inner join ache_tb as e on d.shortness_of_breath = e.headache)
select * from final_tb where true_false = 'True';

