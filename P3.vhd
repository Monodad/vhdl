library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity P3 is 
port(
 clk_sys : in std_logic; --22
 sw : in std_logic_vector(2 downto 0);
 sec : in std_logic;    --27
 sec_rst : out std_logic; --6
 min_rst : in std_logic; --19
 min : out std_logic; --26
 dot : out std_logic;
 hr2 : out std_logic_vector(1 downto 0);
 hr1 : out std_logic_vector(3 downto 0)
);
end P3;

architecture first of P3 is
signal enable : std_logic :='0';
signal data_tmp : integer range 0 to 9;
signal scan_tmp : integer range 0 to 3;
signal second : integer range 0 to 59;
signal sw_t : std_logic_vector(2 downto 0);
signal hr_1 : integer range 0 to 9;
signal hr_2 : integer range 0 to 2;

begin
sw_t <= sw(2) & sw(1) & sw(0);
dot <= sec;
hr1 <= std_logic_vector(to_unsigned(hr_1, 4));
hr2 <= std_logic_vector(to_unsigned(hr_2, 2));
process (clk_sys,sec)
begin
	if(sw(0) = '0') then
		if (rising_edge(sec)) then
			if(second = second'HIGH)then
				second <= 0;
				min <= '1';
			else
				second <= second + 1 ;
				min <='0';
			end if;
		end if;
		if ( rising_edge(min_rst)) then
				if(hr_1 = hr_1'high) then
					hr_2 <= hr_2 +1;
					hr_1 <=0;
				else
					hr_1 <= hr_1 +1;
					

				end if;
		end if;
	else
		if(sw(1) = '1') then
			if(hr_1 = hr_1'high) then
					hr_2 <= hr_2 +1;
					hr_1 <=0;
			else
					hr_1 <= hr_1 +1;		
			end if;
		end if;
		if(sw(2)='1') then
			min<='1';
		else
			min <= '0';
			
		end if;
	end if;
		
	if (hr_2 = 2 and hr_1= 4) then
		hr_2 <= 0;
		hr_1 <= 0;
	end if;
end process;	

end first;