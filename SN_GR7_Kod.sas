/*CZĘŚĆ I*/
 
/*Tu należy wpisać ścieżkę do folderu nadrzędnego do folderu z danymi i zakończyć ukośnikiem*/
%let sciezka = /home/u61547178/sasuser.v94/projekt/;
 
/*Eksport tabelek z "Rezultatów" do excela:*/
ODS TAGSETS.EXCELXP
file="&sciezka.tabele.xls"
STYLE=minimal
OPTIONS ( Orientation = 'landscape'
FitToPage = 'yes'
Pages_FitWidth = '1'
Pages_FitHeight = '100' );
 
 
/*Ustawianie ścieżki do biblioteki*/
LIBNAME PROJ "&sciezka";
 
/*Zapisywanie znaczenia (opisów) poszczególnych odpowiedzi*/
PROC FORMAT;
  value NWSPOL
      7777 = 'Refusal' .b = 'Refusal'  
      8888 = 'Don''t know' .c = 'Don''t know'  
      9999 = 'No answer' .d = 'No answer' ;
value HAPPY
      0 = 'Extremely unhappy'  
      1 = '1'  
      2 = '2'  
      3 = '3'  
      4 = '4'  
      5 = '5'  
      6 = '6'  
      7 = '7'  
      8 = '8'  
      9 = '9'  
      10 = 'Extremely happy'  
      77 = 'Refusal' .b = 'Refusal'  
      88 = 'Don''t know' .c = 'Don''t know'  
      99 = 'No answer' .d = 'No answer' ;
value SCLMEET
      1 = 'Never'  
      2 = 'Less than once a month'  
      3 = 'Once a month'  
      4 = 'Several times a month'  
      5 = 'Once a week'  
      6 = 'Several times a week'  
      7 = 'Every day'  
      77 = 'Refusal' .b = 'Refusal'  
      88 = 'Don''t know' .c = 'Don''t know'  
      99 = 'No answer' .d = 'No answer' ;
value HEALTH
      1 = 'Very good'  
      2 = 'Good'  
      3 = 'Fair'  
      4 = 'Bad'  
      5 = 'Very bad'  
      7 = 'Refusal' .b = 'Refusal'  
      8 = 'Don''t know' .c = 'Don''t know'  
      9 = 'No answer' .d = 'No answer' ;
value RLGBLG
      1 = 'Yes'  
      2 = 'No'  
      7 = 'Refusal' .b = 'Refusal'  
      8 = 'Don''t know' .c = 'Don''t know'  
      9 = 'No answer' .d = 'No answer' ;
value BLGETMG
      1 = 'Yes'  
      2 = 'No'  
      7 = 'Refusal' .b = 'Refusal'  
      8 = 'Don''t know' .c = 'Don''t know'  
      9 = 'No answer' .d = 'No answer' ;
value EVMAR
      1 = 'Yes'  
      2 = 'No'  
      7 = 'Refusal' .b = 'Refusal'  
      9 = 'No answer' .d = 'No answer' ;
value BTHCLD
      1 = 'Yes'  
      2 = 'No'  
      7 = 'Refusal' .b = 'Refusal'  
      8 = 'Don''t know' .c = 'Don''t know'  
      9 = 'No answer' .d = 'No answer' ;
value NBTHCLD
      66 = 'Not applicable' .a = 'Not applicable'  
      77 = 'Refusal' .b = 'Refusal'  
      88 = 'Don''t know' .c = 'Don''t know'  
      99 = 'No answer' .d = 'No answer' ;
value GNDR
      1 = 'Male'  
      2 = 'Female'  
      9 = 'No answer' .d = 'No answer' ;
value AGEA
      999 = 'Not available' .d = 'Not available' ;
value EDUYRS
      77 = 'Refusal' .b = 'Refusal'  
      88 = 'Don''t know' .c = 'Don''t know'  
      99 = 'No answer' .d = 'No answer' ;
value UEMP3M
      1 = 'Yes'  
      2 = 'No'  
      7 = 'Refusal' .b = 'Refusal'  
      8 = 'Don''t know' .c = 'Don''t know'  
      9 = 'No answer' .d = 'No answer' ;
value NETINUM
      666666666 = 'Not applicable' .a = 'Not applicable'  
      777777777 = 'Refusal' .b = 'Refusal'  
      888888888 = 'Don''t know' .c = 'Don''t know'  
      999999999 = 'No answer' .d = 'No answer' ;
run;
 
