--Control de 2 PWMs con salidas independientes por medio de un potenciometro
--motorizado que establece el ancho de pulso deseado por el usuario.
--El potenciometro cuenta del 0 al 99 tanto progresiva como regresivamente.
--En 0 se tiene el ancho de pulso minimo y en 99 el ancho de pulso maximo.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity pwms is
	port(	CLOCK_50: in std_logic;
			KEY: 	in std_logic_vector (3 downto 0);
			HEX0, HEX1, HEX2, HEX3: out std_logic_vector (6 downto 0);
			GPIO_1: out std_logic_vector (35 downto 0));
end pwms;

architecture comportamiento of pwms is
	--señales declaradas para el primer PWM
	signal cuenta: integer range 0 to 199;
	signal cuenta09: integer range 0 to 19;
	type estados is (encendido, apagado);
	signal estado_pr, sig_estado: estados;
	signal tempo: integer range 0 to 200;
	signal timeON: integer range 0 to 200;
	signal timeOFF: integer range 0 to 200;

	--señales declaradas para el segundo PWM
	signal cuenta1: integer range 0 to 199;
	signal cuenta091: integer range 0 to 19;
	type estados1 is (encendido1, apagado1);
	signal estado_pr1, sig_estado1: estados1;	
	signal tempo1: integer range 0 to 200;
	signal timeON1: integer range 0 to 200;
	signal timeOFF1: integer range 0 to 200;
	
	--señales que controlan la velocidad del potenciometro motorizado
	signal prescaler: integer range 0 to 50000000:= 0;
	signal auxclock: std_logic:= '1';
	
	--señales que controlan la frecuencia/periodo del PWM
	signal prescaler1: integer range 0 to 50000000:= 0;
	signal auxclock1: std_logic:= '1';

