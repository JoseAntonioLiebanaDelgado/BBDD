create or replacce type calculador as object(

resultat Number,
static function suma (a number, b number) return number,
static function resta (a number,b number) return number,
static function multilpicacio (a number, b number) return number,
static function divisio (a number,b number) return number    
); 

create or replace type body Calculadora as
static function suma (a number, b number) return number is
begin
return a+b;
end suma;
static function resta (a number,b number) return number is 
begin
return a-b;
end resta;
static function multiplicacio (a number, b number) return number is
begin
return a*b;
end multiplicacio;
static function divisio (a number,b number) return number is
begin
return a/b;
end divisio;
end;

/

declare
x number;
BEGIN
x := Calculadora.suma(2,3);
dbms_output.put_line(x);
x := Calculadora.resta(2,3);
dbms_output.put_line(x);
x := Calculadora.multiplicacio(2,3);
dbms_output.put_line(x);
x := Calculadora.divisio(2,3);
dbms_output.put_line(x);
END;