/*Przypisywanie odpowiednich formatów zmiennym*/
data PROJ.OPISY;
set PROJ.ESS9PT;
FORMAT
       nwspol NWSPOL.
       happy HAPPY.
   sclmeet SCLMEET.
       health HEALTH.
       rlgblg RLGBLG.
       blgetmg BLGETMG.
       evmar EVMAR.
       bthcld BTHCLD.
       nbthcld NBTHCLD.
       gndr GNDR.
       agea AGEA.
       eduyrs EDUYRS.
       uemp3m UEMP3M.
       netinum NETINUM.
;
/*Oznaczanie brakujących wartości*/
 
array n _numeric_;
array c _character_;
do over n;
if prxmatch("/Not .p+lic+able/", vvalue(n)) then n=.a ;
if prxmatch("/Refus../", vvalue(n)) then n=.b ;
if prxmatch("/Don.?t .now/", vvalue(n)) then n=.c ;
if prxmatch("/(No .nswer)|(Not .vailable)/", vvalue(n)) then n=.d ;
end;
do over c;
if prxmatch("/(Not .p+lic+able)|(Refus..)|(Don.?t .now)|(No .nswer)|(Not .vailable)/",vvalue(c)) then c="   ";
end;
run;
 
 
data PROJ.OPISY1;
set PROJ.OPISY
/*Wybór zmiennych*/
(keep=happy nwspol sclmeet health  
blgetmg evmar eduyrs uemp3m bthcld nbthcld
netinum gndr rlgblg agea);
 
/*Dodawanie opisów zmiennych*/
 
Label
happy='Taking all things together, how happy would you say you are?'
       
    nwspol ='On a typical day, about how much time (minutes)do you spend watching, reading or listening to news about politics and current affairs?'
 
sclmeet='How often do you meet socially with friends, relatives or work colleagues?'
 
health='How is your health in general?'
 
    rlgblg='Do you consider yourself as belonging to any particular religion or denomination?'

blgetmg='Do you belong to a minority ethnic group in [country]?'
 
nbthcld='How many children have you ever given birth to/fathered?'

evmar='Are you or have you ever been married?'
 
eduyrs='About how many years of education have you completed, whether full-time or parttime?'

netinum='What is your usual weekly/monthly/annual net pay after tax and compulsory deductions?'
 
gndr='Gender'
 
agea='Age of respondent'
 
uemp3m = 'Have you ever been unemployed and seeking work for a period of more than three
months?'
 
bthcld = 'Have you ever given birth to/ fathered a child?'

;
 
/*Dodanie zmiennych opisujących czy nie brakuje danych dla poszczególnej zmiennej*/
 
 
m_happy=missing(happy);
m_bthcld=missing(bthcld);
m_nwspol=missing(nwspol); 
m_sclmeet=missing(sclmeet);
m_health=missing(health);
m_blgetmg=missing(blgetmg); 
m_evmar=missing(evmar); 
m_eduyrs=missing(eduyrs); 
m_netinum=missing(netinum); 
m_gndr=missing(gndr);  
m_rlgblg=missing(rlgblg);
m_agea=missing(agea);
run;
 
/*Tworzenie zmiennej child mówiącej o tym ile dzieci ma respondent (jeżeli nie ma wtedy 0, a nie N/A tak jak było w początkowym zbiorze)*/
data proj.opisy2;
set proj.opisy1;
if (bthcld=1 or m_nbthcld=1) then child=nbthcld; else child=0;
run;
 
/*Tworzenie makrozmiennej zawierającej wszystkie zmienne niezależne (oraz bthcld potrzebnej do wykresu)*/
%let zmienne= nwspol sclmeet health  
blgetmg evmar eduyrs agea uemp3m
netinum gndr  rlgblg bthcld child ;
run;
 
/*Wybór zbioru danych zawierających wyłącznie komplet danych (każdy rekord zawiera dane)*/
data proj.dane;
set proj.opisy2;
keep &zmienne. happy;
where (m_nwspol=0 and 
m_sclmeet=0 and 
m_health=0 and 
m_blgetmg=0 and
m_evmar=0 and
m_eduyrs=0 and 
m_netinum=0 and
m_gndr=0 and
m_rlgblg=0 and
m_happy=0 and
m_agea=0);
run;
 
 
/*Podstawowe statystyki dla każdej ze zmiennych*/
proc means data=proj.dane
n
mean
median
min
max
stderr
lclm
uclm
alpha=0.05;
output out=stat_opisowe;
run;
 
 
 
