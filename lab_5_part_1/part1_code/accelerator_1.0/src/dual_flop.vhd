-- Greg Stitt
-- University of Florida

library ieee;
use ieee.std_logic_1164.all;

entity dual is
  port (
    clk1    : in  std_logic;
    --clk2	: in  std_logic;
	rst    : in  std_logic;
    --load   : in  std_logic;
    input  : in  std_logic;
    output : out std_logic);
end dual;


architecture BHV of dual is
	signal input_flop_2 : std_logic;
	signal output_test : std_logic;
begin
    process(clk1, rst)
  begin
    if (rst = '1') then
      output   <= '0';
    elsif (clk1'event and clk1 = '1') then
		input_flop_2 <= input;
		output_test <= input_flop_2;
    end if;
	output <= output_test;
  end process;
end BHV;