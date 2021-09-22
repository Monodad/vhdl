library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
entity Vhdl2 is
port(
	sda_out,scl_out : inout std_logic;
	clk,reset_n : std_logic
);
end Vhdl2;



architecture first of Vhdl2 is
	signal data_read,data_write : std_logic_vector(7 downto 0);
	signal ena,r_or_w : std_logic;
	signal i2c_busy : std_logic;
	signal sda,scl : std_logic;
	signal error : std_logic;
	type state_t is (i2c_address,i2c_restart,i2c_restart_addr,i2c_read,i2c_stop);
	signal state : state_t;
	signal i2c_done,i2c_accept : std_logic;
	signal reset : std_logic;
	
	signal prev1,prev2 : std_logic;
begin
process(i2c_busy,clk)
	 begin
		prev1 <= i2c_busy;
		prev2 <= prev1;
		if(prev1 xor prev2) = '1' then
			if(i2c_busy = '1') then
				i2c_done <='1';
				i2c_accept <='0';
			else
				i2c_done <= '0';
				i2c_accept <='1';
			end if;
		end if;
end process;

i2c_inst : entity work.i2c_master(logic)

	port map(
	clk       =>  clk,                  --system clock
    reset_n   => reset,                --active low reset
    ena       => ena,                    --latch in command
    addr  	  => "1001000",              --address of target slave
    rw        => r_or_w,                 --'0' is write, '1' is read
    data_wr   => data_write,            --data to write to slave
    busy      => i2c_busy,       --indicates transaction in progress
    data_rd   => data_read, --data read from slave
    ack_error => error,                    --flag if improper acknowledge from slave
    sda       => sda_out,                    --serial data output of i2c bus
    scl       => scl_out
	);
	
process(clk,reset_n)
		begin
	if reset_n = '0' then
		ena <= '0';
		scl_out <= 'Z';
		sda_out <= 'Z';
		state <= i2c_address;
	elsif rising_edge(clk) then
		case state is 
			when i2c_address =>
				ena <= '1';
				r_or_w <= '0'; 
				if( i2c_done = '1') then
					state <= i2c_restart;
				end if;
			when i2c_restart => 
				if(i2c_accept = '1')then
					reset <='0';
					state <= i2c_restart_addr;
				end if;
			when i2c_restart_addr => 
				ena <= '1';
				r_or_w <= '1'; 
				if( i2c_done ='1') then
					state <= i2c_read;
				end if;
			when i2c_read => 
			when i2c_stop => 
			
		end case;
	end if;
		
	
	
	
	end process;
end first;