/*Dychotomizacja zmiennej happy na podstaawie średniej oraz zmiana kodowania zmiennych zero-jedynkowych*/
 
data proj.dane1;
set proj.dane;
rlgblg = (rlgblg-2)*-1;
blgetmg = (blgetmg-2)*-1;
evmar = (evmar-2)*-1;
gndr = (gndr-2)*-1;
bthcld = (bthcld-2)*-1;
if happy<8 then do; 
is_happy=0;
end;
else do; 
is_happy=1;
end;
run;
 
/*Poprawienie formatu zmiennej zdychotomizowanej oraz opisów zmiennych*/
DATA PROJ.DANE1;
SET PROJ.DANE1;
FORMAT is_happy ISHAPPY.;
label is_happy ='Dichotomized happy variable (ARE you happy?)'
  child = 'How many children have you ever given birth to/fathered?';
run;
 
/*Poprawianie opisu znaczenia odpowiedzi dla zmiennych zero-jedynkowych po zmianie kodowania oraz dla zdychotomizowanej zmiennej happy*/
proc format;
value RLGBLG
      1 = 'Yes'  
      0 = 'No';
  value BLGETMG
      1 = 'Yes'  
      0 = 'No';
  value EVMAR
      1 = 'Yes'  
      0 = 'No';
  value GNDR
      1 = 'Male'  
      0 = 'Female';
  value BTHCLD
      1 = 'Yes'  
      0 = 'No';
  value IS_HAPPY
      1 = 'Yes'  
      0 = 'No';
run;
 
/*Podstawowe statystyki dla końcowego zbioru*/
proc means data=proj.DANE1
n
mean
median
min
max
stderr
lclm
uclm
alpha=0.05;
output out=stat_opisowe1;
run;
 
 
 
 
/*KOD CZ. 2*/
 
/*Odrzucenie zmiennej happy przed dychotomizacją*/
data data (drop=happy);
set proj.dane1;
run;
 
/* Kategoryzacja */ 
 
/*Pierwszy rzut oka na dane/statystyki zawarte w tabeli*/
proc  freq data=data; run;
 
proc means data=data; run;
 
/*Stworzenie zbioru pod kategoryzację*/
data data_kat;
set data;
run;
 
/*Statystyki dla zmiennej objaśnianej*/
proc freq data=data;
tables is_happy/out=happy_freq;
run;
 
proc sgplot data=happy_freq;
  vbar is_happy/ response=percent
      datalabel;
run;
 
/* .............................................................. */
 
******** Zmienna AGE;
 
*Podstawowe statystyki i histogram;
PROC means data=data mean stddev min max skewness kurtosis median mode q1 q3;
var agea; run;
 
proc univariate data=data;
var agea;
histogram / kernel;
run;
 
/* .............................................................. */
 
******** Zmienna NWSPOL;
 
*Podstawowe statystyki i histogram;
PROC means data=data mean stddev min max skewness kurtosis median q1 q3;
var nwspol; run;
 
proc sgplot data=data;
histogram nwspol;
run;
 
*Histogram co minutę;
proc freq data=data;
tables nwspol/out=nwspol_freq;
run;
 
proc sgplot data=nwspol_freq;
  vbar nwspol/ response=percent;
  xaxis grid values=(1 to 200 by 1) fitpolicy=staggerthin;
run;
 
*Kategoryzacja;
data data_kat; 
set data_kat;
if nwspol<=30 then nwspol=1;
if 30<nwspol<=60 then nwspol=2;
if nwspol>60 then nwspol=3;
run;
 
*Zmiana labeli po kategoryzacji;
proc format;
value nwspol
1 = '30 minutes or less'
2 = '30 to 60 minutes'
3 = 'More than 60 minutes';
run;
 
*Tablica kontyngencji i wykres słupkowy po kategoryzacji;
proc freq data=data_kat;
tables is_happy*nwspol /   out=happy_nwspol;
run;
 
proc sgplot data=happy_nwspol;
vbar nwspol/response=percent group=is_happy seglabel;
run;
 
/* .............................................................. */
 
********** Zmienna EDUYRS;
 
*Podstawowe statystyki i histogram;
PROC means data=data mean stddev min max skewness kurtosis median q1 q3;
var eduyrs; run;
 
proc sgplot data=data;
histogram eduyrs;
run;
 
*Empiryczny logit;
 
proc rank data=data groups=50 out=ranks;
var eduyrs;
ranks bin;
run;
 
