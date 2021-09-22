library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity P1 is 
port(
 clk_sys : in std_logic;
 count_clk : in std_logic;
 scan_clk : in std_logic;
 scan : out std_logic_vector(1 downto 0);
 rst_en : in std_logic;
 data : out std_logic_vector(3 downto 0)
);
end P1;

architecture first of P1 is
signal enable : std_logic :='0';
signal data_tmp,data_tmp_1,data_tmp_2,data_tmp_3,data_tmp_4 : integer range 0 to 9;
signal scan_tmp : integer range 0 to 3;



begin
data <= std_logic_vector(to_unsigned(data_tmp, 4));
scan <= std_logic_vector(to_unsigned(scan_tmp, 2));
process (clk_sys)
begin

	if(rising_edge(clk_sys)) then
			enable <= '1';
	else
			enable <= '0';
	end if;
end process;
process(rst_en,clk_sys)
begin
	if(rst_en = '0') then
		if(rising_edge(count_clk) )then
			data_tmp_1 <= data_tmp_1+1;
			if(data_tmp_1 = data_tmp_1'high) then
				data_tmp_2 <= data_tmp_2 + 1 ;
				data_tmp_1 <= 0;
				if(data_tmp_2 = data_tmp_2'high) then
					data_tmp_3 <= data_tmp_3 + 1 ;
						data_tmp_2 <= 1;
					if(data_tmp_3 = data_tmp_3'high) then
						data_tmp_4 <= data_tmp_4 + 1 ;
						data_tmp_3 <= 0;
						if(data_tmp_4 = data_tmp_4'high) then
							data_tmp_4 <= 0;
						end if;
					end if;
				end if;
			end if;
		end if;
	if scan_tmp = 0 then
		data_tmp <= data_tmp_4;
	end if;
	if scan_tmp = 1 then
		data_tmp <= data_tmp_3;
	end if;
	if scan_tmp = 2 then
	data_tmp <= data_tmp_2;
	end if;
	if scan_tmp = 3 then
	data_tmp <= data_tmp_1;
	end if;
		if(rising_edge(scan_clk)) then
			scan_tmp <= scan_tmp + 1;
			if(scan_tmp = scan_tmp'high) then
				scan_tmp <= 0 ;
			end if;
		end if;
	else
		data_tmp <= 0;
		data_tmp_1 <= 0;
		data_tmp_2 <= 0;
		data_tmp_3 <= 0;
		data_tmp_4 <=0;
		scan_tmp <= 0;
	end if;
end process;

end first;