begin

	--tiempos del primer PWM
	timeON <= cuenta;
	timeOFF <= 200 - timeON;
	
	--tiempos del segundo PWM
	timeON1 <= cuenta1;
	timeOFF1 <= 200 - timeON1;

	--proceso para controlar la velocidad del potenciomentro motorizado
	process (CLOCK_50)
	begin
		if (CLOCK_50 'event and CLOCK_50 = '1') then
			if (prescaler < 7400000) then --se hicieron varias pruebas para encontrar el tiempo adecuado
				prescaler <= prescaler + 1;
				auxclock <= '1';
			else 
				prescaler <= 0;
				auxclock <= '0';
			end if;
		end if;	
	end process;
	
	--proceso para controlar el periodo/frecuencia del PWM
	process (CLOCK_50)
	begin
		if (CLOCK_50 'event and CLOCK_50 = '1') then
			if (prescaler1 < 11) then --50us
				prescaler1 <= prescaler1 + 1;
				auxclock1 <= '1';
			else 
				prescaler1 <= 0;
				auxclock1 <= '0';
			end if;
		end if;	
	end process;
	
	--se implementaron 2 cuentas, una del 0 al 199 y otra del 0 al 19
	--esto con el fin de ahorrar lineas de codigo, ya que el display menos significativo
	--solamente avanza o retrocede del 0 al 9 en un ciclo que se repite
	
	--contador del 0 al 199 (primer PWM)
	process (auxclock)
	begin
		if (auxclock 'event and auxclock='0') then
			if (KEY(0) = '0')	then --cuenta progresiva con el KEY 0
				if (cuenta < 199) then 
					cuenta <= cuenta + 1;
				else	
					cuenta <= 0;
				end if;
			else
				if (KEY(1) = '0') then --cuenta regresiva con el KEY 1
					if (cuenta > 0) then
						cuenta <= cuenta -1;
					else	
						cuenta <= 199;
					end if;
				end if;
			end if;
		end if;
	end process;
	
	--contador del 0 al 19 (primer PWM)
	process (auxclock)
	begin
		if (auxclock 'event and auxclock='0') then
			if (KEY(0) = '0')	then --cuenta progresiva con el KEY 0
				if (cuenta09 < 19) then
					cuenta09 <= cuenta09 + 1;
				else	
					cuenta09 <= 0;
				end if;
			else
				if (KEY(1) = '0') then --cuenta regresiva con el KEY 1
					if (cuenta09 > 0) then
						cuenta09 <= cuenta09 -1;
					else	
						cuenta09 <= 19;
					end if;
				end if;
			end if;
		end if;
	end process;
	
	--contador del 0 al 199 (segundo PWM)
	process (auxclock)
	begin
		if (auxclock 'event and auxclock='0') then
			if (KEY(2) = '0')	then --cuenta progresiva con el KEY 2
				if (cuenta1 < 199) then
					cuenta1 <= cuenta1 + 1;
				else	
					cuenta1 <= 0;
				end if;
			else
				if (KEY(3) = '0') then --cuenta regresiva con el KEY 3
					if (cuenta1 > 0) then
						cuenta1 <= cuenta1 -1;
					else	
						cuenta1 <= 199;
					end if;
				end if;
			end if;
		end if;
	end process;
	
	--contador del 0 al 19 (segundo PWM)
	process (auxclock)
	begin
		if (auxclock 'event and auxclock='0') then
			if (KEY(2) = '0')	then --cuenta regresiva con el KEY 2
				if (cuenta091 < 19) then
					cuenta091 <= cuenta091 + 1;
				else	
					cuenta091 <= 0;
				end if;
			else
				if (KEY(3) = '0') then --cuenta progresiva con el KEY 3
					if (cuenta091 > 0) then
						cuenta091 <= cuenta091 -1;
					else	
						cuenta091 <= 19;
					end if;
				end if;
			end if;
		end if;
	end process;
	
	--primer PWM
	--se utiliza la cuenta del 0 al 19 para el display menos significativo
	--se requiere presionar dos veces el KEY correspondiente para cambiar el numero que se muestra
	--es por ello que cada numero se repite dos veces
	HEX0 <= 	"1000000" when cuenta09 = 0 else --0
				"1000000" when cuenta09 = 1 else --0
				"1111001" when cuenta09 = 2 else --1
				"1111001" when cuenta09 = 3 else --1
				"0100100" when cuenta09 = 4 else --2
				"0100100" when cuenta09 = 5 else --2
				"0110000" when cuenta09 = 6 else --3
				"0110000" when cuenta09 = 7 else --3
				"0011001" when cuenta09 = 8 else --4
				"0011001" when cuenta09 = 9 else --4
				"0010010" when cuenta09 = 10 else --5
				"0010010" when cuenta09 = 11 else --5
				"0000010" when cuenta09 = 12 else --6
				"0000010" when cuenta09 = 13 else --6
				"1111000" when cuenta09 = 14 else --7
				"1111000" when cuenta09 = 15 else --7
				"0000000" when cuenta09 = 16 else --8
				"0000000" when cuenta09 = 17 else --8
				"0011000" when cuenta09 = 18 else --9
				"0011000" when cuenta09 = 19; --9
	
	--se utilizan operadores de comparacion ya que el mismo numero se mantiene estatico durante una decada
	--esto ahorra lineas de codigo
	HEX1 <= 	"1111111" when cuenta <= 19 else --apagado
				"1111001" when cuenta > 19 and cuenta <= 39 else --10
				"0100100" when cuenta > 39 and cuenta <= 59 else --20
				"0110000" when cuenta > 59 and cuenta <= 79 else --30
				"0011001" when cuenta > 79 and cuenta <= 99 else --40
				"0010010" when cuenta > 99 and cuenta <= 119 else --50				
				"0000010" when cuenta > 119 and cuenta <= 139 else --60
				"1111000" when cuenta > 139 and cuenta <= 159 else --70
				"0000000" when cuenta > 159 and cuenta <= 179 else --80
				"0011000"; --90
				
	--se repite el procedimiento para el segundo PWM			
	HEX2 <= 	"1000000" when cuenta091 = 0 else --0
				"1000000" when cuenta091 = 1 else --0
				"1111001" when cuenta091 = 2 else --1
				"1111001" when cuenta091 = 3 else --1
				"0100100" when cuenta091 = 4 else --2
				"0100100" when cuenta091 = 5 else --2
				"0110000" when cuenta091 = 6 else --3
				"0110000" when cuenta091 = 7 else --3
				"0011001" when cuenta091 = 8 else --4
				"0011001" when cuenta091 = 9 else --4
				"0010010" when cuenta091 = 10 else --5
				"0010010" when cuenta091 = 11 else --5
				"0000010" when cuenta091 = 12 else --6
				"0000010" when cuenta091 = 13 else --6
				"1111000" when cuenta091 = 14 else --7
				"1111000" when cuenta091 = 15 else --7
				"0000000" when cuenta091 = 16 else --8
				"0000000" when cuenta091 = 17 else --8
				"0011000" when cuenta091 = 18 else --9
				"0011000" when cuenta091 = 19; --9
				
	HEX3 <= 	"1111111" when cuenta1 <= 19 else --apagado
				"1111001" when cuenta1 > 19 and cuenta1 <= 39 else --1
				"0100100" when cuenta1 > 39 and cuenta1 <= 59 else --2
				"0110000" when cuenta1 > 59 and cuenta1 <= 79 else --3
				"0011001" when cuenta1 > 79 and cuenta1 <= 99 else --4
				"0010010" when cuenta1 > 99 and cuenta1 <= 119 else --5				
				"0000010" when cuenta1 > 119 and cuenta1 <= 139 else --6
				"1111000" when cuenta1 > 139 and cuenta1 <= 159 else --7
				"0000000" when cuenta1 > 159 and cuenta1 <= 179 else --8
				"0011000"; --9

	--codigo de la maquina de estados para el primer PWM
	process (auxclock1)
		variable cont: integer range 0 to 200;
	begin
		if (auxclock1 'event and auxclock1 = '0') then
			cont:=cont+1;
			if cont=tempo then --la maquina cambia de estado solo cuando 
			--se ha cumplido el tiempo establecido por el potenciometro
				estado_pr <= sig_estado; 
				cont:=0;
			end if;
		end if;
	end process;
	
	process (estado_pr)
	begin
		case estado_pr is
			when encendido =>
				GPIO_1(0) <= '1'; --la salida es 1 cuando se encuentra en el estado "encendido"
				sig_estado <= apagado;
				tempo <= timeON;
			when apagado =>
				GPIO_1(0) <= '0'; --la salida es 0 cuando se encuentra en el estado "apagado"
				sig_estado <= encendido;
				tempo <= timeOFF;
		end case;
	end process;
	
	--maquina de estados para el segundo PWM
	--se repite el procedimiento del primer PWM
	process (auxclock1)
		variable cont: integer range 0 to 200;
	begin
		if (auxclock1 'event and auxclock1 = '0') then
			cont:=cont+1;
			if cont=tempo1 then
				estado_pr1 <= sig_estado1;
				cont:=0;
			end if;
		end if;
	end process;
	
	process (estado_pr1)
	begin
		case estado_pr1 is
			when encendido1 =>
				GPIO_1(1) <= '1';
				sig_estado1 <= apagado1;
				tempo1 <= timeON1;
			when apagado1 =>
				GPIO_1(1) <= '0';
				sig_estado1 <= encendido1;
				tempo1 <= timeOFF1;
		end case;
	end process;
	
end comportamiento;