proc means data=ranks noprint nway;
class bin;
var is_happy eduyrs;
output out=bins sum(is_happy)=is_happy mean(eduyrs)=eduyrs n(is_happy)=cases;
run;
 
data bins;
set bins;
logit=log((is_happy+.5)/(cases-is_happy+.5));
run;
 
proc sgplot data=bins;
loess y=logit x=eduyrs;
yaxis label="Estimated logit";
run;
 
*Histogram co rok;
proc freq data=data;
tables eduyrs/out=eduyrs_freq;
run;
 
proc sgplot data=eduyrs_freq;
  vbar eduyrs/ response=percent;
  xaxis grid values=(1 to 43 by 1) fitpolicy=staggerthin;
run;
 
*Kategoryzacja;
data data_kat; 
set data_kat;
if eduyrs<=13 then eduyrs=1;
if eduyrs>13 then eduyrs=2;
run;
 
*Zmiana labeli po kategoryzacji;
proc format;
value eduyrs
1 = '13 years or less of education'
2 = 'More than 13 years of education';
run;
 
*Tablica kontyngencji i wykres słupkowy;
proc freq data=data_kat;
tables is_happy*eduyrs /   out=happy_eduyrs;
run;
 
proc sgplot data=happy_eduyrs;
vbar eduyrs/response=percent group=is_happy seglabel;
run;
 
/* .............................................................. */
 
******** Zmienna GNDR;
 
*Tablica kontyngencji i wykres słupkowy dla gndr;
proc freq data=data;
tables is_happy*gndr/   out=happy_gndr; run;
 
proc sgplot data=happy_gndr;
  vbar gndr / response=percent group=is_happy seglabel;
  run;
 
/* .............................................................. */
 
********* Zmienna SCLMEET;
 
*Tablica kontyngencji i wykres słupkowy przed kategoryzacją;
proc freq data=data;
tables is_happy*sclmeet/    out=happy_sclmeet; run;
 
proc sgplot data=happy_sclmeet;
  vbar sclmeet / response=percent group=is_happy seglabel;
  run;
 
*Kategoryzacja;
data data_kat;
set data_kat;
if sclmeet in (1,2,3,4) then sclmeet=1;
if sclmeet in (5,6) then sclmeet=2;
if sclmeet in (7) then sclmeet=3;
run;
 
*Zmiana labeli po kategoryzacji;
proc format;
value sclmeet
1 = 'Less than once a week'
2 = 'At least once a week'
3 = 'Every day';
run;
 
*Tablica kontyngencji i wykres słupkowy po kategoryzacji;
proc freq data=data_kat;
tables is_happy*sclmeet/    out=happy_sclmeet_kat; run;
 
proc sgplot data=happy_sclmeet_kat;
  vbar sclmeet / response=percent group=is_happy seglabel;
  run;
 
/* .............................................................. */
 
******** Zmienna UEMP3M;
 
*Tablica kontyngencji i wykres słupkowy;
proc freq data=data;
tables is_happy*uemp3m/   out=happy_uemp3m; run;
 
proc sgplot data=happy_uemp3m;
  vbar uemp3m / response=percent group=is_happy seglabel;
  run;
 
/* .............................................................. */
 
*********** Zmienna HEALTH;
 
*Tablica kontyngencji i wykres słupkowy;
proc freq data=data;
tables is_happy*health/    out=happy_health; run;
 
proc sgplot data=happy_health;
  vbar health / response=percent group=is_happy seglabel;
  run;
 
*Kategoryzacja;
data data_kat;
set data_kat;
if health in (3,4,5) then health=3;
run;
 
*Zmiana labeli po kategoryzacji;
proc format;
value health
1 = 'Very good'
2 = 'Good'
3 = 'Not good';
run;
 
*Tablica kontyngencji i wykres słupkowy po kategoryzacji;
proc freq data=data_kat;
tables is_happy*health/    out=happy_health_kat; run;
 
proc sgplot data=happy_health_kat;
  vbar health / response=percent group=is_happy seglabel;
  run;
 
/* .............................................................. */
 
******* Zmienna RLGBLG;
 
*Tablica kontyngencji i wykres słupkowy przed kategoryzacją;
proc freq data=data;
tables is_happy*rlgblg/    out=happy_rlgblg; run;
 
proc sgplot data=happy_rlgblg;
  vbar rlgblg / response=percent group=is_happy seglabel;
  run;
 
/* .............................................................. */
 
