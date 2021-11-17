library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.itc.all;
use work.itc_lcd.all;

entity gen_font_test is
	port (
		-- system
		clk, rst_n : in std_logic;
		-- lcd
		lcd_sclk, lcd_mosi, lcd_ss_n, lcd_dc, lcd_bl, lcd_rst_n : out std_logic;
		-- sw
		sw : in u8r_t
	);
end gen_font_test;
architecture arch of gen_font_test is
begin
	gen_font_inst : entity work.gen_font(arch)
		port map(
	    x =>0,
			y          => 0,
			font_start => '1',
			font_busy  => open,
			clk        => clk,
			rst_n      => rst_n,
			data       => "0000000",
			text_color => red,
			bg_color   => black,
			clear      => '1',
			lcd_sclk   => lcd_sclk,
			lcd_mosi   => lcd_mosi,
			lcd_ss_n   => lcd_ss_n,
			lcd_dc     => lcd_dc,
			lcd_bl     => lcd_bl,
			lcd_rst_n  => lcd_rst_n
		);
end arch;