******* Zmienna EVMAR;
 
*Tablica kontyngencji i wykres słupkowy;
proc freq data=data;
tables is_happy*evmar/    out=happy_evmar; run;
 
proc sgplot data=happy_evmar;
  vbar evmar / response=percent group=is_happy seglabel;
  run;
 
/* .............................................................. */
 
********** Zmienna NETINUM;
 
*Podstawowe statystyki, histogram;
PROC means data=data mean stddev min max skewness kurtosis median q1 q3;
var netinum; run;
 
proc sgplot data=data;
histogram netinum;
run;
 
proc sort data=data;
by netinum;
run;
 
data data_kat;
set data_kat;
if netinum > 100000 then delete;
run;
 
*Empiryczny logit;
 
proc rank data=data_kat groups=40 out=ranks;
var netinum;
ranks bin;
run;
 
proc means data=ranks noprint nway;
class bin;
var is_happy netinum;
output out=bins sum(is_happy)=is_happy mean(netinum)=netinum n(is_happy)=cases;
run;
 
data bins;
set bins;
logit=log((is_happy+.5)/(cases-is_happy+.5));
run;
 
proc sgplot data=bins;
loess y=logit x=netinum;
yaxis label="Estimated logit";
run;
 
/* .............................................................. */
 
********** Zmienna BTHCLD;
 
*Tablica kontyngencji i wykres słupkowy - pełna zmienna child;
proc freq data=data;
tables is_happy*child/    out=vote_child; run;
 
proc sgplot data=vote_child;
  vbar child / response=percent group=is_happy seglabel
        datalabel;
  run;
 
*Tablica kontyngencji i wykres słupkowy - bthcld;
proc freq data=data;
tables is_happy*bthcld/    out=vote_bthcld; run;
 
proc sgplot data=vote_bthcld;
  vbar bthcld / response=percent group=is_happy seglabel
        datalabel;
  run;
 
/* .............................................................. */
 
******** Zmienna BLGETMG;
 
*Tablica kontyngencji i wykres słupkowy dla blgetmg ;
proc freq data=data;
tables is_happy*blgetmg/   out=happy_blgetmg; run;
 
proc sgplot data=happy_blgetmg;
  vbar blgetmg / response=percent group=is_happy seglabel;
  run;
 
/* .............................................................. */
 
*sprawdzenie czy output ok;
proc freq data=data_kat;
run;
 
*Zapisanie tabeli gotowej do przygotowania modelu;
*Wyrzucenie zmiennej child - zostaje tylko bthcld;
data data_ready (drop=child);
set data_kat;
run;
 
/* .............................................................. */
/*KOD CZĘŚĆ 3*/  
/* W części trzeciej przeanalizowano empiryczny logit zmiennej agea w celu dokonania przekształceń liniowych, sprawdzono współliniowość zmiennych procedurą tol i vif oraz zbadano potencjalne zmienne zakłócające w modelu bez interakcji */
 
 
/*Empiryczny logit agea*/
proc rank data=data_ready groups=40 out=ranks;
var agea;
ranks bin;
run;
 
proc means data=ranks noprint nway;
class bin;
var is_happy agea;
output out=bins sum(is_happy)=is_happy mean(agea)=agea n(is_happy)=cases;
run;
 
data bins;
set bins;
logit=log((is_happy+.5)/(cases-is_happy+.5));
run;
 
proc sgplot data=bins;
loess y=logit x=agea;
yaxis label="Estimated logit";
run;
 
/*Brak jednoznacznej postaci funkcyjnej*/
/*W kolejnych etapach zostaną sprawdzone przekształcenia wielomianowe*/
 
 
 
/*Badanie współliniowości procedurą reg i tol vif*/
 
proc reg data=data_ready;
model is_happy = nwspol sclmeet health rlgblg blgetmg evmar bthcld gndr
eduyrs uemp3m netinum agea / tol vif;
/*to model liniowy, nie ma znaczenia, że wrzucamy zmienną dychotomiczną. Robimy to tylko po to by mieć tol i vif*/
run;
 
/*Zmienne eduyrs i uemp3m - brak podstaw do odrzucenia H0 o niezależności*/
 
PROC FREQ data=data_ready;
    TABLE eduyrs*uemp3m / CHISQ;
RUN;
/*Zmienne eduyrs i bthcld - brak podstaw do odrzucenia H0 o niezależności*/
PROC FREQ data=data_ready;
    TABLE eduyrs*bthcld / CHISQ;
RUN;
/*Zmienne eduyrs i uemp3m - brak podstaw do odrzucenia H0 o niezależności*/
PROC FREQ data=data_ready;
    TABLE gndr*uemp3m / CHISQ;
RUN;
 
 
/*LOGIT*/
 
/* -------------------------------------------------------------------*/
 
ODS GRAPHICS ON;
 
%_eg_conditional_dropds(WORK.SORTTempTableSorted);
/* -------------------------------------------------------------------
   Sortowanie zbioru C:\Users\User\Desktop\SAS\RL\Projekt\data_ready.sas7bdat
   ------------------------------------------------------------------- */
 
PROC SQL;
CREATE VIEW WORK.SORTTempTableSorted AS
SELECT T.is_happy, T.netinum, T.agea, T.nwspol, T.sclmeet, T.health, T.rlgblg, T.blgetmg, T.evmar, T.bthcld, T.gndr, T.eduyrs, T.uemp3m
FROM data_ready as T
;
QUIT;
TITLE;
TITLE1 "Rezultaty regresji logistycznej";
FOOTNOTE;
FOOTNOTE1 "Wygenerowane przez SAS-a (&_SASSERVERNAME, &SYSSCPL) dnia %TRIM(%QSYSFUNC(DATE(), NLDATE20.)) o godz. %TRIM(%QSYSFUNC(TIME(), NLTIMAP25.))";
PROC LOGISTIC DATA=WORK.SORTTempTableSorted
PLOTS(ONLY)=ALL
;
CLASS nwspol 	(PARAM=REF ref='More than 60 minutes') sclmeet 	(PARAM=REF ref='Every day') health 	(PARAM=REF ref='Good') rlgblg 	(PARAM=REF ref='No') blgetmg 	(PARAM=REF ref='No') evmar 	(PARAM=REF ref='Yes') bthcld 	(PARAM=REF ref='Yes') gndr 	(PARAM=REF ref='Male') eduyrs 	(PARAM=REF ref='13 years or less of education') uemp3m 	(PARAM=REF ref='No');
MODEL is_happy (Event = '1')=netinum agea agea*agea agea*agea*agea agea*agea*agea*agea nwspol sclmeet health rlgblg blgetmg evmar bthcld gndr eduyrs uemp3m		/
SELECTION=NONE
LINK=LOGIT
;
RUN;
QUIT;
 
/* -------------------------------------------------------------------
   Koniec kodu zadania
   ------------------------------------------------------------------- */
RUN; QUIT;
%_eg_conditional_dropds(WORK.SORTTempTableSorted);
TITLE; FOOTNOTE;
ODS GRAPHICS OFF;
 
/* .............................................................. */
/*KOD CZĘŚĆ 4 – MODEL Z EFEKTAMI GŁÓWNYMI I INTERAKCJI*/
 
/* Model dla p-value = 0.05 */
ODS GRAPHICS ON;
 
%_eg_conditional_dropds(WORK.SORTTEMPTABLESORTED_0000);
/* -------------------------------------------------------------------
   Sortowanie zbioru Local:WORK.DATA_READY
   ------------------------------------------------------------------- */
 
PROC SQL;
CREATE VIEW WORK.SORTTEMPTABLESORTED_0000 AS
SELECT T.is_happy, T.agea, T.netinum, T.uemp3m, T.eduyrs, T.gndr, T.bthcld, T.evmar, T.blgetmg, T.rlgblg, T.health, T.sclmeet, T.nwspol
FROM WORK.DATA_READY as T
;
QUIT;
TITLE;
TITLE1 "Rezultaty regresji logistycznej";
FOOTNOTE;
FOOTNOTE1 "Generated by SAS (&_SASSERVERNAME, &SYSSCPL) on %TRIM(%QSYSFUNC(DATE(), NLDATE20.)) at %TRIM(%QSYSFUNC(TIME(), NLTIMAP25.))";
PROC LOGISTIC DATA=WORK.SORTTEMPTABLESORTED_0000
PLOTS(ONLY)=ALL
;
CLASS uemp3m 	(PARAM=REF ref='No') eduyrs 	(PARAM=REF ref='13 years or less of education') gndr 	(PARAM=REF ref='Male') bthcld 	(PARAM=REF ref='Yes') evmar 	(PARAM=REF ref='Yes') blgetmg 	(PARAM=REF ref='No') rlgblg 	(PARAM=REF ref='No') health 	(PARAM=REF ref='Good') sclmeet 	(PARAM=REF ref='Every day') nwspol 	(PARAM=REF ref='More than 60 minutes');
MODEL is_happy (Event = '1')=agea netinum uemp3m eduyrs gndr bthcld evmar blgetmg rlgblg health sclmeet nwspol agea*netinum agea*uemp3m agea*eduyrs agea*gndr agea*bthcld agea*evmar agea*blgetmg agea*rlgblg agea*health agea*sclmeet agea*nwspol netinum*uemp3m netinum*eduyrs netinum*gndr netinum*bthcld netinum*evmar netinum*blgetmg netinum*rlgblg netinum*health netinum*sclmeet netinum*nwspol uemp3m*eduyrs uemp3m*gndr uemp3m*bthcld uemp3m*evmar uemp3m*blgetmg uemp3m*rlgblg uemp3m*health uemp3m*sclmeet uemp3m*nwspol eduyrs*gndr eduyrs*bthcld eduyrs*evmar eduyrs*blgetmg eduyrs*rlgblg eduyrs*health eduyrs*sclmeet eduyrs*nwspol gndr*bthcld gndr*evmar gndr*blgetmg gndr*rlgblg gndr*health gndr*sclmeet gndr*nwspol bthcld*evmar bthcld*blgetmg bthcld*rlgblg bthcld*health bthcld*sclmeet bthcld*nwspol evmar*blgetmg evmar*rlgblg evmar*health evmar*sclmeet evmar*nwspol blgetmg*rlgblg blgetmg*health blgetmg*sclmeet blgetmg*nwspol rlgblg*health rlgblg*sclmeet rlgblg*nwspol health*sclmeet health*nwspol sclmeet*nwspol		/
SELECTION=STEPWISE
SLE=0.05
SLS=0.05
INCLUDE=12
LINK=LOGIT
;
RUN;
QUIT;
 
 
 
/* Model dla p-value = 0.1 */
ODS GRAPHICS ON;
 
%_eg_conditional_dropds(WORK.SORTTEMPTABLESORTED_0000);
/* -------------------------------------------------------------------
   Sortowanie zbioru Local:WORK.DATA_READY
   ------------------------------------------------------------------- */
 
PROC SQL;
CREATE VIEW WORK.SORTTEMPTABLESORTED_0000 AS
SELECT T.is_happy, T.agea, T.netinum, T.uemp3m, T.eduyrs, T.gndr, T.bthcld, T.evmar, T.blgetmg, T.rlgblg, T.health, T.sclmeet, T.nwspol
FROM WORK.DATA_READY as T
;
QUIT;
TITLE;
TITLE1 "Rezultaty regresji logistycznej";
FOOTNOTE;
FOOTNOTE1 "Generated by SAS (&_SASSERVERNAME, &SYSSCPL) on %TRIM(%QSYSFUNC(DATE(), NLDATE20.)) at %TRIM(%QSYSFUNC(TIME(), NLTIMAP25.))";
PROC LOGISTIC DATA=WORK.SORTTEMPTABLESORTED_0000
PLOTS(ONLY)=ALL
;
CLASS uemp3m 	(PARAM=REF ref='No') eduyrs 	(PARAM=REF ref='13 years or less of education') gndr 	(PARAM=REF ref='Male') bthcld 	(PARAM=REF ref='Yes') evmar 	(PARAM=REF ref='Yes') blgetmg 	(PARAM=REF ref='No') rlgblg 	(PARAM=REF ref='No') health 	(PARAM=REF ref='Good') sclmeet 	(PARAM=REF ref='Every day') nwspol 	(PARAM=REF ref='More than 60 minutes');
MODEL is_happy (Event = '1')=agea netinum uemp3m eduyrs gndr bthcld evmar blgetmg rlgblg health sclmeet nwspol agea*netinum agea*uemp3m agea*eduyrs agea*gndr agea*bthcld agea*evmar agea*blgetmg agea*rlgblg agea*health agea*sclmeet agea*nwspol netinum*uemp3m netinum*eduyrs netinum*gndr netinum*bthcld netinum*evmar netinum*blgetmg netinum*rlgblg netinum*health netinum*sclmeet netinum*nwspol uemp3m*eduyrs uemp3m*gndr uemp3m*bthcld uemp3m*evmar uemp3m*blgetmg uemp3m*rlgblg uemp3m*health uemp3m*sclmeet uemp3m*nwspol eduyrs*gndr eduyrs*bthcld eduyrs*evmar eduyrs*blgetmg eduyrs*rlgblg eduyrs*health eduyrs*sclmeet eduyrs*nwspol gndr*bthcld gndr*evmar gndr*blgetmg gndr*rlgblg gndr*health gndr*sclmeet gndr*nwspol bthcld*evmar bthcld*blgetmg bthcld*rlgblg bthcld*health bthcld*sclmeet bthcld*nwspol evmar*blgetmg evmar*rlgblg evmar*health evmar*sclmeet evmar*nwspol blgetmg*rlgblg blgetmg*health blgetmg*sclmeet blgetmg*nwspol rlgblg*health rlgblg*sclmeet rlgblg*nwspol health*sclmeet health*nwspol sclmeet*nwspol		/
SELECTION=STEPWISE
SLE=0.1
SLS=0.1
INCLUDE=12
LINK=LOGIT
;
RUN;
QUIT;
 
/* -------------------------------------------------------------------
   Koniec kodu zadania
   ------------------------------------------------------------------- */
RUN; QUIT;
%_eg_conditional_dropds(WORK.SORTTEMPTABLESORTED_0000);
TITLE; FOOTNOTE;
ODS GRAPHICS OFF;
 
/*KOD CZĘŚĆ 5 - FINALNY MODEL*/
 
/*KOD - FINALNY MODEL.
Finalny model regresji logistycznej z jedenastoma efektami głównymi i czterema interakcjami. Wyznaczone zostały statystyki dobroci dopasowania, testy istotności zmiennych oraz wykresy do detekcji obserwacji odstających i wpływowych. Za pomocą polecenia oddsratio wyliczony został iloraz szans dla zmiennej sclmeet znajdującej się w interakcji ze zmienną uemp3m. */

/* Model dla p-value = 0.1 */
ODS GRAPHICS ON;
 
%_eg_conditional_dropds(WORK.SORTTEMPTABLESORTED_0000);
/* -------------------------------------------------------------------
   Sortowanie zbioru Local:WORK.DATA_READY
   ------------------------------------------------------------------- */
 
PROC SQL;
CREATE VIEW WORK.SORTTEMPTABLESORTED_0000 AS
SELECT T.is_happy, T.agea, T.netinum, T.uemp3m, T.eduyrs, T.gndr, T.bthcld, T.evmar, T.blgetmg, T.rlgblg, T.health, T.sclmeet, T.nwspol
FROM WORK.DATA_READY as T
;
QUIT;
TITLE;
TITLE1 "Rezultaty regresji logistycznej";
FOOTNOTE;
FOOTNOTE1 "Generated by SAS (&_SASSERVERNAME, &SYSSCPL) on %TRIM(%QSYSFUNC(DATE(), NLDATE20.)) at %TRIM(%QSYSFUNC(TIME(), NLTIMAP25.))";
PROC LOGISTIC DATA=WORK.SORTTEMPTABLESORTED_0000
PLOTS(LABEL)=ALL
;
CLASS uemp3m 	(PARAM=REF ref='No') eduyrs 	(PARAM=REF ref='13 years or less of education') gndr 	(PARAM=REF ref='Male') bthcld 	(PARAM=REF ref='Yes') evmar 	(PARAM=REF ref='Yes') blgetmg 	(PARAM=REF ref='No') rlgblg 	(PARAM=REF ref='No') health 	(PARAM=REF ref='Good') sclmeet 	(PARAM=REF ref='Every day') nwspol 	(PARAM=REF ref='More than 60 minutes');
MODEL is_happy (Event = '1')=agea uemp3m eduyrs gndr bthcld evmar blgetmg rlgblg health sclmeet nwspol uemp3m*gndr uemp3m*sclmeet bthcld*evmar health*nwspol/
SLE=0.1
SLS=0.1
INCLUDE=12
LINK=LOGIT
INFLUENCE
LACKFIT
RSQUARE
CTABLE
CLPARM=WALD
CLODDS=WALD
ALPHA=0.1
expb
;
oddsratio uemp3m;
oddsratio sclmeet/at (uemp3m ="Yes");
RUN;
QUIT;
 
/* -------------------------------------------------------------------
   Koniec kodu zadania
   ------------------------------------------------------------------- */
RUN; QUIT;
%_eg_conditional_dropds(WORK.SORTTEMPTABLESORTED_0000);
TITLE; FOOTNOTE;
ODS GRAPHICS OFF;
 
/*To musi być ostatnia linijka*/
ods tagsets.excelxp close;
